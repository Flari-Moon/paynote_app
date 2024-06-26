import 'dart:math' as math;

import 'package:meta/meta.dart' show required;

import "package:charts_common/common.dart"
    show
    Color,
    GraphicsFactory,
    TextDirection,
    TextElement,
    TextStyle,
    ChartCanvas,
    TextStyleSpec,
    ImmutableBarRendererElement,
    BarRendererDecorator;
import "package:charts_common/src/data/series.dart" show AccessorFn;
import "package:charts_flutter/src/chart_canvas.dart" as Canvasee;
import "package:charts_common/common.dart" as comm;

class CustomBarRenderer<D> extends BarRendererDecorator<D> {
  // Default configuration
  static const _defaultLabelPosition = BarLabelPosition.auto;
  static const _defaultLabelPadding = 5;
  static const _defaultHorizontalLabelAnchor = BarLabelAnchor.start;
  static const _defaultVerticalLabelAnchor = BarLabelAnchor.end;
  static final _defaultInsideLabelStyle =
  new TextStyleSpec(fontSize: 12, color: Color.white);
  static final _defaultOutsideLabelStyle =
  new TextStyleSpec(fontSize: 12, color: Color.black);
  static final _labelSplitPattern = '\n';
  static final _defaultMultiLineLabelPadding = 2;

  /// Configures [TextStyleSpec] for labels placed inside the bars.
  final TextStyleSpec insideLabelStyleSpec;

  /// Configures [TextStyleSpec] for labels placed outside the bars.
  final TextStyleSpec outsideLabelStyleSpec;

  /// Configures where to place the label relative to the bars.
  final BarLabelPosition labelPosition;

  /// For labels drawn inside the bar, configures label anchor position.
  final BarLabelAnchor labelAnchor;

  /// Space before and after the label text.
  final int labelPadding;

  CustomBarRenderer(
      {TextStyleSpec insideLabelStyleSpec,
        TextStyleSpec outsideLabelStyleSpec,
        this.labelAnchor = null,
        this.labelPosition = _defaultLabelPosition,
        this.labelPadding = _defaultLabelPadding})
      : insideLabelStyleSpec = insideLabelStyleSpec ?? _defaultInsideLabelStyle,
        outsideLabelStyleSpec =
            outsideLabelStyleSpec ?? _defaultOutsideLabelStyle;

  @override
  void decorate(Iterable<ImmutableBarRendererElement<D>> barElements,
      comm.ChartCanvas canvas, GraphicsFactory graphicsFactory,
      {@required math.Rectangle drawBounds,
        @required double animationPercent,
        @required bool renderingVertically,
        bool rtl = false}) {
    // Only decorate the bars when animation is at 100%.
    if (animationPercent != 1.0) {
      return;
    }
    /* final newCanvas = canvas as Canvasee.ChartCanvas;
    final canvee =
        ChartCanvasWorkAround(newCanvas.canvas, newCanvas.graphicsFactory); */

    if (renderingVertically) {
      _decorateVerticalBars(
          barElements, canvas, graphicsFactory, drawBounds, rtl);
    } else {
      _decorateHorizontalBars(
          barElements, canvas, graphicsFactory, drawBounds, rtl);
    }
  }

  void _decorateVerticalBars(
      Iterable<ImmutableBarRendererElement<D>> barElements,
      ChartCanvas canvas,
      GraphicsFactory graphicsFactory,
      math.Rectangle drawBounds,
      bool rtl) {
    // Create [TextStyle] from [TextStyleSpec] to be used by all the elements.
    // The [GraphicsFactory] is needed so it can't be created earlier.
    final insideLabelStyle =
    _getTextStyle(graphicsFactory, insideLabelStyleSpec);
    final outsideLabelStyle =
    _getTextStyle(graphicsFactory, outsideLabelStyleSpec);

    for (var element in barElements) {
      final labelFn = element.series.labelAccessorFn;
      final datumIndex = element.index;
      final label = (labelFn != null) ? labelFn(datumIndex) : null;

      // If there are custom styles, use that instead of the default or the
      // style defined for the entire decorator.
      final datumInsideLabelStyle = _getDatumStyle(
          element.series.insideLabelStyleAccessorFn,
          datumIndex,
          graphicsFactory,
          defaultStyle: insideLabelStyle);
      final datumOutsideLabelStyle = _getDatumStyle(
          element.series.outsideLabelStyleAccessorFn,
          datumIndex,
          graphicsFactory,
          defaultStyle: outsideLabelStyle);

      // Skip calculation and drawing for this element if no label.
      if (label == null || label.isEmpty) {
        continue;
      }

      var labelElements = label
          .split(_labelSplitPattern)
          .map((labelPart) => graphicsFactory.createTextElement(labelPart));

      final bounds = element.bounds;

      // Get space available inside and outside the bar.
      final totalPadding = labelPadding * 2;
      final insideBarHeight = bounds.height - totalPadding;
      final outsideBarHeight = drawBounds.height - bounds.height - totalPadding;

      var calculatedLabelPosition = labelPosition;
      if (calculatedLabelPosition == BarLabelPosition.auto) {
        // For auto, first try to fit the text inside the bar.
        labelElements = labelElements.map(
                (labelElement) => labelElement..textStyle = datumInsideLabelStyle);

        final labelMaxWidth = labelElements
            .map(
                (labelElement) => labelElement.measurement.horizontalSliceWidth)
            .fold(0, (max, current) => max > current ? max : current);

        // Total label height depends on the label element's text style.
        final totalLabelHeight = _getTotalLabelHeight(labelElements);

        // A label fits if the length and width of the text fits.
        calculatedLabelPosition =
        totalLabelHeight < insideBarHeight && labelMaxWidth < bounds.width
            ? BarLabelPosition.inside
            : BarLabelPosition.outside;
      }

      // Set the max width, text style, and text direction.
      labelElements = labelElements.map((labelElement) => labelElement
        ..textStyle = calculatedLabelPosition == BarLabelPosition.inside
            ? datumInsideLabelStyle
            : datumOutsideLabelStyle
        ..maxWidth = bounds.height * 100
        ..textDirection = rtl ? TextDirection.rtl : TextDirection.ltr);

      // Total label height depends on the label element's text style.
      final totalLabelHeight = _getTotalLabelHeight(labelElements);

      var labelsDrawn = 0;
      for (var labelElement in labelElements) {
        // Calculate the start position of label based on [labelAnchor].
        int labelY;
        final labelHeight = labelElement.measurement.verticalSliceWidth.round();
        final offsetHeight =
            (labelHeight + _defaultMultiLineLabelPadding) * labelsDrawn;

        if (calculatedLabelPosition == BarLabelPosition.inside) {
          final _labelAnchor = labelAnchor ?? _defaultVerticalLabelAnchor;
          switch (_labelAnchor) {
            case BarLabelAnchor.end:
              labelY = bounds.top + labelPadding + offsetHeight;
              break;
            case BarLabelAnchor.middle:
              labelY = (bounds.bottom -
                  bounds.height / 2 -
                  totalLabelHeight / 2 +
                  offsetHeight)
                  .round();
              break;
            case BarLabelAnchor.start:
              labelY = bounds.bottom -
                  labelPadding -
                  totalLabelHeight +
                  offsetHeight;
              break;
          }
        } else {
          // calculatedLabelPosition == LabelPosition.outside
          labelY = bounds.top - labelPadding - totalLabelHeight + offsetHeight;
        }

        // Center the label inside the bar.
        int labelX = (bounds.left +
            bounds.width / 2 -
            labelElement.measurement.horizontalSliceWidth / 2)
            .round();
        labelX = labelX +
            (labelElement.measurement.horizontalSliceWidth / 2.5).round();

        canvas.drawText(labelElement, labelX, labelY, rotation: -math.pi / 2);
        labelsDrawn += 1;
      }
    }
  }

  void _decorateHorizontalBars(
      Iterable<ImmutableBarRendererElement<D>> barElements,
      ChartCanvas canvas,
      GraphicsFactory graphicsFactory,
      math.Rectangle drawBounds,
      bool rtl) {
    // Create [TextStyle] from [TextStyleSpec] to be used by all the elements.
    // The [GraphicsFactory] is needed so it can't be created earlier.
    final insideLabelStyle =
    _getTextStyle(graphicsFactory, insideLabelStyleSpec);
    final outsideLabelStyle =
    _getTextStyle(graphicsFactory, outsideLabelStyleSpec);

    for (var element in barElements) {
      final labelFn = element.series.labelAccessorFn;
      final datumIndex = element.index;
      final label = (labelFn != null) ? labelFn(datumIndex) : null;

      // If there are custom styles, use that instead of the default or the
      // style defined for the entire decorator.
      final datumInsideLabelStyle = _getDatumStyle(
          element.series.insideLabelStyleAccessorFn,
          datumIndex,
          graphicsFactory,
          defaultStyle: insideLabelStyle);
      final datumOutsideLabelStyle = _getDatumStyle(
          element.series.outsideLabelStyleAccessorFn,
          datumIndex,
          graphicsFactory,
          defaultStyle: outsideLabelStyle);

      // Skip calculation and drawing for this element if no label.
      if (label == null || label.isEmpty) {
        continue;
      }

      final bounds = element.bounds;

      // Get space available inside and outside the bar.
      final totalPadding = labelPadding * 2;
      final insideBarWidth = bounds.width - totalPadding;
      final outsideBarWidth = drawBounds.width - bounds.width - totalPadding;

      final labelElement = graphicsFactory.createTextElement(label);
      var calculatedLabelPosition = labelPosition;
      if (calculatedLabelPosition == BarLabelPosition.auto) {
        // For auto, first try to fit the text inside the bar.
        labelElement.textStyle = datumInsideLabelStyle;

        // A label fits if the space inside the bar is >= outside bar or if the
        // length of the text fits and the space. This is because if the bar has
        // more space than the outside, it makes more sense to place the label
        // inside the bar, even if the entire label does not fit.
        calculatedLabelPosition = (insideBarWidth >= outsideBarWidth ||
            labelElement.measurement.horizontalSliceWidth < insideBarWidth)
            ? BarLabelPosition.inside
            : BarLabelPosition.outside;
      }

      // Set the max width and text style.
      if (calculatedLabelPosition == BarLabelPosition.inside) {
        labelElement.textStyle = datumInsideLabelStyle;
        labelElement.maxWidth = insideBarWidth;
      } else {
        // calculatedLabelPosition == LabelPosition.outside
        labelElement.textStyle = datumOutsideLabelStyle;
        labelElement.maxWidth = outsideBarWidth;
      }

      // Only calculate and draw label if there's actually space for the label.
      if (labelElement.maxWidth > 0) {
        // Calculate the start position of label based on [labelAnchor].
        int labelX;
        if (calculatedLabelPosition == BarLabelPosition.inside) {
          final _labelAnchor = labelAnchor ?? _defaultHorizontalLabelAnchor;
          switch (_labelAnchor) {
            case BarLabelAnchor.middle:
              labelX = (bounds.left +
                  bounds.width / 2 -
                  labelElement.measurement.horizontalSliceWidth / 2)
                  .round();
              labelElement.textDirection =
              rtl ? TextDirection.rtl : TextDirection.ltr;
              break;

            case BarLabelAnchor.end:
            case BarLabelAnchor.start:
              final alignLeft = rtl
                  ? (_labelAnchor == BarLabelAnchor.end)
                  : (_labelAnchor == BarLabelAnchor.start);

              if (alignLeft) {
                labelX = bounds.left + labelPadding;
                labelElement.textDirection = TextDirection.ltr;
              } else {
                labelX = bounds.right - labelPadding;
                labelElement.textDirection = TextDirection.rtl;
              }
              break;
          }
        } else {
          // calculatedLabelPosition == LabelPosition.outside
          labelX = bounds.right + labelPadding;
          labelElement.textDirection = TextDirection.ltr;
        }

        // Center the label inside the bar.
        final labelY = (bounds.top +
            (bounds.bottom - bounds.top) / 2 -
            labelElement.measurement.verticalSliceWidth / 2)
            .round();

        canvas.drawText(labelElement, labelX, labelY);
      }
    }
  }

  /// Helper function to get the total height for a group of labels.
  /// This includes the padding in between the labels.
  int _getTotalLabelHeight(Iterable<TextElement> labelElements) =>
      (labelElements.first.measurement.verticalSliceWidth *
          labelElements.length)
          .round() +
          _defaultMultiLineLabelPadding * (labelElements.length - 1);

  // Helper function that converts [TextStyleSpec] to [TextStyle].
  TextStyle _getTextStyle(
      GraphicsFactory graphicsFactory, TextStyleSpec labelSpec) {
    return graphicsFactory.createTextPaint()
      ..color = labelSpec?.color ?? Color.black
      ..fontFamily = labelSpec?.fontFamily
      ..fontSize = labelSpec?.fontSize ?? 12
      ..lineHeight = labelSpec?.lineHeight;
  }

  /// Helper function to get datum specific style
  TextStyle _getDatumStyle(AccessorFn<TextStyleSpec> labelFn, int datumIndex,
      GraphicsFactory graphicsFactory,
      {TextStyle defaultStyle}) {
    final styleSpec = (labelFn != null) ? labelFn(datumIndex) : null;
    return (styleSpec != null)
        ? _getTextStyle(graphicsFactory, styleSpec)
        : defaultStyle;
  }
}

/// Configures where to place the label relative to the bars.
enum BarLabelPosition {
  /// Automatically try to place the label inside the bar first and place it on
  /// the outside of the space available outside the bar is greater than space
  /// available inside the bar.
  auto,

  /// Always place label on the outside.
  outside,

  /// Always place label on the inside.
  inside,
}

/// Configures where to anchor the label for labels drawn inside the bars.
enum BarLabelAnchor {
  /// Anchor to the measure start.
  start,

  /// Anchor to the middle of the measure range.
  middle,

  /// Anchor to the measure end.
  end,
}
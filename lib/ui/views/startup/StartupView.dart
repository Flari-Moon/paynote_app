import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/Constants.dart';
import 'package:stacked/stacked.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';

import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'StartupViewModel.dart';

class StartupView extends StatelessWidget {
  final List<Slide> slides = new List();

  Function goToTab;
  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  createSlides() {
    slides.add(
      new Slide(
        title: "Keep it together with Paynote",
        styleTitle: TextStyle(
            color: AppColors.brandBlue,
            fontSize: 90.nsp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Alata'),
        description: "Spending money comfortably with duly budgetting.",
        styleDescription: TextStyle(
            color: AppColors.brandMediumGrey,
            fontSize: 48.nsp,
            // fontStyle: FontStyle.italic,
            fontFamily: 'Roboto'),
        pathImage: "Assets/Illustrations/Tech_1.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Connect all your bank accounts",
        styleTitle: TextStyle(
            color: AppColors.brandBlue,
            fontSize: 90.nsp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Alata'),
        description:
            "Any bank! Shared account? Add them too and manage them together.",
        styleDescription: TextStyle(
            color: AppColors.brandMediumGrey,
            fontSize: 48.nsp,
            // fontStyle: FontStyle.italic,
            fontFamily: 'Roboto'),
        pathImage: "Assets/Illustrations/Tech_2.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Get insights on your spending",
        styleTitle: TextStyle(
            color: AppColors.brandBlue,
            fontSize: 90.nsp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Alata'),
        description:
            "Find your fixed expenses and get an overview of your patterns. We will help you find patterns and smart savers!",
        styleDescription: TextStyle(
            color: AppColors.brandMediumGrey,
            fontSize: 48.nsp,
            // fontStyle: FontStyle.italic,
            fontFamily: 'Roboto'),
        pathImage: "Assets/Illustrations/Tech_3.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Set goals and we will support you",
        styleTitle: TextStyle(
            color: AppColors.brandBlue,
            fontSize: 90.nsp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Alata'),
        description:
            "Save money by setting goals and get advice! And why not set financial goals together?!",
        styleDescription: TextStyle(
            color: AppColors.brandMediumGrey,
            fontSize: 48.nsp,
            // fontStyle: FontStyle.italic,
            fontFamily: 'Roboto'),
        pathImage: "Assets/Illustrations/Tech_4.png",
      ),
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs(BuildContext context) {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 5.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  overflow: TextOverflow.clip,
                ),
                margin: EdgeInsets.only(bottom: 100.0),
              ),
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.25,
                fit: BoxFit.contain,
              )),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    createSlides();

    return ViewModelBuilder<StartupViewModel>.reactive(
      // onModelReady: (model) => model.handleStarupLogic(),
      builder: (context, model, child) {
        return Container(
          color: AppColors.brandWhite,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.95,
                padding: const EdgeInsets.all(10),
                child: IntroSlider(
                  // List slides
                  slides: this.slides,

                  // Dot indicator
                  colorDot: AppColors.brandLightGrey,

                  colorActiveDot: AppColors.brandLightBlue,

                  sizeDot: 10.0,
                  // typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

                  // Tabs
                  listCustomTabs: this.renderListCustomTabs(context),
                  backgroundColorAllSlides: AppColors.brandWhite,
                  refFuncGoToTab: (refFunc) {
                    this.goToTab = refFunc;
                  },

                  // Show or hide status bar
                  shouldHideStatusBar: false,

                  // On tab change completed
                  onTabChangeCompleted: onTabChangeCompleted,
                ),
              ),
              RaisedButton(
                  elevation: 0,
                  color: AppColors.brandBlue,
                  onPressed: () {
                    print("Test");
                    model.verifyPhoneNumber();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                        child: Text(
                      // "Sign up",
                      model.pageLanguageData["SIN-0-20"][0]
                          [model.userLanguage.language],
                      style: TextStyle(
                          color: AppColors.brandWhite,
                          fontFamily: 'Alata',
                          fontSize: 58.nsp,
                          fontWeight: FontWeight.w400),
                    )),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              OutlineButton(
                  highlightColor: AppColors.brandLightGrey,
                  borderSide: BorderSide(color: AppColors.brandBlue),
                  onPressed: () {
                    model.goToLogin();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                        child: Text(
                      //"Log in",
                      model.pageLanguageData["SIN-0-30"][0]
                          [model.userLanguage.language],
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontFamily: 'Alata',
                          fontSize: 58.nsp,
                          fontWeight: FontWeight.w400),
                    )),
                  ))
            ],
          ),
        );
      },
      onModelReady: (model) => model.initLanguage(),
      viewModelBuilder: () => StartupViewModel(),
    );
  }

  onTabChangeCompleted() {}
}

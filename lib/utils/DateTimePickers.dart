import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';

// For changing the language

// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

const appName = 'DateTimeField Example';

class BasicDateField extends StatelessWidget {
  BasicDateField({this.text, this.date, this.controller});
  String text, date;
  final TextEditingController controller;
  final format = DateFormat("dd - MM - yyyy");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.brandDarkGrey,
              fontSize: 30.nsp,
            ),
          ),
        ),
        DateTimeField(
          style: TextStyle(color: AppColors.brandDarkGrey),
          format: format,
          initialValue: DateTime.now(),
          //  controller: controller,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none),
            ),
          ),
          onChanged: (currentValue) {
            //print('DATE $currentValue');
            this.date = currentValue.toString();
          },
          onShowPicker: (context, currentValue) {
            //print('DATE $date');
            date = currentValue.toString();
            return showDatePicker(
                context: context,
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
                initialDate: DateTime.now());
          },
        ),
      ],
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}

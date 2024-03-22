import 'package:flutter/material.dart';
import 'package:paynote_app/Api/RecurringData.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';

class OverLayWidget extends StatelessWidget{
  OverLayWidget({
    this.title,this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return  SizedBox.expand(
      child:Container(
      color: AppColors.brandWhite.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child:  Image.asset('Assets/Illustrations/Tech_loading.png')),
          Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(title, style: TextStyle(fontSize: 26, color: AppColors.brandBlue,
                  fontFamily: 'Alata'),)),
          Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.brandDarkGrey, fontFamily: 'Roboto'),)
          ),
        ],
      ),),);
  }
}
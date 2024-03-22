import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/utils/paynote_icons.dart';
import 'package:flutter_screenutil/size_extension.dart';

class TermsOfUsePage extends StatefulWidget {
  TermsOfUsePage({this.lastTOupdate, this.dataTO});

  final String lastTOupdate;
  final List dataTO;

  List _mockedTOData = [
    [
      'Accepting',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elitsed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    ],
    [
      'Changes in the terms',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'Using our product',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'General restrictions',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'Liability policy',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt augue interdum velit euismod in pellentesque massa placerat. Quam id leo in vitae turpis massa sed. Et leo duis ut diam quam nulla porttitor massa. In tellus integer feugiat scelerisque varius. Ultricies integer quis auctor elit sed. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Diam ut venenatis tellus in metus vulputate eu scelerisque felis. Elementum nisi quis eleifend quam adipiscing vitae proin sagittis. Nisi vitae suscipit tellus mauris a diam maecenas sed. Nunc sed blandit libero volutpat sed cras ornare arcu. Ac placerat vestibulum lectus mauris ultrices. Eget dolor morbi non arcu risus. Ut faucibus pulvinar elementum integer enim neque volutpat. Feugiat sed lectus vestibulum mattis ullamcorper velit. Posuere ac ut consequat semper viverra nam libero justo. In fermentum posuere urna nec tincidunt praesent semper feugiat nibh.'
    ],
    [
      'Your right',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus sed viverra tellus in. Venenatis cras sed felis eget velit. Aliquet lectus proin nibh nisl condimentum id. Faucibus scelerisque eleifend donec pretium vulputate sapien nec.'
    ],
    [
      'General legal terms',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus sed viverra tellus in. Venenatis cras sed felis eget velit. Aliquet lectus proin nibh nisl condimentum id. Faucibus scelerisque eleifend donec pretium vulputate sapien nec.'
    ],
  ];

  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUsePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(80.w, 80.h, 80.w, 80.h),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
                color: AppColors.brandWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Material(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Profile",
                          style: TextStyle(
                              color: AppColors.brandDarkGrey,
                              fontFamily: "Alata",
                              fontSize: 48.nsp)),
                      Expanded(child: SizedBox()),
                      IconButton(
                        splashRadius: 60,
                        focusColor: AppColors.brandDarkGrey,
                        icon: Icon(PaynoteIcons.close_outline, size: 35),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      "Terms of Use",
                      style: TextStyle(
                          color: AppColors.brandBlue,
                          fontSize: 60.nsp,
                          fontFamily: "Alata"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      "Last updated on ${widget.lastTOupdate}",
                      style: TextStyle(
                          color: AppColors.brandDarkGrey,
                          fontSize: 38.nsp,
                          fontFamily: "Alata"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: widget._mockedTOData.length,
                        itemBuilder: (context, i) {
                          return new Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  widget._mockedTOData[i][0],
                                  style: new TextStyle(
                                      fontSize: 54.nsp,
                                      color: AppColors.brandBlue,
                                      fontFamily: "Alata"),
                                )),
                                SizedBox(height: 20.h),
                                Text(
                                  widget._mockedTOData[i][1],
                                  style: TextStyle(
                                      color: AppColors.brandDarkGrey,
                                      fontSize: 43.nsp),
                                ),
                                SizedBox(height: 40.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

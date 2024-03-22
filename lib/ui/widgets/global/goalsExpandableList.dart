import 'package:flutter/material.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:flutter_screenutil/size_extension.dart';

class GoalsExpandableList extends StatelessWidget {
  const GoalsExpandableList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Ongoing goals",
        style: TextStyle(
            fontFamily: "Alata",
            color: AppColors.brandDarkGrey,
            fontSize: 52.nsp),
      ),
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.data[0][0]["GoalsData"].length,
              itemBuilder: (context, i) {
                return new Row(children: [
                  Container(width: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: RaisedButton(
                      color: AppColors.brandWhite,
                      onPressed: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${this.data[0][0]["GoalsData"][i]["Name"]}",
                                  style: TextStyle(
                                      color: AppColors.brandBlue,
                                      fontSize: 45.nsp,
                                      fontFamily: 'Alata'),
                                ),
                                Text(
                                  "Total ${this.data[1][0]} ${this.data[0][0]["GoalsData"][i]["TotalValue"]}",
                                  style: TextStyle(
                                      color: AppColors.brandDarkGrey,
                                      fontSize: 38.nsp,
                                      fontFamily: 'Alata'),
                                ),
                              ],
                            ),
                            Text(
                                "${this.data[1][0]} ${this.data[0][0]["GoalsData"][i]["currentValue"]}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 62.nsp,
                                    color: AppColors.brandBlue))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(width: 15),
                ]);
              }),
        )
      ],
    );
  }
}
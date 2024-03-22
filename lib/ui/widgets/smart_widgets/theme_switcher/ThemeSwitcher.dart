import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:stacked/stacked.dart';

import 'ThemeSwitcherViewModel.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ThemeSwitcherViewModel>.reactive(
      builder: (context, model, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Light mode',
            style: TextStyle(
              fontSize: 38.nsp,
            ),
          ),
          Switch.adaptive(
            value: model.isDarkMode,
            onChanged: model.updateTheme,
          ),
          Text(
              'Dark Mode',
            style: TextStyle(
              fontSize: 38.nsp,
            ),
          ),
        ],
      ),
      viewModelBuilder: () => ThemeSwitcherViewModel(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paynote_app/ui/widgets/smart_widgets/theme_switcher/ThemeSwitcher.dart';
import 'package:stacked/stacked.dart';

import 'HomeViewModel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Switch theme with theme switcher',
                style: Theme.of(context).textTheme.headline3,
              ),
              Center(
                child: ThemeSwitcher(),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

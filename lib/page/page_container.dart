import 'package:flutter/material.dart';
import 'package:weather_study/models/src/app_settings.dart';
import 'package:weather_study/page/forecast_page.dart';
import 'package:weather_study/page/settings_page.dart';
import 'package:weather_study/styles.dart';
import 'package:weather_study/utils/forecast_animation_utils.dart';

class PageContainer extends StatefulWidget {
  final AppSettings settings;

  const PageContainer({Key key, this.settings}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState(settings);
}

class _PageContainerState extends State<PageContainer> {
  AppSettings settings;

  _PageContainerState(this.settings);

  void _showSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          settings: settings,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ForecastPage(
      menu: PopupMenuButton(
        elevation: 0.0,
        icon: const Icon(
          Icons.location_city,
          color: AppColor.textColorDark,
        ),
        onSelected: (selection) {
          setState(() {
            settings.activeCity = allAddedCities.firstWhere((city) => city.name == selection);
          });
        },
        itemBuilder: (BuildContext context) {
          return allAddedCities
              .where((city) => city.active)
              .map((City city) => PopupMenuItem(
                    value: city.name,
                    child: Text(city.name),
                  ))
              .toList();
        },
      ),
      settingsButton: FlatButton(
          child: Text(
            AnimationUtil.temperatureLabels[settings.selectedTemperature],
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: _showSettingsPage),
      settings: settings,
    );
  }
}

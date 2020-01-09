import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:muhammadfurqan_clock/clock_widget.dart';
import 'package:muhammadfurqan_clock/loc_temp_widget.dart';
import 'package:muhammadfurqan_clock/weather_widget.dart';

const _assetPrefix = "assets/imgs/";

const _skyMorningStartColor = const Color.fromRGBO(196, 255, 255, 1);
const _skyNoonStartColor = const Color.fromRGBO(255, 233, 160, 1);
const _skyNightStartColor = const Color.fromRGBO(106, 100, 164, 1);
const _skyEndColor = const Color.fromRGBO(251, 216, 209, 1);

const _morningSkyGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    _skyMorningStartColor,
    _skyEndColor,
  ],
  tileMode: TileMode.repeated,
);

const _noonSkyGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    _skyNoonStartColor,
    _skyEndColor,
  ],
  tileMode: TileMode.repeated,
);

const _nightSkyGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    _skyNightStartColor,
    _skyEndColor,
  ],
  tileMode: TileMode.repeated,
);

const _ambientSkyGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.grey,
    Colors.black,
  ],
  tileMode: TileMode.repeated,
);

const _forecastAssetsName = {
  WeatherCondition.cloudy: "weather_cloudy.png",
  WeatherCondition.foggy: "",
  WeatherCondition.rainy: "weather_rainy.png",
  WeatherCondition.snowy: "weather_snowy.png",
  WeatherCondition.sunny: "",
  WeatherCondition.thunderstorm: "weather_thunderstorm.png",
  WeatherCondition.windy: "",
  "sun": "obj_sun.png",
  "moon": "obj_moon.png",
};

class FurqanClock extends StatefulWidget {
  final ClockModel model;

  const FurqanClock(this.model);

  @override
  _FurqanClockState createState() => _FurqanClockState();
}

class _FurqanClockState extends State<FurqanClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(FurqanClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hourInt = int.parse(DateFormat('HH').format(_dateTime));
    final decoration = (Theme.of(context).brightness == Brightness.light)
        ? _getLightDecoration(hourInt)
        : _ambientSkyGradient;
    final objSunMoon = _getSunMoonObject(hourInt);

    return Container(
        decoration: BoxDecoration(gradient: decoration),
        child: Stack(
          children: <Widget>[
            WeatherWidget(
              "$_assetPrefix$objSunMoon",
              "$_assetPrefix${_forecastAssetsName[widget.model.weatherCondition]}",
            ),
            Center(
              child: ClockWidget(
                dateTime: _dateTime,
                is24HourFormat: widget.model.is24HourFormat,
              ),
            ),
            LocTempWidget(
              location: widget.model.location,
              temp: widget.model.temperatureString,
            )
          ],
        ));
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  LinearGradient _getLightDecoration(int hour) {
    if (hour >= 4 && hour <= 10) {
      // 4 am - 10 am
      return _morningSkyGradient;
    } else if (hour >= 11 && hour <= 17) {
      // 11 am - 5 pm
      return _noonSkyGradient;
    } else {
      // 12 am - 3 am or 6 pm - 11 pm
      return _nightSkyGradient;
    }
  }

  String _getSunMoonObject(int hour) {
    if (hour >= 4 && hour <= 17) {
      return _forecastAssetsName["sun"];
    } else {
      return _forecastAssetsName["moon"];
    }
  }
}

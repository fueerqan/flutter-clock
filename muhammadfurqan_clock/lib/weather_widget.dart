import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final String weatherAssetName;
  final String objAssetName;

  WeatherWidget(this.objAssetName, this.weatherAssetName);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: <Widget>[
          Image(
            image: AssetImage(objAssetName),
            width: 65,
            height: 65,
            alignment: Alignment.topLeft,
          ),
          if (weatherAssetName.isNotEmpty)
            Image(
              image: AssetImage(weatherAssetName),
              width: 65,
              height: 65,
              alignment: Alignment.bottomCenter,
            )
        ],
      ),
    );
  }
}

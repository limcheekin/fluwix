import 'package:flutter/material.dart';
import 'app_config.dart';
import 'home.dart';

/// The main gallery app widget.
class ChartsScreen extends StatefulWidget {
  ChartsScreen({Key? key}) : super(key: key);

  @override
  ChartsScreenState createState() => new ChartsScreenState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class ChartsScreenState extends State<ChartsScreen> {
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;

  @override
  Widget build(BuildContext context) {
    return Home(
      showPerformanceOverlay: _showPerformanceOverlay,
      onShowPerformanceOverlayChanged: (bool value) {
        setState(() {
          _showPerformanceOverlay = value;
        });
      },
    );
  }
}

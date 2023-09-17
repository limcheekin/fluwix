@JS()
library newUniverse;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

// Instantiate Universe class from static new()
@JS('Universe.new')
external Universe newUniverse();

@JS()
class Universe {
  external void free();
  external void toggle_cell(int row, int column);
  external void tick();
  external String render();
  external int width();
  external int height();
  external int cells();
  external void set_width(int width);
  external void set_height(int height);
}

class WebAssemblyWidget extends StatefulWidget {
  const WebAssemblyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WebAssemblyWidgetState createState() => _WebAssemblyWidgetState();
}

class _WebAssemblyWidgetState extends State<WebAssemblyWidget> {
  late Universe universe;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    universe = newUniverse();
    startGameLoop();
  }

  @override
  void dispose() {
    universe.free();
    super.dispose();
  }

  void startGameLoop() {
    Future<void>.microtask(() async {
      while (true) {
        if (!isPaused) {
          setState(() {
            universe.tick();
          });
        }
        await Future.delayed(const Duration(milliseconds: 100));
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: togglePause,
            icon: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              size: 24,
            ),
            label: Text(
              isPaused ? 'Play' : 'Pause',
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                universe.render(),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

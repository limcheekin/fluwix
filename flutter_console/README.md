# Flutter console

<img src="https://raw.githubusercontent.com/semakers/flutter_console/main/logo.png" data-canonical-src="https://raw.githubusercontent.com/semakers/flutter_console/main/logo.png" width="311" height="264" />

With flutter console we can draw a console that allows us to scan and print data as well as being able to configure its size and colors.

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
    flutter_console_widget: ^0.0.3
```

## How to use

### Attributes

- **Color? consoleBackground**: background color of the console.
- **Color? consoleTextColor**: color of the console text.
- **FlutterConsoleController controller**: console controller.
- **double height**: height of the console.
- **Color? inputBackground**: background color of the text input field.
- **Color? inputTextColor**: color of the text of the text input field.
- **Color? scrollColor**: color of the scroll bar.
- **double width**: width of the console.

### FlutterConsoleController

**Attributes:**

- **FocusNode focusNode**: focus node for the text input field.
- **TextEditingController inputController**: controller of the text input field.
- **ScrollController scrollController**: controller of the scroll bar.
- **Completer completer**: completer object to manage the readings of the text input field.
- **FlutterConsoleData value**: console data object.

**Methods:**

- **FlutterConsoleController**: constructor of the class.
- **show**: show the console.
- **hide**: hides the console.
- **print**: write a message to the console.
- **scan**: reads a value from the text input field.
- **clear**: clears the content of the console.

### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_console_widget/flutter_console.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final FlutterConsoleController controller = FlutterConsoleController();

  void echoLoop() {
    controller.scan().then((value) {
      controller.print(message: value, endline: true);
      controller.focusNode.requestFocus();
      echoLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    echoLoop();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: FlutterConsole(
        controller: controller,
        height: size.height,
        width: size.width,
      ),
    );
  }
}
```

<img src="https://raw.githubusercontent.com/semakers/flutter_console/main/example/example.gif" data-canonical-src="https://raw.githubusercontent.com/semakers/flutter_console/main/example/example.gif" width="600" height="648" />

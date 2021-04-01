# Steps To Showcase Your Widgets
Please see the following steps to showcase your fantastic widget in the Flutter Widgets Explorer:

1. Fork the flutter-widgets-explorer repo.

2. Create a branch for your showcase with the following command:
    ```
    git checkout -b <branch_name>
    ```
   Think twice about the `branch_name`. As per naming convention, the name of `branch_name`, `module_name` and `route_name` must be same. The `route_name` is for navigation purpose, I will elaborate more later. Let's called the name of the showcase as `fantastic_widget`. 

3. Run the following command in the flutter-widgets-explorer:
    ```
    flutter create -t module <module_name>
    ``` 

4. Remove all comments of `pubspec.yaml` file of the module directory and edit `description` to "Fantastic Widget module".   

5. Add the following configurations to the module `pubspec.yaml` file below the `description`:
    ```yaml
    publish_to: "none"

    version: 1.0.0+1

    environment:
    sdk: ">=2.7.0 <3.0.0"

    dependencies:
    flutter:
        sdk: flutter

    # add dependency of your showcase here
    common_ui:
        path: ../common_ui
    showcase_view:
        path: ../showcase_view  

    dev_dependencies:
    flutter_test:
        sdk: flutter
    
    pedantic:
    ```
   Please refer to the [pubspec.yaml](https://github.com/limcheekin/flutter-widgets-explorer/blob/tab_buttons/tab_buttons/pubspec.yaml) file of the `tab_buttons` module for sample configuration. 

6. Copy the [analysis_options.yaml](https://raw.githubusercontent.com/limcheekin/flutter-widgets-explorer/tab_buttons/tab_buttons/analysis_options.yaml) to the module directory, this is to make sure that code written for the module is follow the best practices and consistent code styling with the project.

7. Replace the code of the `main.dart` file in the module's `lib` directory with the following:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:common_ui/my_module.dart';
    import 'fantastic_widget_screen.dart';
    
    void main() => runApp(
      MyModule(
        title: 'Fantastic Widget',
        home: FantasticWidgetScreen(),
      ),
    );
    ```
    Please refer to the [main.dart](https://github.com/limcheekin/flutter-widgets-explorer/blob/tab_buttons/tab_buttons/lib/main.dart) file of the `tab_buttons` module for sample code.

8. Create the `fantastic_widget_screen.dart` file in module's `lib` directory, for example:
    ```dart
    class FantasticWidgetScreen extends StatelessWidget {
        static const owner = 'limcheekin';
        static const repository = 'flutter-widgets-explorer';
        static const branch = 'fantastic_widget';

        @override
        Widget build(BuildContext context) {
            return ShowcaseView(
                title: 'Fantastic Widget',
                widget: FantasticWidget(),
                owner: owner,
                repository: repository,
                ref: branch,
                readMe: '$branch/README.md',
                license: '$branch/LICENSE',
                codePaths: [
                    '$branch/pubspec.yaml',
                    '$branch/lib/fantastic_widget_screen.dart',
                ],
            );
        }
    }
    ```
    Please refer to the [tab_buttons_screen.dart](https://github.com/limcheekin/flutter-widgets-explorer/blob/tab_buttons/tab_buttons/lib/tab_buttons_screen.dart) file of the `tab_buttons` module for sample code.

9. Create the `README.md` file in the module directory to describe the showcase and the `LICENSE` file for licensing information of the showcase.

10. In the module directory, run `flutter analyze`, then fix all reported coding issues.

11. Test the module by running module's `lib/main.dart`, if the module running fine, you can "link" the module to project's [pubspec.yaml](https://github.com/limcheekin/flutter-widgets-explorer/blob/main/pubspec.yaml) file with following configurations:
    ```yaml
    fantastic_widget:
        path: fantastic_widget 
    ```
    Then, add the showcase to main listing screen by append the following code to `routes` in [main.dart](https://github.com/limcheekin/flutter-widgets-explorer/blob/main/lib/main.dart#L28) file and resolve the import error of `FantasticWidgetScreen`:
    ```dart
    ChildRoute('/fantastic_widget', child: (_, __) => FantasticWidgetScreen()),
    ```

12. Finally, the module integration is completed. Execute the project's `main.dart` file and test your showcase. Everything seems working fine. Great! Your showcase is ready to go live, push the changes to remote repository and send me pull request.

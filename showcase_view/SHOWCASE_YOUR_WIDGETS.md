# Steps To Showcase Your Widgets
Please see the following steps to showcase your fantastic widget in the Flutter Widgets Explorer:

1. Fork the flutter-widgets-explorer repo and clone it to your local working directory.

2. Create a branch for your showcase with the following command:
    ```
    git checkout -b <branch_name>
    ```
   Think twice about the `branch_name`. As per naming convention, the name of `branch_name`, `module_name` and `route_name` must be same. The `route_name` is for navigation purpose, I will elaborate more later. Let's called the name of the showcase as `fantastic_widget`. 

3. Run the following command in the flutter-widgets-explorer directory:
    ```
    flutter pub run module_starter <module_name>
    ```

4. Update the `FantasticWidgetWidget` class with your showcase code in the `lib/fantastic_widget_screen.dart` file.

5. Update the `README.md` file in the module directory to describe the showcase. Then, add a `LICENSE` file for licensing information of the showcase.
    - __README.md__: Support standard Markdown syntax only, inline HTML not supported, please see [flutter_markdown](https://pub.dev/packages/flutter_markdown) package for more information. All URLs must be an absolute URL, for example https://github.com/limcheekin/flutter-widgets-explorer/raw/showcase_view/showcase_view/images/screenshots.gif.
    - __LICENSE__: must be a plain text file. 

6. In the module directory, run `flutter analyze`, then fix all reported coding issues.

7. Test the module by running module's `lib/main.dart`, if the module running fine, you can "link" the module to the project's [pubspec.yaml](https://github.com/limcheekin/flutter-widgets-explorer/blob/main/pubspec.yaml) file with the following configurations:
    ```yaml
    fantastic_widget:
        path: fantastic_widget 
    ```
    Then, add the showcase to main listing screen by append the following code to `routes` in [main.dart](https://github.com/limcheekin/flutter-widgets-explorer/blob/main/lib/main.dart#L28) file and resolve the import error of `FantasticWidgetScreen` class:
    ```dart
    ChildRoute('/fantastic_widget', child: (_, __) => FantasticWidgetScreen()),
    ```

8. Finally, the module integration is completed. Execute the project's `main.dart` file to test your showcase. Everything seems working fine? Great! Your showcase is ready to go live, push the changes to remote repository and send me pull request.

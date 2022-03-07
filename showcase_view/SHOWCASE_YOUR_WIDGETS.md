# Steps To Showcase Your Widgets

First of all, once your showcase deployed to production, you can share it to the world via:
    
- Android app
    
    <a href='https://play.google.com/store/apps/details?id=com.vobject.flutter.widgets.explorer&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width="50%"/></a>

- Web Direct Link
    
    For example, you can share the following URL for the [material_design_showcase](https://github.com/limcheekin/fluwix/tree/main/material_design_showcase) module:
    https://www.fluwix.com/material_design_showcase

- Embed HTML (The way I shared in [my blog](http://limcheekin.blogspot.com/p/fluwix.html))
    - [Code](https://github.com/limcheekin/fluwix/blob/main/web/embed.html)
    - [Live demo](https://www.fluwix.com/embed.html) 


Please see the following steps to showcase your fantastic widget in the Fluwix:

1. Fork the fluwix repo and clone it to your local working directory
    ```
    git clone git@github.com:limcheekin/fluwix.git
    ```

2. Create a branch for your showcase with the following command:
    ```
    git checkout -b <branch_name>
    ```
   Think twice about the `branch_name`. As per naming convention, the name of `branch_name`, `module_name` and `route_name` must be same. The `route_name` is for navigation purpose, I will elaborate more later. Let's called the name of the showcase as `fantastic_widget`. 

3. Run the following command in the fluwix directory:
    ```
    flutter pub run module_starter <module_name>
    ```

4. Update the `FantasticWidgetWidget` class with your showcase code in the `lib/fantastic_widget_screen.dart` file.

5. Update the `README.md` file in the module directory to describe the showcase. Then, add a `LICENSE` file for licensing information of the showcase. By the way, these two files can be located in your own GitHub repository instead of the module directory, please see [material_design_showcase](https://github.com/limcheekin/fluwix/blob/main/material_design_showcase/lib/material_design_showcase_screen.dart) for example. 
    - __README.md__: Support standard Markdown syntax only, inline HTML not supported, please see [flutter_markdown](https://pub.dev/packages/flutter_markdown) package for more information. All URLs must be an absolute URL, for example https://github.com/limcheekin/fluwix/raw/showcase_view/showcase_view/images/screenshots.gif.
    - __LICENSE__: must be a plain text file.

6. In the module directory, run `flutter analyze`, then fix all reported coding issues.

7. Test the module by running module's `lib/main.dart`, if the module running fine, you can "link" the module to the project's [pubspec.yaml](https://github.com/limcheekin/fluwix/blob/main/pubspec.yaml) file with the following configurations:
    ```yaml
    fantastic_widget:
        path: fantastic_widget 
    ```
    Then, add the showcase to main listing screen by append the following code to `routes` in [main.dart](https://github.com/limcheekin/fluwix/blob/main/lib/main.dart#L34) file and resolve the import error of `FantasticWidgetScreen` class:
    ```dart
    ChildRoute('/fantastic_widget', child: (_, __) => FantasticWidgetScreen()),
    ```

8. Finally, the module integration is completed. Execute the project's `main.dart` file to test your showcase. Everything seems working fine? Great! Your showcase is ready to go live, push the changes to remote repository and send me pull request.
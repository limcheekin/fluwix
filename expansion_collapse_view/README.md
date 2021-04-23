# expansion_collapse_view
As there is always space constraints in mobile devices, expandable panel is a common widget used in mobile application. Like most developers, I tempted to look into third party flutter package such as [expandable](https://pub.dev/packages/expandable) to implement such functionality. 

However, my experience told me that the better way is first try to implement any functionality using Flutter built-in widgets, then only look into third party flutter packages when built-in widgets unable to deliver the desired functionalities. This approach will reduce unnecessary dependencies to third party flutter packages.

The following example taken from an article [Flutter: Expansion/Collapse view](https://medium.com/flutter-community/flutter-expansion-collapse-view-fde9c51ac438), the author implemented the expandable panel using the built-in [ExpansionTile](https://api.flutter.dev/flutter/material/ExpansionTile-class.html) and [ExpansionPanelList](https://api.flutter.dev/flutter/material/ExpansionPanelList-class.html) widget:
![Expansion Collapse View screenshots](https://github.com/limcheekin/fluwix/raw/main/expansion_collapse_view/images/screenshots.gif "Expansion Collapse View screenshots")

If you are interested to reuse the source code of the screen above, please check out the `expansion_collapse_view` branch of the git repository hosted at https://github.com/limcheekin/fluwix. Feel free to fork the repository and send me pull request.

I'd love to hear from you!
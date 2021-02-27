import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard(
    this.listData,
    this.numberOfRows,
    this.setSizeFn, {
    Key key,
  }) : super(key: key);
  final listData;
  final numberOfRows;
  final setSizeFn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(5),
      child: _buildCardContent(
        context,
        listData,
        numberOfRows,
        setSizeFn,
      ),
    );
  }

  Widget _buildCardContent(
    BuildContext context,
    String text,
    int size,
    Function setSizeFn,
  ) {
    final showMoreButton = setSizeFn != null;
    final iconSize = 24.0;
    List<Widget> children = List.filled(size, null);
    for (var i = 0; i < size; i++) {
      children[i] = Text(
        "$text $i",
        style: TextStyle(
          fontSize: 28,
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          15.0,
          8.0,
          5.0,
          8.0,
        ),
        // REF: https://stackoverflow.com/questions/55259142/flutter-how-to-align-widget-to-the-topright-of-column
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: SizedBox(
                height: iconSize,
                width: iconSize,
                child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  icon: Icon(
                    Icons.more_vert,
                    size: iconSize, // default size is 24.0
                  ),
                  onPressed: () {
                    print("menu button pressed");
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: children,
                ),
                if (showMoreButton)
                  // REF: https://stackoverflow.com/questions/49211024/how-to-resize-height-and-width-of-an-iconbutton-in-flutter
                  SizedBox(
                    height: iconSize,
                    width: iconSize,
                    child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.arrow_right,
                        size: iconSize,
                      ),
                      onPressed: () {
                        //print("more button pressed. parentIndex: $parentIndex");
                        print('context.size.width = ${context.size?.width}');
                        print('context.size.height = ${context.size?.height}');
                        setSizeFn(context.size);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

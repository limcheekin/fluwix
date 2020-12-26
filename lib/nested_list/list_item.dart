import 'dart:math';

import 'package:flutter/material.dart';

import 'content_card.dart';
import 'horizontal_list.dart';

class ListItem extends StatefulWidget {
  const ListItem(this.nestedListData, this.index, {Key key}) : super(key: key);

  final nestedListData;
  final index;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  void setSize(Size size) {
    setState(() {
      widget.nestedListData[widget.index]['size'] = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_ListItemState.build()');

    return widget.nestedListData[widget.index]['size'] == null
        ? ContentCard(
            widget.nestedListData[widget.index]['data'][0],
            Random().nextInt(3) + 3,
            setSize,
          )
        : HorizontalList(
            widget.nestedListData[widget.index]['size'],
            widget.nestedListData[widget.index]['data'],
          );
  }

  /*Widget _buildHorizontalList(final size, final subListData) {
    print('_buildHorizontalList()');
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subListData.length,
          itemBuilder: (BuildContext content, int index) {
            return SizedBox(
              width: size.width,
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.all(5),
                child: _buildCardContent(
                  subListData[index],
                  Random().nextInt(3) + 3,
                  -1,
                ),
              ),
            );
          }),
    );
  }*/
}

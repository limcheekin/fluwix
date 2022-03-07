import 'dart:math';

import 'package:flutter/material.dart';

import 'content_card.dart';
import 'horizontal_list.dart';

class ListItem extends StatefulWidget {
  const ListItem(this.nestedListData, this.index, {Key? key}) : super(key: key);

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
    return widget.nestedListData[widget.index]['size'] == Null
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
}

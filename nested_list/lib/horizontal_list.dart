import 'dart:math';

import 'package:flutter/material.dart';

import 'content_card.dart';

class HorizontalList extends StatelessWidget {
  HorizontalList(this.size, this.listData, {Key key}) : super(key: key);
  final size;
  final listData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listData.length,
          itemBuilder: (BuildContext content, int index) {
            return SizedBox(
              width: size.width,
              child: ContentCard(
                listData[index],
                Random().nextInt(3) + 3,
                null,
              ),
            );
          }),
    );
  }
}

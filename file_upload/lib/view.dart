import 'package:flutter/material.dart';
import 'viewmodel.dart';

class ItemListView extends StatefulWidget {
  final ItemListViewModel viewModel;

  const ItemListView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.viewModel.items.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(widget.viewModel.items[index]));
      },
    );
  }
}

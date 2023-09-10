import 'model.dart';

class ItemListViewModel {
  final ItemList _itemList;

  ItemListViewModel(this._itemList);

  List<String> get items => _itemList.items;

  void addItem(String item) {
    _itemList.items.add(item);
  }
}

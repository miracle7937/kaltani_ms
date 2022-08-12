import 'package:flutter/cupertino.dart';

class SortingPageLogic extends ChangeNotifier {
  List<Widget> forItemList = [];

  addItem(v) {
    forItemList.add(v);
    notifyListeners();
  }

  removeItem(int i) {
    if (forItemList.isNotEmpty) {
      forItemList.removeAt(i);
    }
    notifyListeners();
  }

  void clear() {
    forItemList.clear();
    notifyListeners();
  }
}

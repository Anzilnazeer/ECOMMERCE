import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavouriteNotifier extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List<dynamic> _favourites = [];
  List<dynamic> fav = [];
  List<dynamic> _ids = [];

  List<dynamic> get ids => _ids;
  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favourites => _favourites;
  set favourites(List<dynamic> newFavour) {
    _favourites = newFavour;
    notifyListeners();
  }

  getFavs() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();
    _favourites = favData.toList();
    _ids = _favourites.map((item) => item['id']).toList();
  }

  Future<void> createFav(Map<dynamic, dynamic> newFav) async {
    await _favBox.add(newFav);
    // getFavs();
    notifyListeners();
  }

  getAllFavs() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "title": item['title'],
        "image": item['image'],
        "price": item['price'],
      };
    }).toList();
    fav = favData.reversed.toList();
  }

  deleteFavs(int key) async {
    await _favBox.delete(key);
  }
}

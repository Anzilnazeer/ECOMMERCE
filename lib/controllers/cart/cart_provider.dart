import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartNotifier extends ChangeNotifier {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];
  List<dynamic> get cart => _cart;
  set carts(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }
  getAllCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "title": item['title'],
        "image": item['image'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }

  Future<void> createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }
}

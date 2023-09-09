import 'package:flutter/services.dart' as services;
import 'package:newchat/models/tshirts_model.dart';

class Helper {
  Future<List<TshirtsModel>> getMenAttire() async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");
    final menList = tshirtsFromJson(data);
    return menList;
  }

  Future<TshirtsModel> getMenAttireById(String id) async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");

    final maleList = tshirtsFromJson(data);

    final tshirts = maleList.firstWhere((tshirts) => tshirts.id == id);

    return tshirts;
  }

  Future<List<TshirtsModel>> getWomenAttire() async {
    final data =
        await services.rootBundle.loadString("assets/json/women_wear.json");
    final womenList = tshirtsFromJson(data);
    return womenList;
  }

  Future<TshirtsModel> getWomenAttireById(String id) async {
    final data =
        await services.rootBundle.loadString("assets/json/women_wear.json");

    final maleList = tshirtsFromJson(data);

    final tshirts = maleList.firstWhere((tshirts) => tshirts.id == id);

    return tshirts;
  }

  Future<List<TshirtsModel>> getUnisexAttire() async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");
    final menList = tshirtsFromJson(data);
    return menList;
  }

  Future<TshirtsModel> getUnisexAttireById(String id) async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");

    final maleList = tshirtsFromJson(data);

    final tshirts = maleList.firstWhere((tshirts) => tshirts.id == id);

    return tshirts;
  }

  Future<List<TshirtsModel>> getKidsAttire() async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");
    final menList = tshirtsFromJson(data);
    return menList;
  }

  Future<TshirtsModel> getKidsAttireById(String id) async {
    final data =
        await services.rootBundle.loadString("assets/json/mens_wear.json");

    final maleList = tshirtsFromJson(data);

    final tshirts = maleList.firstWhere((tshirts) => tshirts.id == id);

    return tshirts;
  }
}

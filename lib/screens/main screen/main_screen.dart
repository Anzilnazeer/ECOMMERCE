// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:newchat/controllers/main%20screen/main_screen._provider.dart';
import 'package:newchat/screens/favourite_screen.dart';
import 'package:newchat/screens/cart_screen.dart';
import 'package:newchat/screens/profile_screen.dart';
import 'package:newchat/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../common/bottom_nav_bar.dart';
import '../home screen/home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, widget) {
      return Scaffold(
          bottomNavigationBar: const BottomNavBar(),
          body: pageList[mainScreenNotifier.pageIndex]);
    });
  }
}

// ignore_for_file: must_be_immutable

import '../../common/export_package.dart';

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

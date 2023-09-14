

import 'export_package.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, widget) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavWidget(
                icon: mainScreenNotifier.pageIndex == 0
                    ? IconlyBold.home
                    : IconlyLight.home,
                onTap: () {
                  mainScreenNotifier.pageIndex = 0;
                },
              ),
              BottomNavWidget(
                icon: mainScreenNotifier.pageIndex == 2
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                onTap: () {
                  mainScreenNotifier.pageIndex = 2;
                },
              ),
              BottomNavWidget(
                icon: mainScreenNotifier.pageIndex == 1
                    ? IconlyBold.search
                    : IconlyLight.search,
                onTap: () {
                  mainScreenNotifier.pageIndex = 1;
                },
              ),
              BottomNavWidget(
                icon: mainScreenNotifier.pageIndex == 3
                    ? IconlyBold.bag_2
                    : IconlyLight.bag_2,
                onTap: () {
                  mainScreenNotifier.pageIndex = 3;
                },
              ),
              BottomNavWidget(
                icon: mainScreenNotifier.pageIndex == 4
                    ? IconlyBold.profile
                    : IconlyLight.profile,
                onTap: () {
                  mainScreenNotifier.pageIndex = 4;
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

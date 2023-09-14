

import 'export_package.dart';

class BottomNavWidget extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  const BottomNavWidget({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36.h,
        width: 36.w,
        child: Icon(
          icon,
          color: bottomicon,
          size: 30.w,
        ),
      ),
    );
  }
}

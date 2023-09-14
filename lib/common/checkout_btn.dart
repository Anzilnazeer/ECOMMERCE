

import 'export_package.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    this.onTap,
    required this.label,
  });
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

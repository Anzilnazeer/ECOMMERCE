import '../../../common/export_package.dart';

class StaggeredContainer extends StatefulWidget {
  final String title;
  final String details;
  final String? category;
  final String? id;
  final String price;
  final String image;
  final Function()? onTap;
  const StaggeredContainer(
      {super.key,
      required this.title,
      required this.details,
      this.category,
      this.id,
      required this.price,
      required this.image,
      this.onTap});

  @override
  State<StaggeredContainer> createState() => _StaggeredContainerState();
}

class _StaggeredContainerState extends State<StaggeredContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 232, 232, 232),
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 195.w,
                child: Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 213, 213, 213),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: const Color(0xFF6B4241),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.details,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: const Color(0xFF6B4241),
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.price,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: const Color(0xFF6B4241),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

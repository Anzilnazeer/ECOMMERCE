import '../../../common/export_package.dart';

class HomeProductCardContainer extends StatefulWidget {
  final String title;
  final String details;
  final String category;
  final String? id;
  final String price;
  final String image;
  final Function()? onTap;
  const HomeProductCardContainer(
      {super.key,
      required this.image,
      required this.title,
      required this.details,
      required this.price,
      required this.category,
      this.id,
      this.onTap});

  @override
  State<HomeProductCardContainer> createState() =>
      _HomeProductCardContainerState();
}

class _HomeProductCardContainerState extends State<HomeProductCardContainer> {
  @override
  Widget build(BuildContext context) {
    var favouriteNotifier =
        Provider.of<FavouriteNotifier>(context, listen: true);
    favouriteNotifier.getFavs();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.w),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 220.w,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(9, 0, 0, 0),
                  spreadRadius: 8,
                  blurRadius: 0.6,
                  offset: Offset(5, 1),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 230.h,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 213, 213, 213),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15.w,
                      top: 15.h,
                      child: Consumer<FavouriteNotifier>(
                          builder: (context, favourNotifier, child) {
                        return GestureDetector(
                          onTap: () async {
                            if (favourNotifier.ids.contains(widget.id)) {
                              Provider.of<MainScreenNotifier>(context,
                                      listen: false)
                                  .pageIndex = 2;
                            } else {
                              favouriteNotifier.createFav({
                                "id": widget.id,
                                "title": widget.title,
                                "category": widget.category,
                                "image": widget.image,
                                "price": widget.price
                              });
                              setState(() {});
                            }
                          },
                          child: Icon(
                            favourNotifier.ids.contains(widget.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        );
                      }),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                        style: TextStyle(
                          color: const Color(0xFF6B4241),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.price,
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
      ),
    );
  }
}

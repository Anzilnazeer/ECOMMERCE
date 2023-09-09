import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:newchat/models/constants.dart';
import 'package:newchat/screens/favourite_screen.dart';

class HomeProductCardContainer extends StatefulWidget {
  final String title;
  final String details;
  final String? category;
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
      this.category,
      this.id,
      this.onTap});

  @override
  State<HomeProductCardContainer> createState() =>
      _HomeProductCardContainerState();
}

class _HomeProductCardContainerState extends State<HomeProductCardContainer> {
  final _favBox = Hive.box('fav_box');
  Future<void> _createFav(Map<dynamic, dynamic> newFav) async {
    await _favBox.add(newFav);
    getFavs();
  }

  getFavs() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();
    favour = favData.toList();
    ids = favour.map((item) => item['id']).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                      child: GestureDetector(
                        onTap: () {
                          if (ids.contains(widget.id)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FavouriteScreen(),
                                ));
                          } else {
                            _createFav({
                              "id": widget.id,
                              "title": widget.title,
                              "category": widget.category,
                              "image": widget.image,
                            });
                          }
                        },
                        child: Icon(
                          ids.contains(widget.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:newchat/colors.dart';
import 'package:newchat/controllers/single_product/single_product_provider.dart';
import 'package:newchat/models/tshirts_model.dart';
import 'package:provider/provider.dart';

import '../../common/checkout_btn.dart';
import '../../models/constants.dart';
import '../../services/helper.dart';
import '../favourite_screen.dart';

class SingleProductPage extends StatefulWidget {
  final String id;
  final String category;
  const SingleProductPage(
      {super.key, required this.id, required this.category});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

late Future<TshirtsModel> tshirts;

class _SingleProductPageState extends State<SingleProductPage> {
  final _cartBox = Hive.box('cart_box');
  final PageController pageController = PageController();
  void getTshirts() {
    if (widget.category == "Men Attire") {
      tshirts = Helper().getMenAttireById(widget.id);
    } else if (widget.category == "Women Attire") {
      tshirts = Helper().getWomenAttireById(widget.id);
    } else if (widget.category == "Unisex Attire") {
      tshirts = Helper().getUnisexAttireById(widget.id);
    } else {
      tshirts = Helper().getKidsAttireById(widget.id);
    }
  }

  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

//favourites hive
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
  void initState() {
    super.initState();
    getTshirts();
    getFavs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<TshirtsModel>(
            future: tshirts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final tshirt = snapshot.data;
                return Consumer<SingleProductNotifier>(
                  builder: (context, singleProductNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    singleProductNotifier.shoeSizes.clear();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          pinned: true,
                          snap: false,
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: MediaQuery.of(context).size.height,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                SizedBox(
                                  height: 400.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tshirt!.image.length,
                                      controller: pageController,
                                      onPageChanged: (page) {
                                        singleProductNotifier.activePage = page;
                                      },
                                      itemBuilder: (context, int index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: 400.h,
                                              width: double.infinity,
                                              color: Colors.grey.shade300,
                                              child: Image.network(
                                                tshirt.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                right: 20,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (ids
                                                        .contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const FavouriteScreen(),
                                                          ));
                                                    } else {
                                                      _createFav({
                                                        "id": tshirt.id,
                                                        "title": tshirt.title,
                                                        "category":
                                                            tshirt.category,
                                                        "image": tshirt.image,
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    ids.contains(widget.id)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }),
                                ),
                                Positioned(
                                    bottom: 0,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      child: Container(
                                        height: 440.h,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                tshirt.title!,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    tshirt.category!,
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 4,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color: brandColor,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$${tshirt.price}",
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Colors",
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 7,
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 7,
                                                        backgroundColor:
                                                            Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  const Row(
                                                    children: [
                                                      Text(
                                                        "Select sizes",
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "View size guide",
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            singleProductNotifier
                                                                .shoeSizes
                                                                .length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final sizes =
                                                              singleProductNotifier
                                                                      .shoeSizes[
                                                                  index];

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 5.0,
                                                            ),
                                                            child: ChoiceChip(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  side: const BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width: 1,
                                                                      style: BorderStyle
                                                                          .solid)),
                                                              disabledColor:
                                                                  Colors.grey,
                                                              label: Text(
                                                                sizes['size'],
                                                                style:
                                                                    TextStyle(
                                                                  color: sizes[
                                                                          'isSelected']
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                              selectedColor:
                                                                  brandColor,
                                                              selected: sizes[
                                                                  'isSelected'],
                                                              onSelected:
                                                                  (newState) {
                                                                if (singleProductNotifier
                                                                    .sizes
                                                                    .contains(sizes[
                                                                        'size'])) {
                                                                  singleProductNotifier
                                                                      .sizes
                                                                      .remove(sizes[
                                                                          'size']);
                                                                } else {
                                                                  singleProductNotifier
                                                                      .sizes
                                                                      .add(sizes[
                                                                          'size']);
                                                                }
                                                                print(
                                                                    singleProductNotifier
                                                                        .sizes);
                                                                singleProductNotifier
                                                                    .toggleCheck(
                                                                        index);
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                indent: 10,
                                                endIndent: 10,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Text(
                                                  tshirt.title!,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                tshirt.details!,
                                                textAlign: TextAlign.justify,
                                                maxLines: 4,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: CheckoutButton(
                                                    onTap: () async {
                                                      _createCart({
                                                        "id": tshirt.id,
                                                        "title": tshirt.title,
                                                        "category":
                                                            tshirt.category,
                                                        "sizes":
                                                            singleProductNotifier
                                                                .sizes[0],
                                                        "image": tshirt.image,
                                                        "price": tshirt.price,
                                                        "qty": 1
                                                      });
                                                      print(tshirt.title);
                                                      singleProductNotifier
                                                          .sizes
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    label: "Add to Cart",
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            }));
  }
}

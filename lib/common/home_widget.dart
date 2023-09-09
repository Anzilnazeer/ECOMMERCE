import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newchat/controllers/single_product/single_product_provider.dart';
import 'package:newchat/info.dart';
import 'package:newchat/screens/home%20screen/showall_product.dart';
import 'package:newchat/screens/home%20screen/single_product.dart';
import 'package:provider/provider.dart';

import '../controllers/favouries/favourites_provider.dart';
import '../models/tshirts_model.dart';
import '../screens/home screen/widgets/productcard.dart';

class HomeWidget extends StatelessWidget {
  final Future<List<TshirtsModel>> men;
  final int tabIndex;
  const HomeWidget({
    super.key,
    required this.men,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    var singleProductNotifier = Provider.of<SingleProductNotifier>(context);
    var favouriteNotifier =
        Provider.of<FavouriteNotifier>(context, listen: true);
    favouriteNotifier.getFavs();
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 330.h,
                child: FutureBuilder<List<TshirtsModel>>(
                  future: men,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final mendata = snapshot.data![index];

                          // Use null-aware operators to handle potential null values
                          final title = mendata.title;
                          final details = mendata.details;
                          final price = mendata.price;
                          final category = mendata.category;

                          // Check if image is not null and the image list is not empty
                          final image =
                              mendata.image.isNotEmpty ? mendata.image : 'N/A';

                          return GestureDetector(
                            onTap: () {
                              singleProductNotifier.shoesSizes = mendata.sizes;
                              print(singleProductNotifier.shoeSizes);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleProductPage(
                                      id: mendata.id,
                                      category: mendata.category),
                                ),
                              );
                            },
                            child: HomeProductCardContainer(
                              id: mendata.id,
                              title: title,
                              details: details,
                              price: price,
                              image: image,
                              category: category,
                            ),
                          );
                        },
                      );
                    }
                  },
                )),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest collections',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowAllProduct(
                                  tabIndex: tabIndex,
                                ))),
                    child: Row(
                      children: [
                        Text(
                          'Show all',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18.w,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 200.h,
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              info[index]['image']!,
                            ),
                          ),
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(10.w),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(78, 0, 0, 0),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(1, 1.5))
                          ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

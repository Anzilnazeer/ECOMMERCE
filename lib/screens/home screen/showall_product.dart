import '../../common/export_package.dart';

class ShowAllProduct extends StatefulWidget {
  final int tabIndex;
  const ShowAllProduct({super.key, required this.tabIndex});

  @override
  State<ShowAllProduct> createState() => _ShowAllProductState();
}

class _ShowAllProductState extends State<ShowAllProduct>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 4, vsync: this);
  // late Future<List<TshirtsModel>> men;
  late Future<List<TshirtsModel>> men;
  late Future<List<TshirtsModel>> women;
  late Future<List<TshirtsModel>> unisex;
  late Future<List<TshirtsModel>> kids;
  void getMens() {
    men = Helper().getMenAttire();
  }

  void getWomen() {
    women = Helper().getWomenAttire();
  }

  void getUnisex() {
    unisex = Helper().getUnisexAttire();
  }

  void getKids() {
    kids = Helper().getKidsAttire();
  }

  @override
  void initState() {
    super.initState();
    tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    getMens();
    getWomen();
    getUnisex();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(24.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: brandColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    filter();
                  },
                  child: Text(
                    'filter',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 70.0.h), // Added space above the TabBar
              TabBar(
                tabs: const [
                  Tab(text: 'Men Attire'),
                  Tab(text: 'Women Attire'),
                  Tab(text: 'Unisex'),
                  Tab(text: 'Kids'),
                ],
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                // Color of the selected tab indicator
                labelColor: brandColor, // Color of the selected tab label
                unselectedLabelColor:
                    Colors.grey, // Color of unselected tab labels
                labelStyle: GoogleFonts.anticDidone(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle: GoogleFonts.anticDidone(
                  fontSize: 16.sp,
                ), // Style for unselected tab labels
                // Other styling properties you can use
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      LatestTshirts(
                        men: men,
                      ),
                      LatestTshirts(
                        men: women,
                      ),
                      LatestTshirts(
                        men: unisex,
                      ),
                      LatestTshirts(
                        men: kids,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> filter() {
    double value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: const Color.fromARGB(80, 255, 255, 255),
        builder: (context) => Container(
              height: 550.h,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(227, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const CustomSpacer(),
                        Text(
                          "Filter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp,
                              color: Colors.white),
                        ),
                        const CustomSpacer(),
                        const Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryButton(
                              label: "Men",
                              buttonClr: brandColor,
                            ),
                            CategoryButton(
                                label: "Women", buttonClr: Colors.grey),
                            CategoryButton(
                                label: "Kids", buttonClr: Colors.grey),
                          ],
                        ),
                        const CustomSpacer(),
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryButton(
                              label: "Shoes",
                              buttonClr: brandColor,
                            ),
                            CategoryButton(
                              label: "Apparrels",
                              buttonClr: Colors.grey,
                            ),
                            CategoryButton(
                              label: "Accessories",
                              buttonClr: Colors.grey,
                            ),
                          ],
                        ),
                        const CustomSpacer(),
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const CustomSpacer(),
                        Slider(
                          value: value,
                          activeColor: brandColor,
                          inactiveColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          thumbColor: const Color.fromARGB(255, 255, 255, 255),
                          max: 500,
                          divisions: 50,
                          label: value.toString(),
                          secondaryTrackValue: 200,
                          onChanged: (double value) {},
                        ),
                        const CustomSpacer(),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

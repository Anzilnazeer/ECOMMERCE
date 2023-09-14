import '../../common/export_package.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 4, vsync: this);
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
    getMens();
    getWomen();
    getUnisex();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(),
              child: Container(
                padding: EdgeInsets.all(24.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Fill your Wardrobe',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'With WARDROBE ATTIRE.',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w800,
                        color: brandColor,
                        fontFamily: GoogleFonts.bellefair().toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 130.0.h), // Added space above the TabBar
                TabBar(
                  tabs: const [
                    Tab(text: 'Men Attire'),
                    Tab(text: 'Women Attire'),
                    Tab(text: 'Unisex'),
                    Tab(text: 'Kids'),
                  ],
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor:
                      brandColor, // Color of the selected tab indicator
                  labelColor: brandColor, // Color of the selected tab label
                  unselectedLabelColor:
                      Colors.grey, // Color of unselected tab labels
                  labelStyle: GoogleFonts.anticDidone(
                      fontSize: 20.sp, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: GoogleFonts.anticDidone(
                    fontSize: 16.sp,
                  ), // Style for unselected tab labels
                  // Other styling properties you can use
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Content for the 'Men' tab
                        HomeWidget(
                          men: men,
                          tabIndex: 0,
                        ),
                        HomeWidget(
                          men: women,
                          tabIndex: 1,
                        ),
                        HomeWidget(
                          men: unisex,
                          tabIndex: 2,
                        ),
                        HomeWidget(
                          men: kids,
                          tabIndex: 3,
                        ),
                        // Content for the 'Women' tab
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

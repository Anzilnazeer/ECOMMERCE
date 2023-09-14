import 'package:newchat/common/export_package.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => SingleProductNotifier()),
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        ChangeNotifierProvider(create: (context) => FavouriteNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sneakers',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              // Define a custom style for your text here
              bodyLarge: TextStyle(
                fontSize: 16.0.sp,
              ),
            ),
          ),
          // onGenerateRoute: (settings) => generateRoute(settings),
          home: MainScreen(),
        );
      },
    );
  }
}

import '../common/export_package.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    var favouriteNotifier =
        Provider.of<FavouriteNotifier>(context, listen: true);
    favouriteNotifier.getAllFavs();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "My Favourites",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<FavouriteNotifier>(
                    builder: (context, favouriteNotifier, child) {
                  return SizedBox(
                      height: 580.h,
                      child: favouriteNotifier.fav.isEmpty
                          ? const Center(child: Text('No favourites'))
                          : ListView.builder(
                              itemCount: favouriteNotifier.fav.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final data = favouriteNotifier.fav[index];
                                final title = data['title'];
                                final category = data['category'];
                                final price = data['price'];

                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Container(
                                      height: 100.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade500,
                                            spreadRadius: 5,
                                            blurRadius: 0.3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Image.network(
                                              data['image'],
                                              width: 70.w,
                                              height: 100.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    title), // Use title with null check
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    category), // Use category with null check
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(price ??
                                                    '1000'), // Use price with null check
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              favouriteNotifier
                                                  .deleteFavs(data['key']);
                                              favouriteNotifier.ids.removeWhere(
                                                  (element) =>
                                                      element == data['id']);

                                              setState(() {});
                                            },
                                            child: const Icon(Icons.favorite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../common/export_package.dart';

class LatestTshirts extends StatelessWidget {
  final Future<List<TshirtsModel>> men;
  const LatestTshirts({
    super.key,
    required this.men,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TshirtsModel>>(
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
          return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (index) => StaggeredTile.extent(
                  (index % 2 == 0) ? 1 : 1,
                  (index % 4 == 1 || index % 4 == 3) ? 330.h : 300.h),
              itemBuilder: (context, index) {
                final men = snapshot.data![index];
                return StaggeredContainer(
                    image: men.image,
                    details: men.details!,
                    title: men.title!,
                    price: men.price!);
              });
        }
      },
    );
  }
}

import 'package:flutter_slidable/flutter_slidable.dart';
import '../common/export_package.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    cartNotifier.getAllCart();
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
                  "My Cart",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: cartNotifier.cart.isEmpty
                      ? const Center(
                          child: Text('No items added to cart'),
                        )
                      : ListView.builder(
                          itemCount: cartNotifier.cart.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = cartNotifier.cart[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) {
                                          cartNotifier.deleteCart(data['key']);

                                          setState(() {});
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
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
                                              offset: const Offset(0, 1)),
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                                    data['title'],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data['price'],
                                                      ),
                                                      const SizedBox(
                                                        width: 40,
                                                      ),
                                                      const Text(
                                                        "Size",
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        data['sizes'],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          // cartProvider.increment();
                                                        },
                                                        child: const Icon(
                                                          Icons.minimize,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        )),
                                                    Text(
                                                      data['qty'].toString(),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          // cartProvider.decrement();
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                )
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: "Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}

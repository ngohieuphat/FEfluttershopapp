import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/models/cart/get_products_model.dart';
import 'package:shopappcourse/services/cart_help.dart';
import 'package:shopappcourse/views/shared/resusable_text.dart';
import 'package:shopappcourse/views/ui/mainscreen.dart';

import '../../controllers/cart_provider.dart';
import '../shared/appstyle.dart';
import '../shared/checkoutbtn.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: reusableText(
                                text: "Failed to get cart data",
                                style: appstyle(
                                    18, Colors.black, FontWeight.w600)),
                          );
                        } else {
                          final cartData = snapshot.data;
                          return ListView.builder(
                              itemCount: cartData!.length ?? 0,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                if (cartData == null ||
                                    index >= cartData.length) {
                                  return SizedBox.shrink();
                                }
                                final data = cartData[index];
                                if (data.cartItem == null ||
                                    data.cartItem.imageUrl.isEmpty) {
                                  return SizedBox.shrink();
                                }
                                String imageUrl = data.cartItem.imageUrl[0];

                                return GestureDetector(
                                  onTap: () {
                                    cartProvider.setProductIndex = index;
                                    cartProvider.checkout.insert(0, data);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade500,
                                                  spreadRadius: 5,
                                                  blurRadius: 0.3,
                                                  offset: const Offset(0, 1))
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: data
                                                              .cartItem
                                                              .imageUrl[0],
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Positioned(
                                                          top: -4,
                                                          child: Container(
                                                            width: 40,
                                                            height: 30,
                                                            decoration: const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12))),
                                                            child:
                                                                GestureDetector(
                                                              onTap:
                                                                  ()  {},
                                                              child: SizedBox(
                                                                height: 40.h,
                                                                width: 30.w,
                                                                child: Icon(
                                                                  cartProvider.productIndex ==
                                                                          index
                                                                      ? Feather
                                                                          .check_square
                                                                      : Feather
                                                                          .square,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                      Positioned(
                                                          bottom: -2,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await CartHelper()
                                                                  .deleteItem(
                                                                      data.id)
                                                                  .then(
                                                                      (response) {
                                                                if (response ==
                                                                    true) {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MainScreen(),
                                                                      ));
                                                                } else {
                                                                  debugPrint(
                                                                      "Failed to delete the iten");
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 30,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(12))),
                                                              child: Icon(
                                                                AntDesign
                                                                    .delete,
                                                                size: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )),
                                                    ]),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12, left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.cartItem.name,
                                                        style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          data.cartItem
                                                              .category,
                                                          style: appstyle(
                                                              14,
                                                              Colors.grey,
                                                              FontWeight.w600)),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "\$${data.cartItem.price}",
                                                            style: appstyle(
                                                                18,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 30,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                                                          onTap: () {},
                                                          child: const Icon(
                                                            AntDesign
                                                                .minussquare,
                                                            size: 20,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          data.quantity
                                                              .toString(),
                                                          style: appstyle(
                                                              12,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: const Icon(
                                                            AntDesign
                                                                .plussquare,
                                                            size: 20,
                                                            color: Colors.black,
                                                          ),
                                                        )
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
                              });
                        }
                      }),
                )
              ],
            ),
            cartProvider.checkout.isNotEmpty
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckOutButton(label: "Procced to Checkout"),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

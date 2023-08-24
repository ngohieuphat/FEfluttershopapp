import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/controllers/login_provider.dart';
import 'package:shopappcourse/models/cart/add_to_cart._model.dart';
import 'package:shopappcourse/services/cart_help.dart';
import 'package:shopappcourse/views/ui/auth/login.dart';

import '../../controllers/favorites_provider.dart';
import '../../controllers/product_provider.dart';
import '../../models/sneaker_model.dart';
import '../shared/appstyle.dart';
import '../shared/checkoutbtn.dart';
import 'favorites.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.sneakers});

  final Sneakers sneakers;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();

    return Scaffold(body: Consumer<ProductNotifier>(
      builder: (context, productNotifire, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // productNotifire.shoeSizes.clear();
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.black,
                        ),
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          if (authNotifier.loggeIn == true) {
                            if (favoritesNotifier.ids
                                .contains(widget.sneakers.id)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Favorites(),
                                ),
                              );
                            } else {
                              favoritesNotifier.createFav({
                                "id": widget.sneakers.id,
                                "name": widget.sneakers.name,
                                "category": widget.sneakers.category,
                                "price": widget.sneakers.price,
                                "imageUrl": widget.sneakers.imageUrl[0],
                              });
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                          setState(() {});
                        },
                        child:
                            favoritesNotifier.ids.contains(widget.sneakers.id)
                                ? const Icon(
                                    AntDesign.heart,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    AntDesign.hearto,
                                    color: Colors.red,
                                  ),
                      )
                    ]),
              ),
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  SizedBox(
                    height: 401.h,
                    width: 375.w,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sneakers.imageUrl.length,
                        controller: pageController,
                        onPageChanged: (page) {
                          productNotifire.activePage = page;
                        },
                        itemBuilder: (context, int index) {
                          return Stack(
                            children: [
                              Container(
                                height: 316.h,
                                width: 375.w,
                                child: CachedNetworkImage(
                                  imageUrl: widget.sneakers.imageUrl[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // Positioned(
                              //   top: 54.h,
                              //   right: 20.w,
                              //   child: Consumer<FavoritesNotifier>(
                              //     builder: (context,
                              //         favoritesNotifier, child) {
                              //       return
                              //     },
                              //   ),
                              // ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List<Widget>.generate(
                                      widget.sneakers.imageUrl.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  productNotifire.activepage !=
                                                          index
                                                      ? Colors.grey
                                                      : Colors.black,
                                            ),
                                          )),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Positioned(
                    bottom: 30,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.645,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.sneakers.name,
                                style:
                                    appstyle(40, Colors.black, FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.sneakers.category,
                                    style: appstyle(
                                        20, Colors.grey, FontWeight.w500),
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
                                    itemSize: 22,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.yellow,
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
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${widget.sneakers.price}",
                                    style: appstyle(
                                        26, Colors.black, FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Colors",
                                        style: appstyle(
                                            18, Colors.black, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Select sizes",
                                        style: appstyle(
                                            20, Colors.black, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "View size guide",
                                        style: appstyle(
                                            20, Colors.black, FontWeight.w500),
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
                                            productNotifire.shoeSizes.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          final sizes =
                                              productNotifire.shoeSizes[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ChoiceChip(
                                       
                                              disabledColor: Colors.white,
                                              label: Text(
                                                productNotifire.shoeSizes[index]
                                                    ['size'],
                                                style: appstyle(
                                                    16,
                                                    sizes['isSelected']
                                                        ? Colors.white
                                                        : Colors.black38,
                                                    FontWeight.w600),
                                              ),
                                              selected: productNotifire
                                                      .shoeSizes[index]
                                                  ['isSelected'],
                                              onSelected: (newState) {
                                                if (productNotifire.sizes
                                                    .contains(sizes['size'])) {
                                                  productNotifire.sizes
                                                      .remove(sizes['size']);
                                                } else {
                                                  productNotifire.sizes
                                                      .add(sizes['size']);
                                                }
                                                productNotifire
                                                    .toggleCheck(index);
                                              },
                                            ),
                                          );
                                        }),
                                  ),
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
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  widget.sneakers.title,
                                  style: appstyle(
                                      26, Colors.black, FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  widget.sneakers.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 4,
                                  style: appstyle(
                                      14, Colors.black, FontWeight.normal),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: CheckOutButton(
                                    onTap: () async {
                                      if (authNotifier.loggeIn == true) {
                                        print("Sneakers ID: ${widget.sneakers.id}");

                                        AddToCart model = AddToCart(
                                            cartItem: widget.sneakers.id,
                                            quantity: 1);
                                        CartHelper().addToCart(model);
                                        print("CartItem ID: ${model.cartItem}");
                                        print("Quantity: ${model.quantity}");
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      }
                                    },
                                    label: "Add to Cart",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    ));
  }
}

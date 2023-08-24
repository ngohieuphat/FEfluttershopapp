import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';
import 'package:shopappcourse/controllers/login_provider.dart';
import 'package:shopappcourse/views/ui/nonuser.dart';
import '../../controllers/favorites_provider.dart';
import '../shared/appstyle.dart';
import 'mainscreen.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getallDate();
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false
        ? const NonUser()
        : Scaffold(
            body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.jpeg"),
                        fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "My Favorites",
                      style: appstyle(36, Colors.black, FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: favoritesNotifier.fav.length,
                    padding: const EdgeInsets.only(top: 100),
                    itemBuilder: (BuildContext context, int index) {
                      final shoe = favoritesNotifier.fav[index];

                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade500,
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: Offset(0, 1))
                                ]),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: shoe['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12, left: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              shoe['name'],
                                              style: appstyle(16, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              shoe['category'],
                                              style: appstyle(14, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${shoe['price']}',
                                                  style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        favoritesNotifier
                                            .deleteFav(shoe['key']);
                                        favoritesNotifier.ids.removeWhere(
                                            (element) => element == shoe['id']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreen()));
                                      },
                                      child:
                                          const Icon(Ionicons.md_heart_dislike),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ));
  }
}

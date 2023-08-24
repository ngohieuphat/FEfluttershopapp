import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopappcourse/models/sneaker_model.dart';
import 'package:shopappcourse/views/shared/stagger_tile.dart';
import 'package:shopappcourse/views/ui/product_page.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class latestShoes extends StatelessWidget {
  const latestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 16.h,
              itemCount: male!.length,
              scrollDirection: Axis.horizontal,
              staggeredTileBuilder: (index) => StaggeredTile.extent(
                  (index % 2 == 0) ? 1 : 1,
                  (index % 4 == 1 || index % 4 == 3) ? 285.h : 252.h),
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(sneakers: shoe)));
                  },
                  child: StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: "\$${shoe.price}"),
                );
              },
            );
          }
        });
  }
}

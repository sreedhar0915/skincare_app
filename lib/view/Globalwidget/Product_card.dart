import 'package:flutter/material.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/Utilis/constants/style_constants.dart';

class ProductCard extends StatelessWidget {
  final String productname;
  final String description;
  final String price;
  final String imageurl;

  const ProductCard({
    super.key,
    required this.productname,
    required this.description,
    required this.price,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 350,
        width: 265,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstants.grey
                  .withOpacity(0.25), // Shadow color with opacity
              blurRadius: 10, // Blur radius
              spreadRadius: 2, // Spread radius for a larger shadow
              offset: Offset(0, 6), // Offset the shadow slightly
            ),
          ],
          color: ColorConstants.tabbarcolor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 251,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.zero,
                ),
                color: ColorConstants.white,
                image: DecorationImage(
                    image: NetworkImage(imageurl), fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 114,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.zero,
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: ColorConstants.tabbarcolor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productname,
                    maxLines: 1, style: StyleConstants.productname),
                Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleConstants.productdescription),
                ),
                Text("\$ ${price}", style: StyleConstants.productprice),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 11,
        left: 14,
        child: CircleAvatar(
          radius: 21,
          backgroundColor: ColorConstants.circlefavourite,
          child: Center(child: Image.asset("assets/images/heart card.png")),
        ),
      ),
      Positioned(
          top: 292,
          left: 209,
          child: CircleAvatar(
            radius: 21,
            backgroundColor: ColorConstants.circlebag,
            child: Image.asset("assets/images/bag-2.png"),
          ))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/Utilis/constants/style_constants.dart';

class Productcollectioncard extends StatelessWidget {
  final String productname;
  final String description;
  final String imageurl;
  const Productcollectioncard({
    super.key,
    required this.productname,
    required this.description,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: 366,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.zero,
        ),
        border: Border.all(color: ColorConstants.grey),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              width: 116,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                image: DecorationImage(
                    image: NetworkImage(imageurl), fit: BoxFit.contain),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(productname,
                      maxLines: 1, style: StyleConstants.productname),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleConstants.productdescription),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

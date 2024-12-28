import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/Utilis/constants/style_constants.dart';
import 'package:skincare_app/controller/cartscreen_controller.dart';
import 'package:skincare_app/controller/productscreen_controller.dart';
import 'package:skincare_app/view/Cart_screen/Cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final int productID;
  ProductScreen({super.key, required this.productID});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => context
          .read<ProductscreenController>()
          .getproductDetail(widget.productID),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      bottomNavigationBar: Consumer<ProductscreenController>(
        builder: (context, value, child) => value.isloading
            ? Center(child: CircularProgressIndicator())
            : BottomAppBar(
                color: ColorConstants.tabbarcolor,
                surfaceTintColor: ColorConstants.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Price", style: StyleConstants.productprice),
                        Text("\$ ${value.product!.price.toString()}",
                            style: StyleConstants.productprice)
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item is added to cart'),
                              backgroundColor: ColorConstants.tabbarcolor,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          context
                              .read<CartController>()
                              .addProduct(value.product!);
                          context.read<CartController>().getAllProducts();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cartscreen()));
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorConstants.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_mall_outlined,
                                color: ColorConstants.tabbarcolor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: ColorConstants.tabbarcolor),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      appBar: AppBar(
        surfaceTintColor: ColorConstants.white,
        backgroundColor: ColorConstants.tabbarcolor,
        title: Center(
            child: Text(
          "Details",
          style: StyleConstants.details,
        )),
        actions: [
          Image.asset("assets/images/notification.png"),
          SizedBox(width: 20)
        ],
      ),
      body: Consumer<ProductscreenController>(
        builder: (context, value, child) => value.isloading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        "${value.product!.image.toString()}")),
                                color: ColorConstants.white,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          Positioned(
                            top: 11,
                            left: 14,
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor: ColorConstants.circlefavourite,
                              child: Image.asset(
                                "assets/images/heart card.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${value.product!.title.toString()}",
                        style: StyleConstants.productname,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 30,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${value.product!.rating!.rate.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(width: 3),
                          Text(
                            "(50 reviews)",
                            style: TextStyle(
                                fontSize: 15,
                                color: ColorConstants.tabbarcolor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("${value.product!.description.toString()}",
                          maxLines: 4,
                          style: StyleConstants.productdescription),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Choose size",
                          selectionColor: ColorConstants.black,
                          style: StyleConstants.Size),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                border: Border.all(
                                    width: 2,
                                    color: ColorConstants.tabbarcolor)),
                            child: Center(
                                child: Text(
                              "S",
                              style: StyleConstants.Size,
                            )),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                border: Border.all(
                                    width: 2,
                                    color: ColorConstants.tabbarcolor)),
                            child: Center(
                                child: Text(
                              "M",
                              style: StyleConstants.Size,
                            )),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                border: Border.all(
                                    width: 2,
                                    color: ColorConstants.tabbarcolor)),
                            child: Center(
                                child: Text(
                              "L",
                              style: StyleConstants.Size,
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

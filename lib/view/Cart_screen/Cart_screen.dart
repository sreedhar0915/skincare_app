import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/Utilis/constants/style_constants.dart';
import 'package:skincare_app/controller/cartscreen_controller.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarsection(),
      body: Consumer<CartController>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              Column(
                  children: List.generate(
                      value.storedProducts.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: NetworkImage(value
                                                        .storedProducts[index]
                                                            ["image"]
                                                        .toString()))),
                                          ),
                                          SizedBox(width: 30),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.storedProducts[index]
                                                          ["name"]
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  "\$ ${value.storedProducts[index]["Amount"].toString()}",
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          increment_decrement_button(
                                              value, index)
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Remove_button(value, index),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))),
              Checkout_section(value)
            ],
          ),
        ),
      ),
    );
  }

  Padding Checkout_section(CartController value) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("TOTAL AMOUNT:",
                      style: StyleConstants.checkout(ColorConstants.black)),
                  SizedBox(width: 5),
                  Text("\$ ${value.totalcartvalue.toString()}",
                      style: StyleConstants.checkout(ColorConstants.black)),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorConstants.tabbarcolor,
                    ),
                    child: Center(
                        child: Text(
                      "CHECKOUT",
                      maxLines: 1,
                      style: StyleConstants.category(ColorConstants.black),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell Remove_button(CartController value, int index) {
    return InkWell(
      onTap: () async {
        await value.removeProduct(value.storedProducts[index]["id"]);
      },
      child: Container(
        height: 50,
        // width: double.infinity,
        decoration: BoxDecoration(
            color: ColorConstants.tabbarcolor,
            borderRadius: BorderRadius.circular(15)),
        child: Center(child: Text("Remove")),
      ),
    );
  }

  Column increment_decrement_button(CartController value, int index) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              await value.incrementQty(
                  qty: value.storedProducts[index]["qty"],
                  id: value.storedProducts[index]["id"]);
            },
            child: Text("+")),
        Text(value.storedProducts[index]["qty"].toString()),
        ElevatedButton(
            onPressed: () async {
              await value.decrementQty(
                  qty: value.storedProducts[index]["qty"],
                  id: value.storedProducts[index]["id"]);
            },
            child: Text("-"))
      ],
    );
  }

  AppBar Appbarsection() {
    return AppBar(
      backgroundColor: ColorConstants.tabbarcolor,
      surfaceTintColor: ColorConstants.tabbarcolor,
      title:
          Text("MY CART", style: StyleConstants.heading(ColorConstants.white)),
      actions: [
        CircleAvatar(
            radius: 20,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: ColorConstants.tabbarcolor,
                ))),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

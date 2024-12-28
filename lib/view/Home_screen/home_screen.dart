import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/Utilis/constants/style_constants.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/view/Globalwidget/Product_card.dart';
import 'package:skincare_app/view/Globalwidget/product_collection_card.dart';
import 'package:skincare_app/view/product_screen/product_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomescreenController>().getcategorylist();

        context.read<HomescreenController>().getproductlist();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: Appbarsection(),
      body: Consumer<HomescreenController>(
        builder: (context, value, child) => value.isloadings
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Textfield(),
                    SizedBox(height: 15),
                    Browsesection(),
                    SizedBox(height: 10),
                    categorylist(value),
                    SizedBox(height: 20),
                    value.isproductloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : productcard_horizontal(value),
                    productcollectionsection(),
                    value.isproductloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : productcollectionlist(value, context),
                  ],
                ),
              ),
      ),
    );
  }

  Padding Browsesection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Text("Browse by categories",
              style: StyleConstants.heading(ColorConstants.black)),
          Spacer(),
          TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: StyleConstants.viewall(ColorConstants.circlebag),
                selectionColor: ColorConstants.circlebag,
              ))
        ],
      ),
    );
  }

  Column productcollectionlist(
      HomescreenController value, BuildContext context) {
    return Column(
        children: List.generate(
      value.shoppinglist.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductScreen(
                          productID: value.shoppinglist[index].id!,
                        )));
          },
          child: Productcollectioncard(
            imageurl: value.shoppinglist[index].image.toString(),
            productname: value.shoppinglist[index].title.toString(),
            description: value.shoppinglist[index].description.toString(),
          ),
        ),
      ),
    ));
  }

  Padding productcollectionsection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Text(
            "Product collections",
            style: StyleConstants.heading(ColorConstants.black),
          ),
          Spacer(),
          TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: StyleConstants.viewall(ColorConstants.circlebag),
                selectionColor: ColorConstants.circlebag,
              ))
        ],
      ),
    );
  }

  SizedBox productcard_horizontal(HomescreenController value) {
    return SizedBox(
      height: 365,
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(
                                productID: value.shoppinglist[index].id!,
                              )));
                },
                child: ProductCard(
                  imageurl: value.shoppinglist[index].image.toString(),
                  productname: value.shoppinglist[index].title.toString(),
                  description: value.shoppinglist[index].description.toString(),
                  price: value.shoppinglist[index].price.toString(),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 24,
              ),
          itemCount: value.shoppinglist.length),
    );
  }

  SizedBox categorylist(HomescreenController value) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: value.categorylist.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            value.Oncategoryselection(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 110,
              height: 38,
              decoration: HomescreenController.selectedindex == index
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: ColorConstants.tabbarcolor,
                      ))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: ColorConstants.grey,
                      )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Center(
                  child: Text(
                    value.categorylist[index].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleConstants.category(
                      HomescreenController.selectedindex == index
                          ? ColorConstants.tabbarcolor
                          : ColorConstants.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding Textfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search products',
          labelStyle: TextStyle(color: ColorConstants.textfieldtextcolor),
          hintText: "Search products",
          hintStyle: TextStyle(color: ColorConstants.textfieldtextcolor),
          prefixIcon: Image.asset("assets/images/search-line 1.png"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: ColorConstants.textfieldcolor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }

  AppBar Appbarsection() {
    return AppBar(
      backgroundColor: ColorConstants.white,
      surfaceTintColor: ColorConstants.white,
      leading: Image.asset("assets/images/menu.png"),
      title: Center(
        child: Container(
          height: 50,
          child: Image.asset(
            "assets/images/the ordinary.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        Image.asset("assets/images/notification.png"),
        SizedBox(width: 10),
      ],
    );
  }
}

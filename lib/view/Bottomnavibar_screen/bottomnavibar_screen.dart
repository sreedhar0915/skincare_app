import 'package:flutter/material.dart';
import 'package:skincare_app/Utilis/constants/color_constants.dart';
import 'package:skincare_app/view/Cart_screen/Cart_screen.dart';
import 'package:skincare_app/view/Home_screen/home_screen.dart';

class BottomnavibarScreen extends StatefulWidget {
  const BottomnavibarScreen({super.key});

  @override
  State<BottomnavibarScreen> createState() => _BottomnavibarScreenState();
}

class _BottomnavibarScreenState extends State<BottomnavibarScreen> {
  int selecttab = 0;

  final List<Widget> screens = [
    Homescreen(),
    Cartscreen(),
    Container(child: Center(child: Text("Saved screen"))),
    Container(child: Center(child: Text("Profile screen"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selecttab],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          selecttab = value;
        });
      },
      selectedItemColor: ColorConstants.maincolor,
      unselectedItemColor: ColorConstants.maincolor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          activeIcon: Image.asset("assets/images/Home.png"),
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.category_outlined),
          icon: Image.asset("assets/images/element-3.png"),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite_border),
          icon: Image.asset("assets/images/heart.png"),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person_outlined),
          icon: Image.asset("assets/images/profile.png"),
          label: "Profile",
        ),
      ],
    );
  }
}

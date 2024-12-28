import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/cartscreen_controller.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';
import 'package:skincare_app/controller/productscreen_controller.dart';
import 'package:skincare_app/view/Bottomnavibar_screen/bottomnavibar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomescreenController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => ProductscreenController()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: BottomnavibarScreen()),
    );
  }
}

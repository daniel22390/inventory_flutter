import 'package:flutter/material.dart';
import 'package:inventory/pages/create_product.dart';
import 'package:inventory/pages/detail_product.dart';
import 'package:provider/provider.dart';
import 'package:inventory/pages/auth_or_app_page.dart';
import 'package:inventory/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
        fontFamily: 'OpenSans',
      ),
      // home: AuthOrAppPage(),
      routes: {
        AppRoutes.home: (ctx) => const AuthOrAppPage(),
        AppRoutes.newproduct: (ctx) => const CreateProduct(),
        AppRoutes.detailsproduct: (ctx) => const DetailProduct(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

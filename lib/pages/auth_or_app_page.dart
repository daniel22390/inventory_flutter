import 'package:flutter/material.dart';
import 'package:inventory/core/models/inventory_user.dart';
import 'package:inventory/core/services/auth_service.dart';
import 'package:inventory/pages/auth_page.dart';
import 'package:inventory/pages/loading_page.dart';
import 'package:inventory/pages/menu_page.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<InventoryUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? MenuPage() : AuthPage();
              }
            },
          );
        }
      }
    );
  }
}

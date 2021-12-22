import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/MenuController.dart';
import '../../screens/layouts/header.dart';
import 'side_menu.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(),
                    child,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

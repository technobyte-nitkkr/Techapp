import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import '../../screens/layouts/header.dart';
import 'side_menu.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: Stack(
        children: [
          getGradient(),
          SafeArea(
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
        ],
      ),
    );
  }
}

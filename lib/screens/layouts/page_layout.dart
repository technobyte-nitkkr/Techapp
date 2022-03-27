import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import '../../screens/layouts/header.dart';
import 'side_menu.dart';

class PageLayout extends StatelessWidget {
  final Widget child;

  PageLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: Stack(
        children: [
          getGradient(context),
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Header(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
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
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';
import '../../screens/layouts/header.dart';
import 'side_menu.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  String? title;
  bool? isHome;

  PageLayout({
    Key? key,
    required this.child,
    this.title,
    this.isHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isHome == true ? SideMenu() : null,
      extendBodyBehindAppBar: true,
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
                      isHome == true
                          ? Header()
                          : Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // back button
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Text("  Techspardha",
                                        style: h1s.copyWith(
                                            fontFamily: 'Poppins')),
                                    SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

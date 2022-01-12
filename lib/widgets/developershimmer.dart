import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperCardShimmer extends StatelessWidget {
  const DeveloperCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 8,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemBuilder: (BuildContext ctx, int index) {
        return shimmerCard();
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 250,
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }

  ClipRRect shimmerCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Shimmer.fromColors(
        baseColor: white,
        highlightColor: Colors.white24,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white24,
            boxShadow: [
              BoxShadow(
                color: glowColor.withOpacity(0.2),
                blurRadius: 30,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: white,
                highlightColor: Colors.white24,
                child: Container(
                  height: 140,
                  width: double.infinity,
                ),
              ),
              Shimmer.fromColors(
                baseColor: white,
                highlightColor: Colors.white24,
                child: Container(
                  height: 15,
                  width: double.infinity,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.white24,
                highlightColor: Colors.white,
                child: Container(
                  height: 8,
                  width: double.infinity,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: white,
                      ),
                      onPressed: () async {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: white,
                      ),
                      onPressed: () async {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: white,
                      ),
                      onPressed: () async {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

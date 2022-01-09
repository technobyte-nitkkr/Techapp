// @dart=2.9
import 'dart:async';
import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/developers.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/widgets/developer_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedDeveloper extends StatefulWidget {
  const AnimatedDeveloper({Key key}) : super(key: key);

  @override
  _AnimatedDeveloperState createState() => _AnimatedDeveloperState();
}

class _AnimatedDeveloperState extends State<AnimatedDeveloper> {
  int _currentPage = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();

    return FutureBuilder(
      future: client.getAboutDev(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          print(errormessage);
          return Stack(
            children: [
              getGradient(),
              Center(
                child: Text(
                  // ignore: unnecessary_null_comparison
                  (errormessage.toString() == null) ? 'Error' : errormessage,
                  style: TextStyle(color: white, fontSize: 20),
                ),
              )
            ],
          );
        } else if (snapshot.hasData) {
          // ignore: unused_local_variable
          List<Developer> developers = snapshot.data.getDevelopers();

          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/developers/wall' +
                          (_currentPage + 1).toString() +
                          '.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Swiper(
                      itemHeight: MediaQuery.of(context).size.height * 0.5,
                      itemWidth: MediaQuery.of(context).size.width * 0.8,
                      onIndexChanged: (index) {
                        setState(() {
                          _currentPage = index % 6;
                        });
                      },
                      itemCount: developers.length,
                      layout: SwiperLayout.TINDER,
                      autoplay: true,
                      autoplayDelay: 2000,
                      itemBuilder: (context, index) {
                        return DeveloperWidget(
                          developer: developers[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              getGradient(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: white, size: 200),
                ),
              )
            ],
          );
        }
      },
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  final Developer developer;
  const DeveloperWidget({
    Key key,
    this.developer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeveloperCard(
        name: developer.name,
        imageSrc: developer.imageurl,
        year: developer.year,
        link: developer.link,
        press: () async {
          if (!await canLaunch(developer.link)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Link Invalid !!", textAlign: TextAlign.center),
                backgroundColor: Colors.orange,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20)));
          } else {
            await launch(developer.link);
          }
        });
  }
}

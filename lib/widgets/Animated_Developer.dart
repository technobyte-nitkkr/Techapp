// @dart=2.9
import 'dart:async';
import 'dart:ui';
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
  List<String> data = [
    "https://cdn.dribbble.com/users/3281732/screenshots/8159457/media/9e7bfb83b0bd704e941baa7a44282b22.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/7012328/media/bcd672685071ca4da27d5f3ea44ac5db.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/10940512/media/b2a8ea95c550e5f09d0ca07682a3c0da.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/8616916/media/a7e39b15640f8883212421d134013e38.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/6590709/samji_illustrator.jpg?compress=1&resize=600x600",
  ];

  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
                  key: ValueKey<String>(data[_currentPage]),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data[_currentPage]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 15,
                      sigmaY: 15,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.55,
                child: PageView.builder(
                  itemCount: developers.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return FractionallySizedBox(
                        widthFactor: 0.8,
                        child: DeveloperWidget(developer: developers[index]));
                  },
                ),
              )
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

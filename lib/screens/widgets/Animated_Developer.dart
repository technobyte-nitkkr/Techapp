// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/developers.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/widgets/developer_card.dart';
import 'package:techapp/screens/widgets/developershimmer.dart';

class AnimatedDeveloper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();
    return FutureBuilder(
      future: client.getAboutDev(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          debugPrint(errormessage);
          return Stack(
            children: [
              Center(
                child: Text(
                  // ignore: unnecessary_null_comparison
                  (errormessage.toString() == null) ? 'Error' : errormessage,
                  style: h2s,
                ),
              )
            ],
          );
        } else if (snapshot.hasData) {
          // ignore: unused_local_variable
          List<Developer> developers = snapshot.data.getDevelopers();

          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: developers.length,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemBuilder: (BuildContext ctx, int index) {
                  return DeveloperWidget(
                    developer: developers[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 250,
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            ],
          );
        } else {
          return DeveloperCardShimmer();
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
      linkedin: developer.linkedin,
      github: developer.github,
      insta: developer.insta,
    );
  }
}

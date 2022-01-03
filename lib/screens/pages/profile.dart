import 'package:flutter/material.dart';

import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/sign_in_modal.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Stack(
        children: [
          getGradient(),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  if (FetchDataProvider.user != null)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(FetchDataProvider.user!.picture),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DetailTile(
                              icon: Icons.email,
                              text: FetchDataProvider.user!.email),
                          DetailTile(
                              icon: Icons.verified_user,
                              text: FetchDataProvider.user!.name),
                          if (FetchDataProvider.user!.onBoard)
                            DetailTile(
                                icon: Icons.school,
                                text: FetchDataProvider.user!.college!),
                          if (FetchDataProvider.user!.onBoard)
                            DetailTile(
                                icon: Icons.phone,
                                text: FetchDataProvider.user!.phone!),
                          if (FetchDataProvider.user!.onBoard)
                            DetailTile(
                                icon: Icons.calendar_today,
                                text: FetchDataProvider.user!.year!),
                        ],
                      ),
                    ),
                  if (FetchDataProvider.user!.onBoard == false)
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SignInModalWidget(),
                                );
                              });
                        },
                        child: Text("Update Profile"))
                ],
              ))
        ],
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const DetailTile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(this.icon),
        title: Text(
          text,
          style: TextStyle(fontSize: 15, color: black),
        ),
      ),
    );
  }
}

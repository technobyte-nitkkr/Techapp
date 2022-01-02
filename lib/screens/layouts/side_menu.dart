import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import 'package:techapp/screens/auth/google_login.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/profile.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          getGradient(),
          ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: DrawerHeader(
                  child: Column(
                    children: [
                      FirebaseAuth.instance.currentUser != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!),
                              radius: 40,
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/technologo.png',
                              ),
                              radius: 40,
                            ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.displayName : "Dummy Name"}",
                        style: TextStyle(color: white),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                          "${FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email : "Dummy Email"}",
                          style: TextStyle(color: white)),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.home,
                  color: white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/navigation',
                      ModalRoute.withName('/navigation'));
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              DrawerItem(
                  title: "My Events",
                  route: '/my_events',
                  icon: Icons.calendar_today_rounded),
              DrawerItem(
                  title: "Team Altius",
                  route: '/team_altius',
                  icon: Icons.group),
              DrawerItem(
                  title: "Developers ",
                  route: '/developers',
                  icon: Icons.developer_mode),
              ListTile(
                title:
                    Text('Your Profile', style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.person,
                  color: white,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                leading: Icon(
                  Icons.logout_outlined,
                  color: white,
                ),
                onTap: () async {
                  await FirebaseServices().googleSignOut();
                  Navigator.popUntil(context, (route) => false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GoogleLoginScreen()));
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  DrawerItem({
    Key? key,
    required this.title,
    required this.route,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(color: Colors.white)),
          leading: Icon(
            icon,
            color: white,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}

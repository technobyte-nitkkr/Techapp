import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import 'package:techapp/screens/auth/google_login.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  //List<bool> _isOpen = [false];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child:Column(
              children: [
                //Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
                const SizedBox(
                  height: 6,
                ),
                //Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                const SizedBox(
                  height: 2,
                ),
                //Text("${FirebaseAuth.instance.currentUser!.email}"),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('My Events'),
            leading: Icon(
              Icons.calendar_today_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/my_events');
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('Team Altius'),
            leading: Icon(
              Icons.group,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/team_altius');
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('About us'),
            leading: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('Developers'),
            leading: Icon(
              Icons.developer_mode,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/developers');
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            onTap: () async{
              await FirebaseServices().googleSignOut();
              Navigator.pop(context);
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
    );
  }
}

          // ExpansionPanelList(
          //   expandedHeaderPadding: EdgeInsets.all(0),
          //   expansionCallback: (int index, bool isExpanded) {
          //     setState(() {
          //       _isOpen[index] = !isExpanded;
          //     });
          //   },
          //   children: [
          //     ExpansionPanel(
          //         canTapOnHeader: true,
          //         headerBuilder: (context, isExpanded) {
          //           return ListTile(
          //             title: Text('Team Altius'),
          //             leading: Icon(
          //               Icons.group_add_rounded,
          //               color: Colors.black,
          //             ),
          //           );
          //         },
          //         body: Column(
          //           children: [
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Technobyte'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Microbus'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Mexperts'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Mechsoc'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Infrastructure'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Industry Cell'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('IIC'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Electroreck'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('EMR'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Antariksh'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //             ListTile(
          //               title: Text('Aeromodelling'),
          //               leading: Icon(Icons.account_tree),
          //               onTap: () {},
          //             ),
          //             Divider(
          //               height: 1,
          //               thickness: 1,
          //             ),
          //           ],
          //         ),
          //         isExpanded: _isOpen[0]),
          //   ],
          // ),
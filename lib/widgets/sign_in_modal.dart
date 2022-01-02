import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/services/apiBaseHelper.dart';

class SignInModalWidget extends StatefulWidget {
  const SignInModalWidget({Key? key}) : super(key: key);

  @override
  _SignInModalWidgetState createState() => _SignInModalWidgetState();
}

class _SignInModalWidgetState extends State<SignInModalWidget> {
  String? name = (FirebaseAuth.instance.currentUser != null)
      ? FirebaseAuth.instance.currentUser!.displayName
      : "Dummy Name";

  TextEditingController _college = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String _year = "First Year";

  var _years = ["First Year", "Second Year", "Third Year", "Fourth Year"];

  @override
  void initState() {
    _college.clear();
    _phone.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 30,
              alignment: Alignment.topRight,
              child: ElevatedButton(
                child: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              child: Text("Hi " + name!),
            ),
            Container(
              child: Text("we want few more details !"),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                    controller: _college,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Enter your college',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'College',
                        labelStyle: TextStyle(color: Colors.black)))),
            Container(
              margin: EdgeInsets.all(10),
              child: InputDecorator(
                decoration: InputDecoration(
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _years[0],
                    onChanged: (value) => {},
                    items: _years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                    controller: _phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Phone',
                        labelStyle: TextStyle(color: Colors.black)))),
            Container(
              child: ElevatedButton(
                child: Text("Submit"),
                onPressed: () async =>
                    await _handleSubmit(_college.text, _year, _phone.text),
              ),
            )
          ],
        ));
  }

  _handleSubmit(String college, String year, String phone) async {
    print("college: " + college + " year: " + year + " phone: " + phone);
    setState(() {
      _college.clear();

      _phone.clear();
    });
    // deal with api
    ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
    // deal with data and all
    var user;
    try {
      user = await _apiBaseHelper.put('signUpApp', {
        'email': FirebaseAuth.instance.currentUser!.email,
        'college': college,
        'year': year,
        'phone': phone,
      });
      print(user);

      if (user['success'] == true) {
        // let the user on profile
        FetchDataProvider.user =
            UserDetails.fromJson(user['information'] as Map<String, dynamic>);
        // save to storage
        await NotificationsProvider.saveUser(user);
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }
}

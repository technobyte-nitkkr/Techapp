import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/retrofit/response.dart';

class SignInModalWidget extends StatefulWidget {
  const SignInModalWidget({Key? key}) : super(key: key);

  @override
  _SignInModalWidgetState createState() => _SignInModalWidgetState();
}

class _SignInModalWidgetState extends State<SignInModalWidget> {
  String? name = (FirebaseAuth.instance.currentUser != null)
      ? FirebaseAuth.instance.currentUser!.displayName
      : "Dummy Name";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _college = TextEditingController();
  TextEditingController _phone = TextEditingController();
  String _year = "First Year";

  var _years = ["First Year", "Second Year", "Third Year", "Fourth Year"];

  @override
  void initState() {
    super.initState();
    _college.clear();
    _phone.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: MediaQuery.of(context).viewInsets,
      //margin: EdgeInsets.all(0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                alignment: Alignment.topRight,
                child: new TextButton(
                    child: new Icon(Icons.close, color: Colors.black, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                child: Text(
                  "Hi " + name! + " !",
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.all(10),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  " Please enter these details",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _college,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Enter your college',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'College Name',
                          labelStyle: TextStyle(color: Colors.black)))),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: _phone,
                      validator: (value) {
                        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Invalid Mobile Number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: Colors.black)))),
              Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  child: InputDecorator(
                      decoration: InputDecoration(
                          labelText: 'Study Year',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding: EdgeInsets.all(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("Study Year"),
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          isExpanded: true,
                          iconSize: 30,
                          elevation: 16,
                          value: _year,
                          onChanged: (String? newValue) {
                            setState(() {
                              _year = newValue!;
                            });
                          },
                          items: _years.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  child: Text(value),
                                ));
                          }).toList(),
                        ),
                      ))),
              Container(
                child: ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () =>
                      _handleSubmit(_college.text, _year, _phone.text),
                ),
              )
            ],
          )),
    ));
  }

  _handleSubmit(String college, String year, String phone) async {
    final client = ApiClient.create();
    if (_formKey.currentState!.validate() == true) {
      print("college: " + college + " year: " + year + " phone: " + phone);

      setState(() {
        _college.clear();
        _phone.clear();
      });

      //deal with api

      // deal with data and all
      ResponseData user;
      try {
        user = await client.signUp(await NotificationsProvider.getToken(),
            {"name": name, "college": college, "year": year, "phone": phone});

        print(user.data.toString());

        if (user.success) {
          // let the user on profile
          var token = user.data['token'];
          await NotificationsProvider.saveToken(token);

          final profile = user.data['user'] as Map<String, dynamic>;
          FetchDataProvider.user = UserDetails.fromJson(profile);
          // save to storage
          await NotificationsProvider.saveUser(FetchDataProvider.user!);
        }
      } catch (e) {
        print(e);
      }
      Navigator.pop(context);
    }
  }
}

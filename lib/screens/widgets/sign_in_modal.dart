import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techapp/models/user.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/providers/local_storage_provider.dart';
import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/retrofit/response.dart';
import 'package:techapp/screens/components/style.dart';

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
  String _year = "Fresher";

  var _years = ["Fresher", "Sophomore", "Prefinal year", "Final Year"];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _college.clear();
    _phone.clear();
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        margin: EdgeInsets.all(0),
        alignment: Alignment.topRight,
        child: new TextButton(
            child: new Icon(Icons.close, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
      backgroundColor: Colors.white,
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
          child: Container(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    "Hi " + name! + " !",
                    style: h4,
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
                Divider(
                  color: Colors.grey,
                  height: 8,
                  thickness: 2,
                  endIndent: 30,
                  indent: 30,
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
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 1.0)),
                            prefixIcon: Icon(
                              Icons.school,
                              color: Colors.blueGrey,
                            ),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter your college',
                            hintStyle: h3.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w300),
                            labelText: 'College Name',
                            labelStyle: h4))),
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone, color: Colors.blueGrey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0)),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Mobile Number',
                        hintStyle: h3.copyWith(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w300),
                        labelText: 'Mobile Number',
                        labelStyle: h4),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    child: InputDecorator(
                        decoration: InputDecoration(
                            labelText: 'Study Year',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blueGrey, width: 2.0)),
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
                    child: (!isloading)
                        ? Text("Submit")
                        : CircularProgressIndicator(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    onPressed: () =>
                        _handleSubmit(_college.text, _year, _phone.text),
                  ),
                )
              ],
            )),
      )),
    );
  }

  _handleSubmit(String college, String year, String phone) async {
    final client = ApiClient.create();
    if (_formKey.currentState!.validate() == true) {
      debugPrint(
          "college: " + college + "\n year: " + year + "\n phone: " + phone);

      setState(() {
        isloading = true;
      });
      //deal with api

      // deal with data and all
      ResponseData user;
      try {
        user = await client.signUp(await NotificationsProvider.getToken(),
            {"name": name, "college": college, "year": year, "phone": phone});

        debugPrint(user.data.toString());

        if (user.success) {
          // let the user on profile
          var token = user.data['token'];
          await NotificationsProvider.saveToken(token);

          final profile = user.data['user'] as Map<String, dynamic>;
          FetchDataProvider.user = UserDetails.fromJson(profile);
          // save to storage
          await NotificationsProvider.saveUser(FetchDataProvider.user!);

          setState(() {
            _college.clear();
            _phone.clear();
            isloading = false;
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      Navigator.pop(context);
    } else {
      debugPrint("Invalid Form Data");
    }
  }
}

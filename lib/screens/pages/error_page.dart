import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';

class ErrorPagge extends StatelessWidget {
  final String message;
  ErrorPagge({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getGradient(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                message,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 30,
                  color: white,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

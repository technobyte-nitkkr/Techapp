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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  message,
                  style: h1s,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: glowColor.withOpacity(0.7),
                      shadowColor: glowColor,
                      elevation: 5,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/splash", (route) => false);
                  },
                  child: Text(
                    'Retry',
                    style: h1s,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

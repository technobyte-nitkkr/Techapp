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
          getGradient(context),
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
                  style: elevatedButtonStyle,
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

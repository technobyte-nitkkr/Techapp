import 'package:flutter/material.dart';
import 'package:techapp/screens/components/style.dart';

class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double? size;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.iconData,
    required this.color,
    required this.size,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData, color: color, size: size),
              ],
            ),
            if (notificationCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  alignment: Alignment.center,
                  child: Text(
                    '$notificationCount',
                    style: h4,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

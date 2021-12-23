import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../components/style.dart';
import '../../controllers/MenuController.dart';
import '../../screens/components/style.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: white,
              ),
              onPressed: context.read<MenuController>().controlMenu,
            ),
            Text(
              "  Altius",
              style: TextStyle(
                color: white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search",
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         suffixIcon: InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.all(defaultPadding * 0.75),
//             margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//             ),
//             child: SvgPicture.asset("assets/icons/Search.svg"),
//           ),
//         ),
//       ),
//     );
//   }
// }

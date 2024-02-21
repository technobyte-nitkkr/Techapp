import 'package:flutter/material.dart';
import 'package:techapp/models/categories.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/events_by_category.dart';
import 'package:widget_mask/widget_mask.dart';

class SwiperCard extends StatelessWidget {
  final CategorySchema categoryName;
  final String fadeText;

  const SwiperCard({
    Key? key,
    required this.categoryName,
    required this.fadeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsByCategory(categoryName: categoryName),
          ),
        );
      },
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.height * 0.44,
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // opacity: 0.,
                    image: AssetImage('assets/images/PANEL1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 2,
              top: 320,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  categoryName.categoryName.substring(0, 1).toUpperCase() +
                      categoryName.categoryName.substring(1),
                  style: h3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.height * 0.354,
                height: MediaQuery.of(context).size.height * 0.228,
                margin: EdgeInsets.only(left: 18, top: 0, right: 10, bottom: 8),
                child: PhysicalModel(
                  elevation: 50, // Adjust the elevation as needed
                  color: Colors.transparent,
                  shadowColor:
                      Color.fromARGB(255, 169, 176, 239).withOpacity(.6),
                  //borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: Image.network(
                      categoryName.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/techspardha.png'),
                    ),
                    child: Image.asset(
                      "assets/images/Rectangle 17.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

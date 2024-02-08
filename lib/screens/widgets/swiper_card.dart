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
                width: MediaQuery.of(context).size.height * 0.4,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/PANEL1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13,
              top: 310,
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
                width: MediaQuery.of(context).size.height * 0.334,
                height: MediaQuery.of(context).size.height * 0.218,
                margin: EdgeInsets.only(left: 23, top: 0, right: 18, bottom: 8),
                child: PhysicalModel(
                  elevation: 20, // Adjust the elevation as needed
                  color: Colors.transparent,
                  shadowColor: Color.fromARGB(255, 169, 176, 239).withOpacity(.6),
                  //borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/techspardha.png',
                      image: categoryName.imgUrl,
                      fit: BoxFit.cover,
                      imageCacheWidth: 1000,
                      imageErrorBuilder: (context, error, stackTrace) =>
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

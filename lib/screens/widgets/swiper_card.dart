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
        child: Container(
          width: MediaQuery.of(context).size.height * 0.44,
          height: MediaQuery.of(context).size.height * 0.38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.354,
                height: MediaQuery.of(context).size.height * 0.228,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.transparent,
                  // clipBehavior: Clip.antiAlias,
                ),
                child: PhysicalModel(
                  elevation: 5,
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  child: WidgetMask(
                    childSaveLayer: true,
                    mask: Image.network(
                      categoryName.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/techspardha.png'),
                    ),
                    child: Image.asset(
                      "assets/images/Rectangle 18.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.height * 0.354,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 35, 57),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(73, 0, 0, 0),
                          offset: Offset(0, 1),
                          blurRadius: 10),
                      BoxShadow(
                          color: const Color.fromARGB(66, 0, 0, 0),
                          offset: Offset(0, 4),
                          blurRadius: 34),
                      BoxShadow(
                        color: const Color.fromARGB(38, 0, 0, 0),
                        offset: Offset(0, 19),
                        blurRadius: 45,
                      ),
                      BoxShadow(
                          color: const Color.fromARGB(10, 0, 0, 0),
                          offset: Offset(0, 33),
                          blurRadius: 30),
                      BoxShadow(
                        color: const Color.fromARGB(3, 0, 0, 0),
                        offset: Offset(0, 12),
                        blurRadius: 35,
                      )
                    ]),
                child: Center(
                  child: Text(
                    categoryName.categoryName.substring(0, 1).toUpperCase() +
                        categoryName.categoryName.substring(1),
                    style: h3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

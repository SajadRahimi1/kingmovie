import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.heroTag});
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: screenAppBar(context: context),
      backgroundColor: blackColor,
      body: ListView(children: [
        Hero(
            tag: heroTag,
            child: Center(
              child: SizedBox(
                width: Get.width / 1.6,
                height: Get.height / 2.5,
                child: Image.network(
                  "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            )),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: Get.width,
          height: Get.height / 2.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: darkBlue),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // title
            const Text(
              "المنتال (Elemental)",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),

            // score
            const Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.ltr,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("8.9",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xffffffff), fontSize: 18)),
                SizedBox(
                  width: 15,
                ),
                Text("200,682",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xffffffff),
                    )),
              ],
            ),

            // give star
            Center(
              child: Column(
                children: [
                  const Text(
                    "9.3 / 67",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          10,
                          (index) => Icon(
                                Icons.star,
                                color: Colors.yellow.shade800,
                                size: Get.width / 20,
                              )),
                    ),
                  ),
                  Text(
                    "به این فیلم امتیاز دهید",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: const Color(0xffffffff),
                        fontSize: 13 * MediaQuery.of(context).textScaleFactor),
                  ),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }
}

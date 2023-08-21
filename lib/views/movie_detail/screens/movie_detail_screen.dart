import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.heroTag});
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    RxInt starSelected = (-1).obs;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
            height: Get.height / 2.3,
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
                        textDirection: TextDirection.ltr,
                        children: List.generate(
                            10,
                            (index) => InkWell(
                                  onTap: () => starSelected.value = index,
                                  child: Obx(() => Icon(
                                        Icons.star,
                                        color: index <= starSelected.value
                                            ? yellowColor
                                            : const Color(0xff5B6228),
                                        size: Get.width / 20,
                                      )),
                                )),
                      ),
                    ),
                    Text(
                      "به این فیلم امتیاز دهید",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize:
                              13 * MediaQuery.of(context).textScaleFactor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "خلاصه داستان : ",
                style: TextStyle(color: yellowColor),
              ),
              const Text(
                "انیمیشن المنتال 2023 در شهری که ساکنانش، آتش، آب، خاک و هوا در کنار هم زندگی می‌کنند؛ یک زن جوان آتشین و یک مرد شوخ و شنگول و «همراه با جریان»، در شرف کشف یک چیز اساسی هستند؛ این که چقدر با هم اشتراک دارند.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white),
              ),
              // tabs
              Expanded(
                  child: TabBar(
                labelStyle: TextStyle(
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
                labelColor: yellowColor,
                indicatorColor: yellowColor,
                unselectedLabelColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                tabs: List.generate(
                    5,
                    (index) => Tab(
                          text: [
                            "توضیحات",
                            "دانلود",
                            "عوامل",
                            "نظرات",
                            "تریلر"
                          ][index],
                        )),
              ))
            ]),
          ),
          // pages
          SizedBox(
              width: Get.width,
              height: Get.height / 1.3,
              child: TabBarView(children: [
                SizedBox(),
                SizedBox(),
                Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  width: Get.width,
                                  height: Get.height / 11,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: blackColor,
                                      border:
                                          Border.all(color: Color(0xff3f3f3f))),
                                  child: Row(
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            "Shameik Moore",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const Text(
                                          "Shameik Moore",
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Color(0xff5f5f5f),
                                              fontSize: 14),
                                        ),
                                      ]),
                                ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "مشاهده همه\t",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: Get.width / 22,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(),
                SizedBox(),
              ])),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}

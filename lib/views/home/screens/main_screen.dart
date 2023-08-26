import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/menu.dart';
import 'package:king_movie/viewmodels/home_viewmodel.dart';
import 'package:king_movie/views/home/screens/show_all_screen.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MainScreen extends StatelessWidget {
  List<Jalali> getDaysOfCurrentWeek() {
    final now = DateTime.now();
    final currentWeekday = now.toJalali().weekDay;

    // First day of the week
    final firstDay = now.subtract(Duration(days: currentWeekday - 1));

    // Last day of the week
    final lastDay =
        now.add(Duration(days: DateTime.daysPerWeek - currentWeekday));

    // List of each day as DateTime
    return List.generate(lastDay.difference(firstDay).inDays + 1,
        (index) => firstDay.add(Duration(days: index)).toJalali());
  }

  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeViewModel());
    final daysList = getDaysOfCurrentWeek();

    return SafeArea(
        child: controller.obx(
      (status) => Scaffold(
        backgroundColor: blackColor,
        appBar: homeAppBar(context: context),
        drawer: const Menu(),
        body: ListView(children: [
          // search text form field
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height / 20, horizontal: Get.width / 20),
            child: SizedBox(
              width: Get.width,
              height: Get.height / 18,
              child: TextFormField(
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    focusColor: darkBlue,
                    filled: true,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: yellowColor,
                    ),
                    hintStyle:
                        const TextStyle(color: Color(0xffafafaf), fontSize: 12),
                    fillColor: textFormColor,
                    hintText: "فیلم و سریال را جست وجوی کنید",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ),

          // banners
          SizedBox(
            width: Get.width,
            height: Get.height / 2.8,
            child: CarouselSlider(
                items: List.generate(
                    controller.homeModel?.data?.slider?.length ?? 0,
                    (index) => InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                        heroTag: 'Elemental$index',
                                      ))),
                          child: Column(
                            children: [
                              Expanded(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: 'Elemental$index',
                                  child: Image.network(
                                    controller.homeModel?.data?.slider?[index]
                                            .poster ??
                                        "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                              Text(
                                controller.homeModel?.data?.slider?[index]
                                        .title ??
                                    "",
                                style: const TextStyle(
                                    color: Color(0xffffffff), fontSize: 16),
                              ),
                              Text(
                                controller
                                        .homeModel?.data?.slider?[index].year ??
                                    "",
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              )
                            ],
                          ),
                        )),
                options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                    viewportFraction: 0.48)),
          ),
          SizedBox(
            height: Get.height / 20,
          ),

          // new series and movies
          Container(
            width: Get.width,
            height: Get.height / 2,
            color: darkBlue,
            child: DefaultTabController(
              length: 2,
              child: Column(children: [
                const TabBar(
                  tabs: [
                    Tab(
                      text: "سریال های بروز شده",
                    ),
                    Tab(
                      text: "فیلم های بروز شده",
                    )
                  ],
                  indicatorColor: yellowColor,
                ),
                Expanded(
                  child: TabBarView(
                      children: List.generate(
                          2,
                          (index) => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (_, listIndex) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: Get.width / 2.5,
                                      height: Get.height,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                                                  fit: BoxFit.fill,
                                                  height: Get.height,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width,
                                                    height: Get.height / 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                          Color.fromRGBO(
                                                              0, 0, 0, 0.8),
                                                          Color.fromRGBO(
                                                              0, 0, 0, 0.4),
                                                        ],
                                                                begin: Alignment
                                                                    .bottomCenter,
                                                                end: Alignment
                                                                    .topCenter)),
                                                    child: const Text(
                                                      "قسمت 2 فصل 1",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                          const Text(
                                            "المنتال (Elemental)",
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 16),
                                          ),
                                          const Text(
                                            "",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )))),
                ),
                InkWell(
                  onTap: () => Get.to(() => const ShowAllScreen(
                        title: "سریال های بروز شده",
                      )),
                  child: Row(
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
                ),
                SizedBox(
                  height: Get.height / 45,
                )
              ]),
            ),
          ),

          // box office
          Container(
            width: Get.width,
            height: Get.height / 2.2,
            color: darkBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "\tباکس آفیس",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17 * MediaQuery.of(context).textScaleFactor),
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: Get.width,
                                height: Get.height / 9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: blackColor,
                                ),
                                child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      const Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "1. Elemental | المنتال",
                                            textDirection: TextDirection.ltr,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "Weekend: \$18.5M",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "All: \$65.5M",
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Get.width / 25),
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: yellowColor,
                                          size: Get.width / 13,
                                        ),
                                      )
                                    ]),
                              ))),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height / 20,
          ),

          // Time line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
                width: Get.width,
                height: Get.height / 6.6,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "شنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[0].month.toString().toPersianDigit()}/${daysList[0].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "یکشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[1].month.toString().toPersianDigit()}/${daysList[1].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "دوشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[2].month.toString().toPersianDigit()}/${daysList[2].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "سه شنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[3].month.toString().toPersianDigit()}/${daysList[3].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "چهارشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[4].month.toString().toPersianDigit()}/${daysList[4].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "پنجشنبه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[5].month.toString().toPersianDigit()}/${daysList[5].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "جمعه",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${daysList[6].month.toString().toPersianDigit()}/${daysList[6].day.toString().toPersianDigit()}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                )),
          ),

          // time line widgets
          SizedBox(
            height: Get.height / 35,
          ),
          Column(
            children: List.generate(
                4,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      width: Get.width,
                      height: Get.height / 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: darkBlue,
                      ),
                      child: Row(textDirection: TextDirection.ltr, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "1. Elemental | المنتال",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: yellowColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("07:29",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor))
                              ],
                            )
                          ],
                        )),
                        Padding(
                            padding: EdgeInsets.only(right: Get.width / 25),
                            child: const Text("فصل 2 قسمت 4",
                                style: TextStyle(
                                  color: Colors.white,
                                )))
                      ]),
                    )),
          ),

          SizedBox(
            height: Get.height / 35,
          ),

          // new dub series and movies
          Container(
            width: Get.width,
            height: Get.height / 2,
            color: darkBlue,
            child: DefaultTabController(
              length: 2,
              child: Column(children: [
                TabBar(
                  labelStyle: TextStyle(
                      fontSize: 16 * MediaQuery.of(context).textScaleFactor),
                  tabs: const [
                    Tab(
                      text: "سریال های دوبله بروز شده",
                    ),
                    Tab(
                      text: "فیلم های دوبله بروز شده",
                    )
                  ],
                  indicatorColor: yellowColor,
                ),
                Expanded(
                  child: TabBarView(
                      children: List.generate(
                          2,
                          (index) => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (_, listIndex) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: Get.width / 2.5,
                                      height: Get.height,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                                                  fit: BoxFit.fill,
                                                  height: Get.height,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: Get.width,
                                                    height: Get.height / 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                          Color.fromRGBO(
                                                              0, 0, 0, 0.8),
                                                          Color.fromRGBO(
                                                              0, 0, 0, 0.4),
                                                        ],
                                                                begin: Alignment
                                                                    .bottomCenter,
                                                                end: Alignment
                                                                    .topCenter)),
                                                    child: const Text(
                                                      "قسمت 2 فصل 1",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                          const Text(
                                            "المنتال (Elemental)",
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 16),
                                          ),
                                          const Text(
                                            "",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )))),
                ),
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
                SizedBox(
                  height: Get.height / 45,
                )
              ]),
            ),
          ),

          SizedBox(
            height: Get.height / 25,
          )
        ]),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/menu.dart';
import 'package:king_movie/core/widgets/trailer_widget.dart';
import 'package:king_movie/viewmodels/movie_viewmodel.dart';
import 'package:king_movie/views/movie_detail/widgets/comment_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(
      {super.key, required this.heroTag, required this.movieId});
  final String heroTag;
  final String movieId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieViewModel(movieId));

    RxInt starSelected = (-1).obs;
    RxInt openEexpansionIndex = (-1).obs;
    RxBool isReply = false.obs;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: screenAppBar(context: context),
          backgroundColor: blackColor,
          drawer: const Menu(),
          body: controller.obx(
            (status) => ListView(children: [
              Hero(
                  tag: heroTag,
                  child: Center(
                    child: SizedBox(
                      width: Get.width / 1.6,
                      height: Get.height / 2.5,
                      child: Image.network(
                        controller.movieModel?.data?.poster ?? "",
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        controller.movieModel?.data?.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),

                      // score
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.ltr,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(controller.movieModel?.data?.vote ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xffffffff), fontSize: 18)),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(controller.movieModel?.data?.voter ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xffffffff),
                              )),
                        ],
                      ),

                      // give star
                      Center(
                        child: Column(
                          children: [
                            // const Text(
                            //   "9.3 / 67",
                            //   textDirection: TextDirection.ltr,
                            //   style: TextStyle(
                            //     color: Color(0xffffffff),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                children: List.generate(
                                    10,
                                    (index) => InkWell(
                                          onTap: () =>
                                              starSelected.value = index,
                                          child: Obx(() => Icon(
                                                Icons.star,
                                                color: index <=
                                                        starSelected.value
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
                                  fontSize: 13 *
                                      MediaQuery.of(context).textScaleFactor),
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
                      Text(
                        controller.movieModel?.data?.story ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.white),
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
                    // description
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            (controller.movieModel?.data?.text ?? "")
                                .replaceAll('<br>', '\n')
                                .replaceAll('&quot;', ''),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // downloads
                    SizedBox(
                      child: SingleChildScrollView(
                          child: Obx(
                        () => ExpansionPanelList(
                          expandIconColor: Colors.white,
                          expansionCallback: (panelIndex, isExpanded) =>
                              isExpanded
                                  ? openEexpansionIndex.value = -1
                                  : openEexpansionIndex.value = panelIndex,
                          children: [
                            ExpansionPanel(
                              backgroundColor: const Color(0xff49461d),
                              // canTapOnHeader: true,
                              isExpanded: openEexpansionIndex.value == 0,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) =>
                                      const ListTile(
                                          textColor: Colors.white,
                                          title: Text(
                                            "نسخه دوبله فارسی، سه زبانه",
                                          )),
                              body: Column(
                                children: List.generate(
                                  4,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      textColor: Colors.white,
                                      iconColor: Colors.white,
                                      titleTextStyle:
                                          const TextStyle(fontSize: 16),
                                      trailing: SizedBox(
                                        width: Get.width / 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.download,
                                              color: Colors.white,
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              color: Colors.blue,
                                              size: Get.width / 14,
                                            )
                                          ],
                                        ),
                                      ),
                                      title: Text(
                                        [
                                          "1080p WEB-DL | انکودر : KingMovie | حجم فایل: 1.73 گیگابایت",
                                          "720p WEB-DL | انکودر : KingMovie | حجم فایل: 970 مگابایت",
                                          "480p WEB-DL | انکودر : KingMovie | حجم فایل: 670 مگابایت",
                                          "صوت دوبله به صورت جداگانه | حجم فایل : 90 مگابایت"
                                        ][index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ExpansionPanel(
                              backgroundColor: const Color(0xff440f2d),
                              // canTapOnHeader: true,
                              isExpanded: openEexpansionIndex.value == 1,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) =>
                                      const ListTile(
                                          textColor: Colors.white,
                                          title: Text(
                                            "نسخه زیرنویس فارسی",
                                          )),
                              body: Column(
                                children: List.generate(
                                  2,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListTile(
                                      textColor: Colors.white,
                                      iconColor: Colors.white,
                                      titleTextStyle:
                                          const TextStyle(fontSize: 16),
                                      trailing: SizedBox(
                                        width: Get.width / 7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.download,
                                              color: Colors.white,
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              color: Colors.blue,
                                              size: Get.width / 14,
                                            )
                                          ],
                                        ),
                                      ),
                                      title: Text(
                                        [
                                          "دانلود نسخه 1080p WEB-DL | انکودر : KingMovie | حجم فایل: 1.55 گیگابایت",
                                          "دانلود نسخه 720p WEB-DL | انکودر : KingMovie | حجم فایل: 820 مگابایت"
                                        ][index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),

                    // actors
                    Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      width: Get.width,
                                      height: Get.height / 11,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: blackColor,
                                          border: Border.all(
                                              color: const Color(0xff3f3f3f))),
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
                                                textDirection:
                                                    TextDirection.ltr,
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

                    // comments
                    SizedBox(
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        children: [
                          Obx(() => isReply.value
                              ? InkWell(
                                  onTap: () => isReply.value = false,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Text(
                                        "پاسخ به کامنت فعال شد. جهت حذف اینجا کلیک نمایید",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()),
                          // text input
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height / 5,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                maxLines: 5,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: "نظر خود را ثبت کنید",
                                    hintStyle: const TextStyle(
                                        color: Color(0xff5f5f5f)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Color(0xff5f5f5f))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Color(0xff5f5f5f)))),
                              ),
                            ),
                          ),

                          // submit comment button
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.sizeOf(context).width /
                                            2.8) +
                                const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              "ثبت و ارسال",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          // comments
                          Column(
                            children: List.generate(
                                controller.movieModel?.data?.comment?.length ??
                                    0,
                                (index) => CommentWidget(
                                      onReplyTap: () => isReply.value = true,
                                      commentModel: controller
                                          .movieModel?.data?.comment?[index],
                                    )),
                          )
                        ],
                      ),
                    ),

                    // trailer
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: ListView.builder(
                        itemCount:
                            controller.movieModel?.data?.trailer?.length ?? 0,
                        itemBuilder: (_, index) => TrailerWidget(
                            trailerModel:
                                controller.movieModel?.data?.trailer?[index]),
                      ),
                    ),
                  ])),
              const SizedBox(
                height: 20,
              )
            ]),
          )),
    );
  }
}

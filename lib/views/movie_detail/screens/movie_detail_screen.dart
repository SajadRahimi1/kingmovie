import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/trailer_widget.dart';
import 'package:king_movie/viewmodels/movie_viewmodel.dart';
import 'package:king_movie/views/home/screens/search_screen.dart';
import 'package:king_movie/views/login/screens/login_screen.dart';
import 'package:king_movie/views/login/screens/singup_screen.dart';
import 'package:king_movie/views/menu/screens/vip_screen.dart';
import 'package:king_movie/views/movie_detail/widgets/comment_widget.dart';
import 'package:king_movie/views/movie_detail/widgets/series_tiles_widget.dart';
import 'package:king_movie/core/extensions/string_extension.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});
  final String movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final MovieViewModel controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state");
    controller = Get.put(MovieViewModel(widget.movieId));
    if (controller.movieModel != null) controller.getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RxInt starSelected = (-1).obs;

    return DefaultTabController(
        length: 5,
        child: Scaffold(
            backgroundColor: blackColor,
            appBar: screenAppBar(context: context),
            body: controller.obx(
              (status) => ListView(
                  controller: controller.pageScrollController,
                  cacheExtent: Get.height * 20,
                  children: [
                    //  poster
                    Center(
                      child: Obx(
                        () => controller.isInitialVideo.value
                            ? const SizedBox()
                            : Stack(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: Get.width / 1.6,
                                      height: Get.height / 2.5,
                                      child: Image.network(
                                        controller.movieModel?.data?.poster ??
                                            "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Obx(() => IconButton(
                                              icon: Icon(
                                                controller.isBookmarked.value
                                                    ? Icons.bookmark
                                                    : Icons
                                                        .bookmark_add_outlined,
                                                color: Colors.white,
                                                size: MediaQuery.sizeOf(context)
                                                        .width /
                                                    10,
                                              ),
                                              onPressed: controller.addFavorite,
                                            )),
                                      ))
                                ],
                              ),
                      ),
                    ),

                    // bottom of video
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      width: Get.width,
                      height: Get.height / 2.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: darkBlue),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              controller.movieModel?.data?.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontSize: 17 *
                                      MediaQuery.of(context).textScaleFactor,
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
                                        color: Color(0xffffffff),
                                        fontSize: 18)),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                          : const Color(
                                                              0xff5B6228),
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
                                            MediaQuery.of(context)
                                                .textScaleFactor),
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
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                            // tabs
                            Expanded(
                                child: TabBar(
                              onTap: (index) {
                                switch (index) {
                                  case 0:
                                    controller.pageScrollController
                                        .scrollToIndex(
                                            2,
                                            duration:
                                                const Duration(seconds: 1));
                                    break;
                                  case 1:
                                    controller.pageScrollController
                                        .scrollToIndex(4,
                                            duration: Duration(seconds: index));
                                    break;
                                  case 2:
                                    controller.pageScrollController
                                        .scrollToIndex(6,
                                            duration: Duration(seconds: index));
                                    break;
                                  case 3:
                                    controller.pageScrollController
                                        .scrollToIndex(8,
                                            duration: Duration(seconds: index));
                                    break;
                                  case 4:
                                    controller.pageScrollController
                                        .scrollToIndex(
                                            10,
                                            duration:
                                                const Duration(seconds: 3));
                                    break;
                                }
                              },
                              labelStyle: TextStyle(
                                fontSize:
                                    16 * MediaQuery.of(context).textScaleFactor,
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontSize:
                                    16 * MediaQuery.of(context).textScaleFactor,
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

                    // description
                    AutoScrollTag(
                        key: const ValueKey(2),
                        controller: controller.pageScrollController,
                        index: 2,
                        child: Text(
                          (controller.movieModel?.data?.text ?? "")
                              .replaceAll('<br>', '\n')
                              .replaceAll('&quot;', ''),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  13 * MediaQuery.of(context).textScaleFactor),
                        )),
                    Divider(
                      color: Colors.grey,
                      height: Get.height / 18,
                    ),

                    // downloads
                    AutoScrollTag(
                        key: const ValueKey(4),
                        controller: controller.pageScrollController,
                        index: 4,
                        child: SizedBox(
                          child: SingleChildScrollView(
                            child: (controller.movieModel?.data?.link?.data
                                        ?.isEmpty ??
                                    true)
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        SingletonClass.instance.user == null
                                            ? "برای استفاده از خدمات ابتدا وارد اپ شوید\n"
                                            : "برای پخش یا دانلود باید اشتراک خریداری کنید\n",
                                        style: TextStyle(
                                            fontSize: 17 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.white),
                                      ),
                                      SingletonClass.instance.user == null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const LoginScreen()),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "وارد شوید",
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Get.to(() =>
                                                      const SingupScreen()),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(7),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                      "ثبت نام کنید",
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : InkWell(
                                              onTap: () => Get.to(
                                                  () => const VipScreen()),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Text(
                                                  "خرید اشتراک",
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                : Column(
                                    children: List.generate(
                                    controller.movieModel?.data?.link?.data
                                            ?.length ??
                                        0,
                                    (index) => Column(children: [
                                      Container(
                                        width: Get.width,
                                        height: Get.height / 12,
                                        margin: EdgeInsets.only(
                                            top: Get.height / 18),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: controller.movieModel?.data
                                              ?.link?.data?[index].color
                                              .downloadColor(),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.movieModel?.data?.link
                                                      ?.data?[index].title ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              controller.movieModel?.data?.link
                                                      ?.data?[index].des ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      controller.movieModel?.data?.way == "1"
                                          ? Column(
                                              children: List.generate(
                                                  controller
                                                          .movieModel
                                                          ?.data
                                                          ?.link
                                                          ?.data?[index]
                                                          .list
                                                          ?.length ??
                                                      0,
                                                  (secondIndex) => ListTile(
                                                        tileColor: controller
                                                            .movieModel
                                                            ?.data
                                                            ?.link
                                                            ?.data?[index]
                                                            .color
                                                            .downloadColor(),
                                                        title: Text(
                                                          controller
                                                                  .movieModel
                                                                  ?.data
                                                                  ?.link
                                                                  ?.data?[index]
                                                                  .list?[
                                                                      secondIndex]
                                                                  .title ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        onTap: () => Get.dialog(SeriesDialog(
                                                            downloadList: controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.link
                                                                    ?.data?[index]
                                                                    .list?[
                                                                secondIndex],
                                                            initVideo: (initVideo) =>
                                                                controller
                                                                    .choosePlayer(
                                                                        initVideo),
                                                            download: (download) =>
                                                                controller.openUrl(
                                                                    download))),
                                                      )))
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: List.generate(
                                                controller
                                                        .movieModel
                                                        ?.data
                                                        ?.link
                                                        ?.data?[index]
                                                        .list
                                                        ?.length ??
                                                    0,
                                                (listIndex) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: ListTile(
                                                    textColor: Colors.white,
                                                    iconColor: Colors.white,
                                                    tileColor: darkBlue,
                                                    titleTextStyle:
                                                        const TextStyle(
                                                            fontSize: 16),
                                                    trailing: SizedBox(
                                                      width: Get.width / 7,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          controller
                                                                      .movieModel
                                                                      ?.data
                                                                      ?.link
                                                                      ?.data?[
                                                                          index]
                                                                      .list?[
                                                                          listIndex]
                                                                      .format ==
                                                                  'movie'
                                                              ? InkWell(
                                                                  onTap: () => controller.choosePlayer(controller
                                                                      .movieModel
                                                                      ?.data
                                                                      ?.link
                                                                      ?.data?[
                                                                          index]
                                                                      .list?[listIndex]),
                                                                  // onTap: () => Get.to(() => PlayMovieScreen(
                                                                  //     downloadList: controller
                                                                  //         .movieModel
                                                                  //         ?.data
                                                                  //         ?.link
                                                                  //         ?.data?[
                                                                  //             index]
                                                                  //         .list?[listIndex])),
                                                                  child: Icon(
                                                                    Icons
                                                                        .play_arrow,
                                                                    color: Colors
                                                                        .white,
                                                                    size:
                                                                        Get.width /
                                                                            14,
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                          InkWell(
                                                            onTap: () => controller
                                                                .openUrl(controller
                                                                        .movieModel
                                                                        ?.data
                                                                        ?.link
                                                                        ?.data?[
                                                                            index]
                                                                        .list?[
                                                                    listIndex]),
                                                            child: const Icon(
                                                              Icons.download,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    title: Text(
                                                      controller
                                                              .movieModel
                                                              ?.data
                                                              ?.link
                                                              ?.data?[index]
                                                              .list?[listIndex]
                                                              .title ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ]),
                                  )
                                    /*
                                  Obx(
                                      () => ExpansionPanelList(
                                        expandIconColor: Colors.white,
                                        expansionCallback: (panelIndex,
                                                isExpanded) =>
                                            isExpanded
                                                ? openEexpansionIndex.value = -1
                                                : openEexpansionIndex.value =
                                                    panelIndex,
                                        children: List.generate(
                                          controller.movieModel?.data?.link
                                                  ?.data?.length ??
                                              0,
                                          (index) => ExpansionPanel(
                                            backgroundColor: controller
                                                .movieModel
                                                ?.data
                                                ?.link
                                                ?.data?[index]
                                                .color
                                                .downloadColor(),
                                            // canTapOnHeader: true,
                                            isExpanded:
                                                openEexpansionIndex.value ==
                                                    index,
                                            headerBuilder:
                                                (BuildContext context,
                                                        bool isExpanded) =>
                                                    ListTile(
                                                        textColor: Colors.white,
                                                        title: Text(
                                                          '${controller.movieModel?.data?.link?.data?[index].title ?? ""} ${controller.movieModel?.data?.link?.data?[index].des ?? ""}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width /
                                                                      30),
                                                        )),
                                            body:
                                                controller.movieModel?.data
                                                            ?.way ==
                                                        "1"
                                                    ? Column(
                                                        children: List.generate(
                                                            controller
                                                                    .movieModel
                                                                    ?.data
                                                                    ?.link
                                                                    ?.data?[
                                                                        index]
                                                                    .list
                                                                    ?.length ??
                                                                0,
                                                            (secondIndex) =>
                                                                ListTile(
                                                                  title: Text(
                                                                    controller
                                                                            .movieModel
                                                                            ?.data
                                                                            ?.link
                                                                            ?.data?[index]
                                                                            .list?[secondIndex]
                                                                            .title ??
                                                                        "",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  onTap: () => Get.dialog(SeriesDialog(
                                                                      downloadList: controller
                                                                          .movieModel
                                                                          ?.data
                                                                          ?.link
                                                                          ?.data?[
                                                                              index]
                                                                          .list?[secondIndex],
                                                                      initVideo: (initVideo) => controller.initVideo(initVideo),
                                                                      download: (download) => controller.openUrl(download))),
                                                                )))
                                                    : Column(
                                                        children: List.generate(
                                                          controller
                                                                  .movieModel
                                                                  ?.data
                                                                  ?.link
                                                                  ?.data?[index]
                                                                  .list
                                                                  ?.length ??
                                                              0,
                                                          (listIndex) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: ListTile(
                                                              textColor:
                                                                  Colors.white,
                                                              iconColor:
                                                                  Colors.white,
                                                              titleTextStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                              trailing:
                                                                  SizedBox(
                                                                width:
                                                                    Get.width /
                                                                        7,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    controller.movieModel?.data?.link?.data?[index].list?[listIndex].format ==
                                                                            'movie'
                                                                        ? InkWell(
                                                                            onTap: () =>
                                                                                controller.initVideo(controller.movieModel?.data?.link?.data?[index].list?[listIndex]),
                                                                            child:
                                                                                Icon(
                                                                              Icons.play_arrow,
                                                                              color: Colors.blue,
                                                                              size: Get.width / 14,
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                    InkWell(
                                                                      onTap: () => controller.openUrl(controller
                                                                          .movieModel
                                                                          ?.data
                                                                          ?.link
                                                                          ?.data?[
                                                                              index]
                                                                          .list?[listIndex]),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .download,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              title: Text(
                                                                controller
                                                                        .movieModel
                                                                        ?.data
                                                                        ?.link
                                                                        ?.data?[
                                                                            index]
                                                                        .list?[
                                                                            listIndex]
                                                                        .title ??
                                                                    "",
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                          ),*/
                                    ),
                          ),
                        )),

                    Divider(
                      color: Colors.grey,
                      height: Get.height / 18,
                    ),

                    // actors
                    AutoScrollTag(
                      key: const ValueKey(6),
                      controller: controller.pageScrollController,
                      index: 6,
                      child: SizedBox(
                          child: Column(
                              children: List.generate(
                                  controller.movieModel?.data?.cast?.length ??
                                      0,
                                  (index) => InkWell(
                                        onTap: () => Get.off(() => SearchScreen(
                                              title: "",
                                              cast: controller.movieModel?.data
                                                  ?.cast?[index].name,
                                              movieId: widget.movieId,
                                            )),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          width: Get.width,
                                          height: Get.height / 11,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: blackColor,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff3f3f3f))),
                                          child: Row(
                                              textDirection: TextDirection.ltr,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    controller
                                                            .movieModel
                                                            ?.data
                                                            ?.cast?[index]
                                                            .image ??
                                                        "",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                    controller
                                                            .movieModel
                                                            ?.data
                                                            ?.cast?[index]
                                                            .name ??
                                                        "",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                            .movieModel
                                                            ?.data
                                                            ?.cast?[index]
                                                            .simple ??
                                                        "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff5f5f5f),
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      )))),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: Get.height / 18,
                    ),

                    // comments
                    AutoScrollTag(
                        key: const ValueKey(8),
                        controller: controller.pageScrollController,
                        index: 8,
                        child: SizedBox(
                          child: Column(
                            // controller: controller.commentScrollController,
                            // physics: const BouncingScrollPhysics(
                            //     parent: BouncingScrollPhysics()),
                            children: [
                              Obx(() => controller.replyId.value.isNotEmpty
                                  ? InkWell(
                                      onTap: () =>
                                          controller.replyId.value = "",
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
                                    controller: controller.commentController,
                                    textInputAction: TextInputAction.done,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: "نظر خود را ثبت کنید",
                                        hintStyle: const TextStyle(
                                            color: Color(0xff5f5f5f)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff5f5f5f))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Color(0xff5f5f5f)))),
                                  ),
                                ),
                              ),

                              // submit comment button
                              InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  await controller.comment();
                                },
                                child: Container(
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
                              ),

                              // comments
                              Obx(
                                () => controller.commentUpdate.value > 0
                                    ? Column(
                                        children: List.generate(
                                            controller.movieModel?.data?.comment
                                                    ?.length ??
                                                0,
                                            (index) => CommentWidget(
                                                  onReplyTap: (id) {
                                                    controller.replyId.value =
                                                        id;
                                                    controller
                                                        .pageScrollController
                                                        .scrollToIndex(8);
                                                  },
                                                  commentModel: controller
                                                      .movieModel
                                                      ?.data
                                                      ?.comment?[index],
                                                  onLikeTap: (id) =>
                                                      controller.likeComment(
                                                          id: id, way: 'like'),
                                                  onDislikeTap: (id) =>
                                                      controller.likeComment(
                                                          id: id,
                                                          way: 'dislike'),
                                                )))
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        )),
                    Divider(
                      color: Colors.grey,
                      height: Get.height / 18,
                    ),

                    // trailer
                    AutoScrollTag(
                      key: const ValueKey(10),
                      controller: controller.pageScrollController,
                      index: 10,
                      child: SizedBox(
                          child: Column(
                        children: List.generate(
                          controller.movieModel?.data?.trailer?.length ?? 0,
                          (index) => InkWell(
                            onTap: () async {
                              if (controller
                                      .movieModel?.data?.trailer?[index].type ==
                                  'trailer') {
                                await controller.initTrailer(controller
                                        .movieModel
                                        ?.data
                                        ?.trailer?[index]
                                        .view ??
                                    "");
                              }
                            },
                            child: TrailerWidget(
                                trailerModel: controller
                                    .movieModel?.data?.trailer?[index]),
                          ),
                        ),
                      )),
                    )
                  ]),
            )));
  }
}

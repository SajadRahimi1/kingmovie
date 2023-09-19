import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/models/advance_search_model.dart';
import 'package:king_movie/viewmodels/search_viewmodel.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {super.key, required this.title, this.advanceSearchModel, this.cast});
  final String title;
  final String? cast;
  final AdvanceSearchModel? advanceSearchModel;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(SearchViewModel(title, advanceSearchModel, cast));

    return Scaffold(
      appBar: menuAppBar(
          context: context, title: cast ?? advanceSearchModel?.title ?? title),
      backgroundColor: blackColor,
      body: controller.obx((state) => ListView.builder(
          padding: const EdgeInsets.all(5),
          physics: const BouncingScrollPhysics(),
          controller: controller.scrollController,
          itemCount: (controller.searchModel?.data?.dataList?.length ?? 0) + 1,
          itemBuilder: (_, index) => index ==
                  controller.searchModel?.data?.dataList?.length
              ? controller.isLastPage
                  ? const SizedBox()
                  : const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () => Get.to(() => MovieDetailScreen(
                      movieId:
                          controller.searchModel?.data?.dataList?[index].id ??
                              "")),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height / 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkBlue),
                    child: Row(
                      children: [
                        // texts
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // title
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Text(
                                  controller.searchModel?.data?.dataList?[index]
                                          .title ??
                                      "",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17 *
                                          MediaQuery.of(context)
                                              .textScaleFactor),
                                ),
                              ),

                              const Spacer(),
                              // subtitle
                              Text(
                                "زیرنویس : ${controller.searchModel?.data?.dataList?[index].subtitle ?? ""}",
                                style: const TextStyle(color: Colors.white),
                              ),

                              // age
                              Text(
                                "رده سنی : ${controller.searchModel?.data?.dataList?[index].age ?? ""}",
                                style: const TextStyle(color: Colors.white),
                              ),

                              // language
                              Text(
                                "زبان : ${controller.searchModel?.data?.dataList?[index].lang ?? ""}",
                                style: const TextStyle(color: Colors.white),
                              ),

                              // description
                              Text(
                                controller.searchModel?.data?.dataList?[index]
                                        .genre ??
                                    "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 55,
                              ),
                            ],
                          ),
                        )),
                        // image
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 3,
                          height: MediaQuery.sizeOf(context).height,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.searchModel?.data?.dataList?[index]
                                      .poster ??
                                  "",
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
    );
  }
}

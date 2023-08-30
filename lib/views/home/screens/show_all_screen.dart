import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/menu.dart';
import 'package:king_movie/viewmodels/new_all_viewmodel.dart';

class ShowAllScreen extends StatelessWidget {
  const ShowAllScreen({super.key, required this.isMovie, this.dub});
  final bool isMovie;
  final bool? dub;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewAllViewModel(isMovie: isMovie, dub: dub));

    return Scaffold(
      appBar: screenAppBar(
          context: context,
          title: "${isMovie ? 'فیلم' : 'سریال'} های بروز شده"),
      backgroundColor: blackColor,
      drawer: const Menu(),
      body: controller.obx((state) => ListView.builder(
          padding: const EdgeInsets.all(5),
          physics: const BouncingScrollPhysics(),
          controller: controller.scrollController,
          itemCount: controller.movieList.length + 1,
          itemBuilder: (_, index) => index == controller.movieList.length
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 4.5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: darkBlue),
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
                                controller.movieList[index].title ?? "",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15 *
                                        MediaQuery.of(context).textScaleFactor),
                              ),
                            ),

                            const Spacer(),
                            // subtitle
                            Text(
                              (dub ?? false)
                                  ? "دوبله : ${(controller.movieList[index].double ?? false) ? 'دارد' : 'ندارد'}"
                                  : "زیرنویس : ${controller.movieList[index].subtitle ?? ""}",
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white),
                            ),

                            // age
                            Text(
                              "رده سنی : ${controller.movieList[index].age ?? ""}",
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white),
                            ),

                            // language
                            Text(
                              "زبان : ${controller.movieList[index].lang ?? ""}",
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white),
                            ),

                            // description
                            Text(
                              controller.movieList[index].story ?? "",
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
                        width: MediaQuery.sizeOf(context).width / 3.5,
                        height: MediaQuery.sizeOf(context).height,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            controller.movieList[index].poster ?? "",
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
    );
  }
}

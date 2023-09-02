import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/viewmodels/favorite_viewmodel.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: const Text(
          "« لیست مورد علاقه »",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: darkBlue,
      body: controller.obx((status) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: controller.favoriteModel?.data?.list?.length ?? 0,
              itemBuilder: (_, index) => InkWell(
                    onTap: () => Get.to(() => MovieDetailScreen(
                        movieId:
                            controller.favoriteModel?.data?.list?[index].id ??
                                "")),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xff26313e))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: MediaQuery.sizeOf(context).width / 6,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(controller.favoriteModel
                                            ?.data?.list?[index].poster ??
                                        ""),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Expanded(
                              child: Text(
                            controller
                                    .favoriteModel?.data?.list?[index].title ??
                                "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: redColor,
                              ),
                              onPressed: () => controller.removeFavorite(
                                  controller.favoriteModel?.data?.list?[index]
                                          .id ??
                                      ""),
                            ),
                          )
                        ],
                      ),
                    ),
                  )))),
    );
  }
}

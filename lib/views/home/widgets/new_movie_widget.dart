import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:king_movie/models/movie_widget_model.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';

class NewMovieWidget extends StatelessWidget {
  const NewMovieWidget({
    super.key,
    required this.model,
  });

  final MovieWidgetModel? model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Get.to(() => MovieDetailScreen(movieId: model?.id ?? "")),
        child: SizedBox(
          width: Get.width / 2.8,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    model?.poster == null
                        ? const SizedBox()
                        : Image.network(
                            model?.poster ?? "",
                            fit: BoxFit.fill,
                            height: Get.height,
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: Get.height / 20,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Color.fromRGBO(0, 0, 0, 0.8),
                              Color.fromRGBO(0, 0, 0, 0.4),
                            ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter)),
                        child: Text(
                          model?.genre ?? "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  12 * MediaQuery.of(context).textScaleFactor),
                        ),
                      ),
                    )
                  ],
                ),
              )),
              Text(
                model?.title ?? "",
                maxLines: 1,
                style: const TextStyle(color: Color(0xffffffff), fontSize: 13),
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
      ),
    );
  }
}

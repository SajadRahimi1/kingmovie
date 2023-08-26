import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/viewmodels/request_movie_viewmodel.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class RequestMovieScreen extends StatelessWidget {
  const RequestMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestMovieViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: const Text(
          "« درخواست ها »",
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  "لینک IMDB فیلم مورد نظر را در کادر زیر وارد کنید:",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ProfileTextInput(
                label: "",
                onChanged: (value) => controller.id = value,
              ),
              InkWell(
                onTap: controller.requestMovie,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "ثبت درخواست",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              (controller.movieModel?.data?.list?.isEmpty ?? true)
                  ? const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text(
                        "هیچ درخواستی تا کنون ثبت نکردید",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8),
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height / 17,
                            decoration: const BoxDecoration(
                                color: Color(0xff26313e),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 1.7,
                                height: MediaQuery.sizeOf(context).height,
                                child: const Center(
                                  child: Text(
                                    "لینک",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: Color(0xff26313e),
                                thickness: 1,
                              ),
                              const Expanded(
                                  child: Text(
                                "وضعیت",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ))
                            ]),
                          ),
                          Column(
                            children: List.generate(
                              controller.movieModel?.data?.list?.length ?? 0,
                              (index) => Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).height / 17,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff26313e)),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.7,
                                    height: MediaQuery.sizeOf(context).height,
                                    child: Center(
                                      child: Text(
                                        controller.movieModel?.data
                                                ?.list?[index].title ??
                                            "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Color(0xff26313e),
                                    thickness: 3,
                                  ),
                                  Expanded(
                                      child: Text(
                                    controller.movieModel?.data?.list?[index]
                                            .active ??
                                        "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13 *
                                            MediaQuery.of(context)
                                                .textScaleFactor),
                                  ))
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
            ]),
          )),
    );
  }
}

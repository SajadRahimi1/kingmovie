import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/models/advance_search_model.dart';
import 'package:king_movie/models/home_model.dart';
import 'package:king_movie/views/home/screens/search_screen.dart';

// ignore: must_be_immutable
class AdvanceSearchDialog extends StatelessWidget {
  AdvanceSearchDialog({super.key, required this.model});
  final HomeModel? model;

  List<RxInt> selectBoxIndex = List.generate(10, (index) => (-1).obs);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width / 8,
          vertical: MediaQuery.sizeOf(context).height / 15),
      child: Material(
        color: blackColor,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 22,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: textEditingController,
                      decoration: InputDecoration(
                          focusColor: darkBlue,
                          filled: true,
                          hintStyle: const TextStyle(
                              color: Color(0xffafafaf), fontSize: 12),
                          fillColor: textFormColor,
                          hintText: "عنوان",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),

                  // way
                  SizedBox(
                      width: double.maxFinite,
                      child: Obx(
                        () => DropdownButton<int>(
                            value: selectBoxIndex[0].value == -1
                                ? null
                                : selectBoxIndex[0].value,
                            style: const TextStyle(color: Colors.white),
                            dropdownColor: darkBlue,
                            isExpanded: true,
                            hint: const Text(
                              "دسته بندی",
                              style: TextStyle(color: Colors.white),
                            ),
                            items: List.generate(
                                (model?.way?.length ?? 0) + 1,
                                (index) => DropdownMenuItem(
                                      value: index,
                                      child: Text(
                                        index == 0
                                            ? 'همه'
                                            : model?.way?[index - 1] ?? "",
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  30,
                                        ),
                                      ),
                                    )),
                            onChanged: (value) {
                              if (value != null) {
                                selectBoxIndex[0].value = value;
                              }
                            }),
                      )),

                  // scroe
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(
                      () => DropdownButton<int>(
                          value: selectBoxIndex[1].value == -1
                              ? null
                              : selectBoxIndex[1].value,
                          hint: const Text(
                            "امتیاز",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: darkBlue,
                          isExpanded: true,
                          items: List.generate(
                              (model?.score?.length ?? 0) + 1,
                              (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      index == 0
                                          ? 'همه'
                                          : model?.score?[index - 1] ?? "",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                30,
                                      ),
                                    ),
                                  )),
                          onChanged: (value) {
                            if (value != null) selectBoxIndex[1].value = value;
                          }),
                    ),
                  ),

                  // country
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[2].value == -1
                            ? null
                            : selectBoxIndex[2].value,
                        hint: const Text(
                          "کشور",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.country?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.country?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[2].value = value;
                        })),
                  ),

                  // language
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[3].value == -1
                            ? null
                            : selectBoxIndex[3].value,
                        hint: const Text(
                          "زبان",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.lang?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.lang?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[3].value = value;
                        })),
                  ),

                  // genre
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[4].value == -1
                            ? null
                            : selectBoxIndex[4].value,
                        hint: const Text(
                          "ٓژانر",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.genre?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.genre?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[4].value = value;
                        })),
                  ),

                  // age
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[5].value == -1
                            ? null
                            : selectBoxIndex[5].value,
                        hint: const Text(
                          "رده بندی سنی",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.age?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.age?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[5].value = value;
                        })),
                  ),

                  // sort
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[6].value == -1
                            ? null
                            : selectBoxIndex[6].value,
                        hint: const Text(
                          "ترتیب",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.sort?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.sort?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[6].value = value;
                        })),
                  ),

                  // dub
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[7].value == -1
                            ? null
                            : selectBoxIndex[7].value,
                        hint: const Text(
                          "دوبله",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.double?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.double?[index - 1] ?? "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[7].value = value;
                        })),
                  ),

                  // from
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                        value: selectBoxIndex[8].value == -1
                            ? null
                            : selectBoxIndex[8].value,
                        hint: const Text(
                          "از سال",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: darkBlue,
                        isExpanded: true,
                        items: List.generate(
                            (model?.years?.length ?? 0) + 1,
                            (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(
                                    index == 0
                                        ? 'همه'
                                        : model?.years?[index - 1].toString() ??
                                            "",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width / 30,
                                    ),
                                  ),
                                )),
                        onChanged: (value) {
                          if (value != null) selectBoxIndex[8].value = value;
                        })),
                  ),

                  // to
                  SizedBox(
                    width: double.maxFinite,
                    child: Obx(() => DropdownButton<int>(
                          value: selectBoxIndex[9].value == -1
                              ? null
                              : selectBoxIndex[9].value,
                          hint: const Text(
                            "تا سال",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: darkBlue,
                          isExpanded: true,
                          items: List.generate(
                              (model?.years?.length ?? 0) + 1,
                              (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(
                                      index == 0
                                          ? 'همه'
                                          : model?.years?[index - 1]
                                                  .toString() ??
                                              "",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                30,
                                      ),
                                    ),
                                  )),
                          onChanged: (value) {
                            if (value != null) selectBoxIndex[9].value = value;
                          },
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      AdvanceSearchModel searchModel = AdvanceSearchModel();
                      searchModel.title = textEditingController.text;
                      searchModel.way = selectBoxIndex[0].value < 0
                          ? 'همه'
                          : model?.way?[selectBoxIndex[0].value - 1];

                      searchModel.score = selectBoxIndex[1].value < 0
                          ? 'همه'
                          : model?.score?[selectBoxIndex[1].value - 1];

                      searchModel.country = selectBoxIndex[2].value < 0
                          ? 'همه'
                          : model?.country?[selectBoxIndex[2].value - 1];

                      searchModel.lang = selectBoxIndex[3].value < 0
                          ? 'همه'
                          : model?.lang?[selectBoxIndex[3].value - 1];

                      searchModel.genre = selectBoxIndex[4].value < 0
                          ? 'همه'
                          : model?.genre?[selectBoxIndex[4].value - 1];

                      searchModel.age = selectBoxIndex[5].value < 0
                          ? 'همه'
                          : model?.age?[selectBoxIndex[5].value - 1];

                      searchModel.sort = selectBoxIndex[6].value < 0
                          ? 'همه'
                          : model?.sort?[selectBoxIndex[6].value - 1];

                      searchModel.double = selectBoxIndex[7].value < 0
                          ? 'همه'
                          : model?.sort?[selectBoxIndex[7].value - 1];

                      searchModel.from = selectBoxIndex[8].value < 0
                          ? 'همه'
                          : model?.years?[selectBoxIndex[8].value - 1]
                              .toString();

                      searchModel.to = selectBoxIndex[9].value < 0
                          ? 'همه'
                          : model?.years?[selectBoxIndex[9].value - 1]
                              .toString();

                      Get.to(() => SearchScreen(
                            title: "",
                            advanceSearchModel: searchModel,
                          ));
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 22,
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: const Text(
                        "جست و جو",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}

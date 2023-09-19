import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/models/movie_model.dart';

class SeriesDialog extends StatelessWidget {
  const SeriesDialog(
      {super.key,
      required this.downloadList,
      required this.initVideo,
      required this.download});

  final DownloadList? downloadList;
  final void Function(DownloadList? url) initVideo, download;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 20,
            vertical: MediaQuery.sizeOf(context).height / 10),
        child: Material(
            color: darkBlue,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: downloadList?.list?.length ?? 0,
                    itemBuilder: (context, index) => SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height:
                              (downloadList?.list?[index].list?.length ?? 0) < 2
                                  ? MediaQuery.sizeOf(context).height / 5
                                  : MediaQuery.sizeOf(context).height /
                                      12 *
                                      (downloadList
                                              ?.list?[index].list?.length ??
                                          1),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.sizeOf(context).width / 4.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.white),
                              alignment: Alignment.center,
                              child: Text(
                                downloadList?.list?[index].title ?? "",
                                style: const TextStyle(color: blackColor),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: List.generate(
                                  downloadList?.list?[index].list?.length ?? 0,
                                  (secondIndex) => ListTile(
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                    titleTextStyle:
                                        const TextStyle(fontSize: 16),
                                    trailing: SizedBox(
                                      width:
                                          MediaQuery.sizeOf(context).width / 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          downloadList
                                                      ?.list?[index]
                                                      .list?[secondIndex]
                                                      .format ==
                                                  'movie'
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                    initVideo(downloadList
                                                        ?.list?[index]
                                                        .list?[secondIndex]);
                                                  },
                                                  child: Icon(
                                                    Icons.play_circle,
                                                    color: Colors.blue,
                                                    size: MediaQuery.sizeOf(
                                                                context)
                                                            .width /
                                                        14,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              download(downloadList
                                                  ?.list?[index]
                                                  .list?[secondIndex]);
                                            },
                                            child: const Icon(
                                              Icons.download,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    title: Text(downloadList?.list?[index]
                                            .list?[secondIndex].title ??
                                        ""),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )))));
  }
}

import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/core/widgets/menu.dart';

class ShowAllScreen extends StatelessWidget {
  const ShowAllScreen({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: screenAppBar(context: context, title: title ?? ""),
      backgroundColor: blackColor,
      drawer: const Menu(),
      body: ListView.builder(
          padding: const EdgeInsets.all(5),
          physics: const BouncingScrollPhysics(),
          itemCount: 4,
          itemBuilder: (_, index) => Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 4,
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
                              "Elemental | المنتال",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ),

                          const Spacer(),
                          // subtitle
                          const Text(
                            "زیرنویس : دارد",
                            style: TextStyle(color: Colors.white),
                          ),

                          // age
                          const Text(
                            "رده سنی : R",
                            style: TextStyle(color: Colors.white),
                          ),

                          // language
                          const Text(
                            "زبان : انگلیسی",
                            style: TextStyle(color: Colors.white),
                          ),

                          // description
                          const Text(
                            "دوبله فارسی انیمیشن المنتالدوبله اول | سورن",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
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
                          "https://www.doostihaa.com/img/uploads/2023/06/Elemental-2023.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}

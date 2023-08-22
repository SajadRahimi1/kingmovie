import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class RequestMovieScreen extends StatelessWidget {
  const RequestMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "لینک IMDB فیلم مورد نظر را در کادر زیر وارد کنید:",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ProfileTextInput(label: ""),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: redColor, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "ثبت درخواست",
              style: TextStyle(color: Colors.white),
            ),
          ),
         const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "هیچ درخواستی تا کنون ثبت نکردید",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, this.onReplyTap});
  final void Function()? onReplyTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8) + const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.all(12),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color: darkBlue, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // avatar
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                      radius: MediaQuery.sizeOf(context).width / 15),
                ),
                // texts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name
                    const Text(
                      "محمد کیان دست افکن",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // comment body
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.4,
                      child: const Text(
                        "ممنونم از کینگ مووی عزیز برای گذاشتن این اثر زیبا و از اون استادیو دوبلاژ ممنونم واقعا دستشون درد نکنه خصوصن جناب هومن حاج عبدالهی که دوبله نقش پسر رو بر عهده داشت واقعا کار زیبا فاخر که دو شدت بزرگ با کمک هم ساختن Pixar و wall Disney و امید وارم که این کار فاخر ادامه دار باشه حالا چه سریالی بشه چه نسخه دومش بیاد اینم بگم از اون انیمیشن که قشنگ خوب بلده حال دلتو خوب کنه ارز دیدن داره 100٪ بنظرم الان که دوبله شده نسخه باکیفیت منتشر شده ارزش دیدن داره هرکی نبینه اشتباه میکنه اینم اضافه کنم که بله صد درصد سورن هم اینو دوبله کنه عالی که نه مهشر میشه و اگه کیفیت این فیلم نسخه دوبله نظر رو 1080 بلوری سینک بشه عالیه من تخصص نیست ولی کلی این انیمیشن ارز دیدن دوبله تو blu ray داره دوستان :",
                        textAlign: TextAlign.justify,
                        style:
                            TextStyle(color: Color(0xffdfdfdf), fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // date and reply
                    Row(
                      children: [
                        // date
                        const Text(
                          "27 مرداد 1402, 00:36 ق.ظ\t\t",
                          style:
                              TextStyle(color: Color(0xffafafaf), fontSize: 11),
                        ),
                        // reply icon
                        InkWell(
                          onTap: onReplyTap,
                          child: const Icon(
                            Icons.reply,
                            color: redColor,
                          ),
                        ),
                        InkWell(
                          onTap: onReplyTap,
                          child: const Text(
                            "ثبت پاسخ",
                            style: TextStyle(color: redColor, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              const ReplyCommentWidget()
            ],
          ),
        ),

        // like or dislike
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.sizeOf(context).width / 28,
                      backgroundColor: const Color(0xff7a7a9e),
                      child: Center(
                          child: Text(
                        "+12",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor),
                      )),
                    ),
                    const Icon(
                      Icons.thumb_up,
                      color: yellowColor,
                    ),
                    const Icon(
                      Icons.thumb_down,
                      color: Color(0xffffffff),
                    ),
                    CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width / 28,
                        backgroundColor: const Color(0xff7a7a9e),
                        child: Center(
                            child: Text(
                          "-8",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  13 * MediaQuery.of(context).textScaleFactor),
                        )))
                  ]),
            ),
          ),
        )
      ],
    );
  }
}

class ReplyCommentWidget extends StatelessWidget {
  const ReplyCommentWidget({super.key, this.onReplyTap});
  final void Function()? onReplyTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8) +
              EdgeInsets.only(
                  top: 5, right: MediaQuery.sizeOf(context).width / 8),
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 42),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color: blackColor, borderRadius: BorderRadius.circular(10)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // avatar
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child:
                  CircleAvatar(radius: MediaQuery.sizeOf(context).width / 15),
            ),
            // texts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                const Text(
                  "محمد کیان دست افکن",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // comment body
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: const Text(
                    "ممنونم از کینگ مووی عزیز برای گذاشتن این اثر زیبا و از اون استادیو دوبلاژ ممنونم واقعا دستشون درد نکنه خصوصن جناب هومن حاج عبدالهی که دوبله نقش پسر رو بر عهده داشت واقعا کار زیبا فاخر که دو شدت بزرگ با کمک هم ساختن Pixar و wall Disney و امید وارم که این کار فاخر ادامه دار باشه حالا چه سریالی بشه چه نسخه دومش بیاد اینم بگم از اون انیمیشن که قشنگ خوب بلده حال دلتو خوب کنه ارز دیدن داره 100٪ بنظرم الان که دوبله شده نسخه باکیفیت منتشر شده ارزش دیدن داره هرکی نبینه اشتباه میکنه اینم اضافه کنم که بله صد درصد سورن هم اینو دوبله کنه عالی که نه مهشر میشه و اگه کیفیت این فیلم نسخه دوبله نظر رو 1080 بلوری سینک بشه عالیه من تخصص نیست ولی کلی این انیمیشن ارز دیدن دوبله تو blu ray داره دوستان :",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Color(0xffdfdfdf), fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // date and reply
                Row(
                  children: [
                    // date
                    const Text(
                      "27 مرداد 1402, 00:36 ق.ظ\t\t",
                      style: TextStyle(color: Color(0xffafafaf), fontSize: 11),
                    ),
                    // reply icon
                    InkWell(
                      onTap: onReplyTap,
                      child: const Icon(
                        Icons.reply,
                        color: redColor,
                      ),
                    ),
                    InkWell(
                      onTap: onReplyTap,
                      child: const Text(
                        "ثبت پاسخ",
                        style: TextStyle(color: redColor, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ),

        // like or dislike
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.sizeOf(context).width / 28,
                      backgroundColor: const Color(0xff7a7a9e),
                      child: Center(
                          child: Text(
                        "+12",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor),
                      )),
                    ),
                    const Icon(
                      Icons.thumb_up,
                      color: yellowColor,
                    ),
                    const Icon(
                      Icons.thumb_down,
                      color: Color(0xffffffff),
                    ),
                    CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width / 28,
                        backgroundColor: const Color(0xff7a7a9e),
                        child: Center(
                            child: Text(
                          "-8",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  13 * MediaQuery.of(context).textScaleFactor),
                        )))
                  ]),
            ),
          ),
        )
      ],
    );
  }
}

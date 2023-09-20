import 'package:flutter/material.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/models/movie_model.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {super.key,
      this.onReplyTap,
      required this.commentModel,
      required this.onLikeTap,
      required this.onDislikeTap});
  final void Function(String id)? onReplyTap;
  final Comment? commentModel;
  final void Function(String id) onLikeTap, onDislikeTap;

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
                    radius: MediaQuery.sizeOf(context).width / 15,
                    backgroundImage: NetworkImage(commentModel?.avatar ?? ""),
                  ),
                ),
                // texts
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name
                    Text(
                      commentModel?.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                    // comment body
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.4,
                      child: Text(
                        commentModel?.text ?? "",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: const Color(0xffdfdfdf),
                            fontSize:
                                11 * MediaQuery.of(context).textScaleFactor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // date and reply
                    Row(
                      children: [
                        // date
                        Text(
                          "${commentModel?.date}\t\t",
                          style: const TextStyle(
                              color: Color(0xffafafaf), fontSize: 11),
                        ),
                        // reply icon
                        InkWell(
                          onTap: () => onReplyTap!(commentModel?.id ?? ""),
                          child: const Icon(
                            Icons.reply,
                            color: redColor,
                          ),
                        ),
                        InkWell(
                          onTap: () => onReplyTap!(commentModel?.id ?? ""),
                          child: Text(
                            "ثبت پاسخ",
                            style: TextStyle(
                                color: redColor,
                                fontSize: 11 *
                                    MediaQuery.of(context).textScaleFactor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              (commentModel?.reply?.isEmpty ?? true)
                  ? const SizedBox()
                  : ReplyCommentWidget(
                      commentModel: commentModel?.reply?[0],
                      onDislikeTap: onDislikeTap,
                      onLikeTap: onLikeTap,
                      onReplyTap: onReplyTap,
                    )
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
                        "+${commentModel?.like}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor),
                      )),
                    ),
                    InkWell(
                        onTap: () => onLikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_up,
                          color: Color(0xffffffff),
                        )),
                    InkWell(
                        onTap: () => onDislikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Color(0xffffffff),
                        )),
                    CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width / 28,
                        backgroundColor: const Color(0xff7a7a9e),
                        child: Center(
                            child: Text(
                          "-${commentModel?.dislike}",
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
  const ReplyCommentWidget(
      {super.key,
      this.onReplyTap,
      required this.commentModel,
      required this.onLikeTap,
      required this.onDislikeTap});
  final void Function(String id)? onReplyTap;
  final Comment? commentModel;
  final void Function(String id) onLikeTap, onDislikeTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8) +
              EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height / 20,
                  right: MediaQuery.sizeOf(context).width / 10),
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 42),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color: blackColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // avatar
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    radius: MediaQuery.sizeOf(context).width / 15,
                    backgroundImage: NetworkImage(commentModel?.avatar ?? ""),
                  ),
                ),
                // texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        commentModel?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                12 * MediaQuery.of(context).textScaleFactor),
                      ),
                      // comment body
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.4,
                        child: Text(
                          commentModel?.text ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: const Color(0xffdfdfdf),
                              fontSize:
                                  11 * MediaQuery.of(context).textScaleFactor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // date and reply
                      Row(
                        children: [
                          // date
                          Text(
                            "${commentModel?.date}\t\t",
                            style: const TextStyle(
                                color: Color(0xffafafaf), fontSize: 11),
                          ),
                          // reply icon
                          InkWell(
                            onTap: () => onReplyTap!(commentModel?.id ?? ""),
                            child: const Icon(
                              Icons.reply,
                              color: redColor,
                            ),
                          ),
                          InkWell(
                            onTap: () => onReplyTap!(commentModel?.id ?? ""),
                            child: Text(
                              "ثبت پاسخ",
                              style: TextStyle(
                                  color: redColor,
                                  fontSize: 11 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              (commentModel?.reply?.isEmpty ?? true)
                  ? const SizedBox()
                  : SecondReplyWidget(
                      commentModel: commentModel?.reply?[0],
                      onDislikeTap: onDislikeTap,
                      onLikeTap: onLikeTap,
                      onReplyTap: onReplyTap,
                    )
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
                        "+${commentModel?.like}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor),
                      )),
                    ),
                    InkWell(
                        onTap: () => onLikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_up,
                          color: Color(0xffffffff),
                        )),
                    InkWell(
                        onTap: () => onDislikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Color(0xffffffff),
                        )),
                    CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width / 28,
                        backgroundColor: const Color(0xff7a7a9e),
                        child: Center(
                            child: Text(
                          "-${commentModel?.dislike}",
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

class SecondReplyWidget extends StatelessWidget {
  const SecondReplyWidget(
      {super.key,
      this.onReplyTap,
      required this.commentModel,
      required this.onLikeTap,
      required this.onDislikeTap});
  final void Function(String id)? onReplyTap;
  final Comment? commentModel;
  final void Function(String id) onLikeTap, onDislikeTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8) +
              EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height / 20,
              ),
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 42),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color: blackColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // avatar
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    radius: MediaQuery.sizeOf(context).width / 15,
                    backgroundImage: NetworkImage(commentModel?.avatar ?? ""),
                  ),
                ),
                // texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        commentModel?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                12 * MediaQuery.of(context).textScaleFactor),
                      ),
                      // comment body
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.4,
                        child: Text(
                          commentModel?.text ?? "",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: const Color(0xffdfdfdf),
                              fontSize:
                                  11 * MediaQuery.of(context).textScaleFactor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // date and reply
                      Row(
                        children: [
                          // date
                          Text(
                            "${commentModel?.date}\t\t",
                            style: const TextStyle(
                                color: Color(0xffafafaf), fontSize: 11),
                          ),
                          // reply icon
                          InkWell(
                            onTap: () => onReplyTap!(commentModel?.id ?? ""),
                            child: const Icon(
                              Icons.reply,
                              color: redColor,
                            ),
                          ),
                          InkWell(
                            onTap: () => onReplyTap!(commentModel?.id ?? ""),
                            child: Text(
                              "ثبت پاسخ",
                              style: TextStyle(
                                  color: redColor,
                                  fontSize: 11 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              (commentModel?.reply?.isEmpty ?? true)
                  ? const SizedBox()
                  : SecondReplyWidget(
                      commentModel: commentModel?.reply?[0],
                      onDislikeTap: onDislikeTap,
                      onLikeTap: onLikeTap,
                      onReplyTap: onReplyTap,
                    )
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
                        "+${commentModel?.like}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor),
                      )),
                    ),
                    InkWell(
                        onTap: () => onLikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_up,
                          color: Color(0xffffffff),
                        )),
                    InkWell(
                        onTap: () => onDislikeTap(commentModel?.id ?? ""),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Color(0xffffffff),
                        )),
                    CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width / 28,
                        backgroundColor: const Color(0xff7a7a9e),
                        child: Center(
                            child: Text(
                          "-${commentModel?.dislike}",
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

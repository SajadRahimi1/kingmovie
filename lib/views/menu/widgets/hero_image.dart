import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key, required this.tag, required this.src});
  final String tag, src;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: Colors.black,
      alignment: Alignment.center,
      child: Hero(
        tag: tag,
        child: Image.network(src),
      ),
    );
  }
}

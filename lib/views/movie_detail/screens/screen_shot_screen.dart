import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ScreenShotScreen extends StatelessWidget {
  const ScreenShotScreen({super.key, required this.src});
  final String? src;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.black,
        child: src == null
            ? null
            : PhotoView(
                loadingBuilder: (context, loadingProgress) => Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress?.expectedTotalBytes != null
                            ? (loadingProgress?.cumulativeBytesLoaded ?? 1) /
                                (loadingProgress?.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                imageProvider: NetworkImage(
                  src ?? '',
                )));
  }
}

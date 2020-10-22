import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  String url;
  String HEROID;
  ImageView({
    this.url,
    this.HEROID
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: HEROID,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent
            ),
            imageProvider: CachedNetworkImageProvider(url),
            maxScale: PhotoViewComputedScale.contained * 2.0,
            minScale: PhotoViewComputedScale.contained * 0.6,
          ),
        ),
      ),
    );
  }
}

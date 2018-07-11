import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:flutter_bloc_movies/Constants.dart';
import 'package:flutter_bloc_movies/utils/ImageHelper.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieImageForRow extends StatelessWidget {
  final IMAGE_TYPE imageType;
  final String size;
  final String imagePath;
  final bool isBlurred;

  MovieImageForRow({this.imagePath, this.imageType, this.size});

  @override
  Widget build(BuildContext context) {
		return Hero(child: getFadeInImage(), tag: imagePath);
  }

  Widget getFadeInImage() {
    return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: ImageHelper.getImagePath(imagePath, size),
        fit: BoxFit.fitWidth);
  }

    Widget getAdvancedNetworkImage() {
    return new TransitionToImage(
        AdvancedNetworkImage(ImageHelper.getImagePath(imagePath, size)),
        useReload: false,
        fallbackWidget: SizedBox(height: 300.0));
  }
}

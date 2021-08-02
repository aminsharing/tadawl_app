import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key key, this.imageName}) : super(key: key);
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
            image: imageName.isEmpty ? AssetImage('assets/images/avatar.png') : CachedNetworkImageProvider('https://tadawl.com.sa/API/assets/images/avatar/$imageName'),
            onError: (obj, stack) => AssetImage('assets/images/avatar.png'),
            fit: BoxFit.contain),
      ),
    );
  }
}

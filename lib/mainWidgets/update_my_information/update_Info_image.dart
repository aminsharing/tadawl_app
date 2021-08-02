import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

class UpdateInfoImage extends StatelessWidget {
  const UpdateInfoImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
          return TextButton(
            onPressed: () {
              userMutual.getImageUpdateProfile();
            },
            child: Container(
              width: mediaQuery.size.width * 0.9,
              height: mediaQuery.size.height * 0.3,
              child: Center(
                child: Container(
                  width: mediaQuery.size.width * 0.9,
                  height: mediaQuery.size.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: userMutual.imageUpdateProfile == null
                            ?
                        userMutual.users.isEmpty
                            ?
                        const AssetImage('assets/images/avatar.png')
                            :
                        (userMutual.users.first.image??'').isEmpty
                            ?
                        const AssetImage('assets/images/avatar.png')
                            :
                        CachedNetworkImageProvider('https://tadawl.com.sa/API/assets/images/avatar/${userMutual.users.first.image}')
                            :
                        FileImage(userMutual.imageUpdateProfile),
                        fit: BoxFit.contain,
                        onError: (uri, stack) => const AssetImage('assets/images/avatar.png')
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      );
  }
}

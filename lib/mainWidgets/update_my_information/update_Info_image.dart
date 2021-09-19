import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/provider/user_provider/my_account_provider.dart';

class UpdateInfoImage extends StatelessWidget {
  const UpdateInfoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Consumer<MyAccountProvider>(builder: (context, userMutual, child) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: TextButton(
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
                          userMutual.users == null
                              ?
                          const AssetImage('assets/images/avatar.png')
                              :
                          ((userMutual.users!.image??'').isEmpty
                              ?
                          const AssetImage('assets/images/avatar.png')
                              :
                          CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/avatar/${userMutual.users!.image}')) as ImageProvider<Object>
                              :
                          FileImage(userMutual.imageUpdateProfile!),
                          fit: BoxFit.contain,
                          onError: (uri, stack) => const AssetImage('assets/images/avatar.png')
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if((userMutual.users!.image??'').isNotEmpty)
            Positioned(
            bottom: 25.0,
            left: mediaQuery.size.width/2,
            right: mediaQuery.size.width/2,
            child: InkWell(
              onTap: () {
                userMutual.deleteImage = userMutual.users!.image;
                userMutual.users!.image = null;
                userMutual.update();
              },
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    // color: Colors.blueGrey,
                    borderRadius:
                    BorderRadius.circular(30)),
                child: Center(
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

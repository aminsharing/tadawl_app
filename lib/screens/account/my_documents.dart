import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/OfficeModel.dart';

class MyDocuments extends StatelessWidget {
  const MyDocuments({
    Key? key,
    required this.office,
  }) : super(key: key);
  final OfficeModel? office;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1f2835),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 70.0,
        title: Text(
            'مستنداتي',
          style: CustomTextStyle(

          ).getTextStyle(),
        ),
        centerTitle: true,
      ),
      body: office != null
          ?
      Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'وئائق المكتب',
                style: CustomTextStyle().getTextStyle(),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff04B404),
                    width: 1.0,
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('https://tadawl-store.com/API/assets/images/offices/${office!.sejel_image}'),
                    fit: BoxFit.contain
                  )
                ),
              ),
            ],
          ),
        ),
      )
          :
      Container(),
    );
  }
}

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/provider/ads_provider/update_img_vid_provider.dart';
import 'package:tadawl_app/provider/ads_provider/update_location_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/user_provider/favourite_provider.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/ads/menu.dart';
import 'package:tadawl_app/screens/ads/update_details.dart';
import 'package:tadawl_app/screens/ads/update_images_video.dart';
import 'package:tadawl_app/screens/ads/update_location.dart';
import 'package:video_player/video_player.dart';

class AdPageProvider extends ChangeNotifier{
  VideoPlayerController _videoControllerAdsPage;
  Future<void> _initializeFutureVideoPlyerAdsPage;
  ChewieController _chewieControllerAdsPage;

  bool _busyAdsPage = false;
  final bool _waitAdsPage = false;
  int _currentControllerPageAdsPage = 0;
  final PageController _controllerAdsPage = PageController();
  int _is_favAdsPage;
  final TextEditingController _priceControllerUpdate = TextEditingController();
  final TextEditingController _spaceControllerUpdate = TextEditingController();
  final TextEditingController _descControllerUpdate = TextEditingController();
  final TextEditingController _meterPriceControllerUpdate = TextEditingController();
  List _imageData = [];
  final List<AdsModel> _image = [];
  final List<AdsModel> _AdsUpdateLoc = [];
  List _AdsUpdateLocData = [];
  List _AdsDataUpdateDetails = [];
  final List<AdsModel> _adsUpdateDetails = [];
  final Set<Marker> _markersUpdateLoc = {};
  String _totalPricUpdatee;
  String _detailsAqarUpdate;
  int _meterPriceUpdate;
  String _totalSpaceUpdate;


  void choiceAction(BuildContext context, String choice, String idDescription) {
    if (choice == 'تعديل الصور والفيديو' ||
        choice == 'Update Images and Videos') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateImgVedProvider>(
            create: (_) => UpdateImgVedProvider(),
            child: UpdateImgVed(idDescription),
          )
      ));
      // Navigator.pushNamed(context, '/main/update_ads_img_ved', arguments: {
      //   'id_description': idDescription,
      // });
    } else if (choice == 'تعديل الموقع' || choice == 'Update Location') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<UpdateLocationProvider>(
            create: (_) => UpdateLocationProvider(),
            child: UpdateLocation(idDescription),
          )
          ));
      // Navigator.pushNamed(context, '/main/update_location', arguments: {
      //   'id_description': idDescription,
      // });
    } else if (choice == 'تعديل التفاصيل' || choice == 'Update Details') {
      if(_videoControllerAdsPage != null) {
        _videoControllerAdsPage.pause();
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          UpdateDetails(idDescription)));
      // Navigator.pushNamed(context, '/main/update_datails', arguments: {
      //   'id_description': idDescription,
      // });
    } else if (choice == 'حذف الإعلان' || choice == 'Delete Ad') {
      onDeletePressed(context, idDescription);
    }
  }

  void stopVideoAdsPage() {
    if(_videoControllerAdsPage != null) {
      //_videoAddAds = null;
      //_video = null;
      //_videoUpdate = null;
      //_videoControllerUpdate.pause();
      //_videoControllerAddAds.pause();
      _videoControllerAdsPage.pause();
    }
    //notifyListeners();
  }

  void currentControllerPageAdsPageFunc(int index) {
    _currentControllerPageAdsPage = index;
    notifyListeners();
  }

  void updateAdsAdsPage(BuildContext context, String id_ads) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _busyAdsPage = true;
      Api().updateAdsFunc(id_ads).then((value) {
        _busyAdsPage = false;
        notifyListeners();
      });
    });
  }

  void setVideoAdsPage(String video) {
    _videoControllerAdsPage = VideoPlayerController.network(
        'https://tadawl.com.sa/API/assets/videos/$video');
    _initializeFutureVideoPlyerAdsPage = _videoControllerAdsPage.initialize();
    _chewieControllerAdsPage = ChewieController(
      videoPlayerController: _videoControllerAdsPage,
      autoPlay: true,
      looping: true,
    );
    //notifyListeners();
  }

  void getImagesAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _image.clear();
      Api()
          .getImagesAdsPageFunc(id_description)
          .then((value) {
        _imageData = value;
        _imageData.forEach((element) {
          _image.add(AdsModel.adsImage(element));
        });
        notifyListeners();
      });
    });
  }

  void getAdsPageInfo(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _AdsUpdateLoc.clear();
      Api().getAdsPageFunc(id_description).then((value) {
        _AdsUpdateLocData = value;
        _AdsUpdateLocData.forEach((element) {
          _AdsUpdateLoc.add(AdsModel.adsUpdateLoc(element));
        });
        setMarker(context);
        notifyListeners();
      });
    });
    // notifyListeners();
  }

  void deleteVideoAdsPage() {
    _videoControllerAdsPage = null;
    notifyListeners();
  }

  void getAdsPageInfoUpdateDetails(BuildContext context, String id_description) async {
    Future.delayed(Duration(milliseconds: 0), () {
      _adsUpdateDetails.clear();
      Api().getAdsPageFunc(id_description).then((value) {
        _AdsDataUpdateDetails = value;
        _AdsDataUpdateDetails.forEach((element) {
          _adsUpdateDetails.add(AdsModel.adsUpdateDetails(element));
        });
        if (_adsUpdateDetails.isNotEmpty) {
          _priceControllerUpdate..text = _adsUpdateDetails.first.price;
          _spaceControllerUpdate..text = _adsUpdateDetails.first.space;
          _meterPriceControllerUpdate..text = (int.tryParse(_adsUpdateDetails.first.price) ~/ int.tryParse(_adsUpdateDetails.first.space)).toString();
          _meterPriceUpdate = int.parse(_meterPriceControllerUpdate.text);
          _descControllerUpdate..text = _adsUpdateDetails.first.description;
        }
        notifyListeners();
        // Provider.of<UpdateDetailsProvider>(context, listen: false).update();
      });
    });
  }

  void clearFav(){
    _is_favAdsPage = null;
  }

  Future<bool> onDeletePressed(BuildContext context, String idDescription) {
    if(_videoControllerAdsPage != null) {
      _videoControllerAdsPage.pause();
    }
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'أنت على وشك حذف الإعلان',
          style: CustomTextStyle(

            fontSize: 20,
            color: const Color(0xffff0000),
          ).getTextStyle(),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'هل أنت متأكد من حذف الإعلان؟',
          style: CustomTextStyle(

            fontSize: 15,
            color: const Color(0xff000000),
          ).getTextStyle(),
          textAlign: TextAlign.right,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              deleteAdsFunc(context, idDescription);
              // Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
              // Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
              // Provider.of<MainPageProvider>(context, listen: false)
              //     .getAdsList(
              //     context,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null,
              //     null);
              // Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
              Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Menu()),
              ModalRoute.withName('/Menu')
              );
            },
            child: Text(
              'نعم',
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(
              'لا',
              style: CustomTextStyle(

                fontSize: 15,
                color: const Color(0xff000000),
              ).getTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    ) ??
        false;
  }

  void changeAdsFavState(BuildContext context, int fav, String idDescription) async {
    if(Provider.of<UserMutualProvider>(context, listen: false).phone != null){
      Future.delayed(Duration(milliseconds: 0), () {
        Api().changeAdsFavStateFunc(idDescription, Provider.of<UserMutualProvider>(context, listen: false).phone).then((value) {
          _is_favAdsPage = fav;
          notifyListeners();
        });
        // Provider.of<FavouriteProvider>(context, listen: false).getUserAdsFavList(Provider.of<UserMutualProvider>(context, listen: false).phone);
        // notifyListeners();
      });
    }else{
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  // void getIsFav(BuildContext context, String idDescription) {
  //   _is_favAdsPageDB = int.tryParse(Provider.of<FavouriteProvider>(context, listen: false).getIsFav(idDescription)?? '0');
  //   // notifyListeners();
  // }

  void setMarker(BuildContext context) async {
    if (Provider.of<MainPageProvider>(context, listen: false).ads.isNotEmpty) {
      _markersUpdateLoc.add(Marker(
        markerId: MarkerId(_AdsUpdateLoc.first.lat),
        position: LatLng(double.parse(_AdsUpdateLoc.first.lat),
            double.parse(_AdsUpdateLoc.first.lng)),
      ));
    }
  }

  void setOnSavedTotalPriceUpdate(String value) {
    _totalPricUpdatee = value;
    _priceControllerUpdate..text = value;
    notifyListeners();
  }

  void setOnSavedDetailsUpdate(String value) {
    _detailsAqarUpdate = value;
    _descControllerUpdate..text = value;
    notifyListeners();
  }

  void setOnChangedSpaceUpdate(String value) {
    if (_meterPriceUpdate != null) {
      _priceControllerUpdate
        ..text = (double.parse(value) * double.parse('$_meterPriceUpdate'))
            .toString();
    }
    _totalSpaceUpdate = value;
    notifyListeners();
  }

  void setOnSavedSpaceUpdate(String value) {
    _totalSpaceUpdate = value;
    _spaceControllerUpdate..text = '$value';
    notifyListeners();
  }

  void setOnChangedMeterPriceUpdate(String value) {
    if (_totalSpaceUpdate != null) {
      _priceControllerUpdate
        ..text =
        (double.parse(value) * double.parse(_totalSpaceUpdate)).toString();
    }
    _meterPriceUpdate = int.parse(value);
    notifyListeners();
  }

  void setOnSavedMeterPriceUpdate(String value) {
    _meterPriceUpdate = int.parse(value);
    _meterPriceControllerUpdate..text = '$value';
    notifyListeners();
  }

  void deleteAdsFunc(BuildContext context, String idDescription) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().deleteAdsFunc(context, idDescription);
    });
  }

  void update() {
    notifyListeners();
  }



  VideoPlayerController get videoControllerAdsPage => _videoControllerAdsPage;
  ChewieController get chewieControllerAdsPage => _chewieControllerAdsPage;
  Future<void> get initializeFutureVideoPlyerAdsPage => _initializeFutureVideoPlyerAdsPage;
  bool get busyAdsPage => _busyAdsPage;
  bool get waitAdsPage => _waitAdsPage;
  int get currentControllerPageAdsPage => _currentControllerPageAdsPage;
  PageController get controllerAdsPage => _controllerAdsPage;
  int get is_favAdsPage => _is_favAdsPage;

  List<AdsModel> get AdsUpdateLoc => _AdsUpdateLoc;
  Set<Marker> get markersUpdateLoc => _markersUpdateLoc;
  TextEditingController get priceControllerUpdate => _priceControllerUpdate;
  TextEditingController get spaceControllerUpdate => _spaceControllerUpdate;
  TextEditingController get descControllerUpdate => _descControllerUpdate;
  List<AdsModel> get adsUpdateDetails => _adsUpdateDetails;
  List<AdsModel> get image => _image;
  String get totalPricUpdatee => _totalPricUpdatee;
  String get detailsAqarUpdate => _detailsAqarUpdate;
  int get meterPriceUpdate => _meterPriceUpdate;
  String get totalSpaceUpdate => _totalSpaceUpdate;
  TextEditingController get meterPriceControllerUpdate => _meterPriceControllerUpdate;





}
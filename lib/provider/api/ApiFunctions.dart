import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Api {
  final String _token = 'aSdFgHjKl12345678dfe34asAFS%^sfsdfcxjhASFCX90QwErT@';
  String BaseURL = 'https://www.tadawl-store.com/API/api_app';
  Future<dynamic> getadsFunc(LatLng area, String rad) async {
    final response = await http.post(
        '$BaseURL/coordinate/coordinate.php',
      // '$BaseURL/ads/all_ads.php',
      body: {
        'auth_key': _token,
        'lat': area.latitude.toString(),
        'lng': area.longitude.toString(),
        'rad': rad,
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getFilterTwoWeeksAgoFunc(LatLng area, String rad) async {
    final response = await http.post(
      '$BaseURL/ads/two_weeks_ago_ads.php',
      body: {
        'auth_key': _token,
        'lat': area.latitude.toString(),
        'lng': area.longitude.toString(),
        'rad': rad,
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> searchKeyFunc( String key) async {
    var url = '$BaseURL/ads/search_key.php';
    var response = await http.post(url, body: {
      'key': key,
      'auth_key': _token
    });
    if (response.body == 'false') {
      return 'false';
    } else {
      var jsonx = json.decode(response.body);
      return jsonx;
    }
  }

  Future<dynamic> getComments(
       String phone, String other_phone) async {
    var url = '$BaseURL/conversations/user_messages.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': phone,
      'other_phone': other_phone,

    });

    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> getEstimates(
    String user_phone,
  ) async {
    var url = '$BaseURL/userEstimate/select_estimates.php';
    var response = await http.post(url, body: {
      'phone': user_phone,
      'auth_key': _token
    });
    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> getSumEstimates(
    
    String user_phone,
  ) async {
    var url = '$BaseURL/userEstimate/sum_rates.php';
    var response = await http.post(url, body: {
      'phone': user_phone,
      'auth_key': _token
    });
    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> getCountEstimates(
    
    String user_phone,
  ) async {
    var url = '$BaseURL/userEstimate/count_estimates.php';
    var response = await http.post(url, body: {
      'phone': user_phone,
      'auth_key': _token
    });
    var jsonx = json.decode(response.body);
    return jsonx;
  }

  Future<dynamic> sendEstimateFunc(
    
    String phone,
    String user_phone,
    String rating,
    String comment,
  ) async {
    var url = '$BaseURL/userEstimate/user_estimate.php';
    var response = await http.post(url, body: {
      'phone_user': phone,
      'phone_user_estimated': user_phone,
      'rate': rating,
      'comment': comment,
      'auth_key': _token
    });
    var jsonx = json.decode(response.body);
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'شكراًَ على تقييمك',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
      return jsonx;
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الأدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
      return;
    }
  }

  Future<dynamic> filterPriceAdsFunc() async {
    final response = await http.post(
      '$BaseURL/ads/filter_price.php',
      body: {
        'auth_key': _token
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> filterSpaceAdsFunc() async {
    final response = await http.post(
      '$BaseURL/ads/filter_space.php',
      body: {
        'auth_key': _token
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> filterUpToDateAdsFunc(LatLng area, String rad) async {
    final response = await http.post(
      '$BaseURL/ads/filter_uptodate.php',
      body: {
        'auth_key': _token,
        'lat': area.latitude.toString(),
        'lng': area.longitude.toString(),
        'rad': rad,
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getNavigationFunc() async {
    final response = await http.post(
      '$BaseURL/ads/navigation.php',
      body: {
        'auth_key': _token
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getCategoryFunc() async {
    final response = await http.post(
      '$BaseURL/categoryAqar/getdata.php',
      body: {
        'auth_key': _token
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getFilterAdsFunc(String id_category, LatLng area, String rad) async {
    var url = '$BaseURL/ads/filter_category.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'id_category': id_category,
      'lat': area.latitude.toString(),
      'lng': area.longitude.toString(),
      'rad': rad,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getViewsChartFunc(
       String id_description) async {
    var url = '$BaseURL/ads/views_chart.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getSimilarAdsFunc(
       String id_category, String id_ads) async {
    var url = '$BaseURL/ads/similar_ads.php';
    var response = await http.post(url, body: {
      'id_category': id_category,
      'id_ads': id_ads,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> updateViewsFunc(
       String id_ads, String views) async {
    var url = '$BaseURL/ads/update_ads_views.php';
    var response = await http.post(url, body: {
      'id_ads': id_ads,
      'views': views,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> changeAdsFavStateFunc(
       String id_ads, String phone_user) async {
    var url = '$BaseURL/ads/fav_ads.php';
    var response = await http.post(url, body: {
      'id_ads': id_ads,
      'phone_user': phone_user,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return true;
      // return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserAdsFunc( String Phone) async {
    var url = '$BaseURL/ads/user_ads.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getFavAdsFunc( String Phone) async {
    var url = '$BaseURL/ads/fav_list_ads.php';
    try{
      var response = await http.post(url, body: {
        'phone': Phone,
        'auth_key': _token
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return false;
      }
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> getFavStatusFunc(String Phone, String idDescription) async {
    var url = '$BaseURL/ads/get_fav_status.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': Phone,
      'id_description': idDescription,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getAdsPageFunc(
       String id_description) async {
    var url = '$BaseURL/ads/ads_page.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getAqarVRFunc(
       String id_description) async {
    var url = '$BaseURL/ads/data_aqar_vr.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getImagesAdsPageFunc(
       String id_description) async {
    var url = '$BaseURL/ads/images_ads.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getBFAdsPageFunc( String id_description) async {
    var url = '$BaseURL/ads/ads_BF.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getQFAdsPageFunc(
       String id_description) async {
    var url = '$BaseURL/ads/ads_QF.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getDiscListFunc( String Phone) async {
    var url = '$BaseURL/conversations/conversations_list.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      var jsonX;
      try{
        if(response.body.isNotEmpty){
          jsonX = json.decode(response.body);
        }
      }catch(e){
        print('$e');
      }
      return jsonX;
    } else {
      return false;
    }
  }

  Future<dynamic> getUnreadMessagesFunc(
       String phone) async {
    var url = '$BaseURL/conversations/unread_messages.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': phone,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return '0';
    }
  }

  Future<dynamic> getUnreadMessagesByUserFunc(String phone, String otherPhone) async {
    var url = '$BaseURL/conversations/unreaded_messages_user.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': phone,
      'other_phone': otherPhone,
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return '0';
    }
  }

  Future<dynamic> setReadMessagesFunc(
       String phone, String other_phone) async {
    var url = '$BaseURL/conversations/set_read_messages.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': phone,
      'other_phone': other_phone,
    });
    if (response.statusCode == 200) {
      return '1';
    } else {
      return '0';
    }
  }

  Future<dynamic> getsOfficeFunc() async {
    final response = await http.post(
      '$BaseURL/officesAqar/getdata.php',
      body: {
        'auth_key': _token
      }
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserInfoFunc( String Phone) async {
    var url = '$BaseURL/login/account_info.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    return jsonDecode(response.body);
  }

  Future getUserAccountInfoFunc( String Phone) async {
    var url = '$BaseURL/ads/user_info.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    return jsonDecode(response.body);
  }

  Future getOfficeCheckFunc( String Phone) async {
    var url = '$BaseURL/officesAqar/check.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    return jsonDecode(response.body);
  }

  Future getAdsInfoFunc( String Phone) async {
    var url = '$BaseURL/ads/user_info.php';
    var response = await http.post(url, body: {
      'phone': Phone,
      'auth_key': _token
    });
    return jsonDecode(response.body);
  }

  Future<dynamic> deleteAdsFunc(
      BuildContext context,
       String id_description) async {
    var url = '$BaseURL/ads/delete_ads.php';
    var response = await http.post(url, body: {
      'id_description': id_description,
      'auth_key': _token
    });
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم حذف الإعلان بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الأدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<dynamic> updateLocationFunc(
    
    String id_description,
    String ads_city,
    String ads_neighborhood,
    String ads_road,
    String lat,
    String lng,
  ) async {
    var url = '$BaseURL/ads/update_location.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'id_description': id_description,
      'ads_city': ads_city,
      'ads_neighborhood': ads_neighborhood,
      'ads_road': ads_road,
      'lat': lat,
      'lng': lng,
    });
    if (response.statusCode == 200) {
      //return json.decode(response.body);
      await Fluttertoast.showToast(
          msg: 'تم تعديل موقع الإعلان بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الأدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<dynamic> updateImgVedFunc(
    
    String id_description,
    List<File> imagesList,
    File _video,
  ) async {
    final uri = Uri.parse('$BaseURL/ads/update_img_ved.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['id_description'] = id_description;
    request.fields['auth_key'] = _token;
    for (var i = 0; i < imagesList.length; i++) {
      await http.MultipartFile.fromPath('image[]', imagesList[i].path)
          .then((value) {
        request.files.add(value);
      });
    }
    if (_video != null) {
      var ved = await http.MultipartFile.fromPath('video', _video.path);
      request.files.add(ved);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم تعديل صور وفيديو الإعلان بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الأدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<dynamic> updateDetailsFunc(
    
    String id_description,
    String detailsAqar,
    String isFootballCourt,
    String isVolleyballCourt,
    String isAmusementPark,
    String isFamilyPartition,
    String isVerse,
    String isCellar,
    String isYard,
    String isMaidRoom,
    String isSwimmingPool,
    String isDriverRoom,
    String isDuplex,
    String isHallStaircase,
    String isConditioner,
    String isElevator,
    String isCarEntrance,
    String isAppendix,
    String isKitchen,
    String isFurnished,
    String StreetWidth,
    String Floor,
    String Trees,
    String Wells,
    String Stores,
    String Apartments,
    String AgeOfRealEstate,
    String Rooms,
    String Toilets,
    String Lounges,
    String selectedTypeAqar,
    String selectedFamily,
    String interfaceSelected,
    String totalSpace,
    String totalPrice,
    String selectedPlan,
    String id_category_final,
    String selectedAdderRelation,
    String selectedMarketerRelation,
  ) async {
    final uri = Uri.parse('$BaseURL/ads/update_datails.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['auth_key'] = _token;
    request.fields['id_description'] = id_description;
    request.fields['detailsAqar'] = detailsAqar.toString();
    request.fields['isFootballCourt'] = isFootballCourt.toString();
    request.fields['isVolleyballCourt'] = isVolleyballCourt.toString();
    request.fields['isAmusementPark'] = isAmusementPark.toString();
    request.fields['isFamilyPartition'] = isFamilyPartition.toString();
    request.fields['isVerse'] = isVerse.toString();
    request.fields['isCellar'] = isCellar.toString();
    request.fields['isYard'] = isYard.toString();
    request.fields['isMaidRoom'] = isMaidRoom.toString();
    request.fields['isSwimmingPool'] = isSwimmingPool.toString();
    request.fields['isDriverRoom'] = isDriverRoom.toString();
    request.fields['isDuplex'] = isDuplex.toString();
    request.fields['isHallStaircase'] = isHallStaircase.toString();
    request.fields['isConditioner'] = isConditioner.toString();
    request.fields['isElevator'] = isElevator.toString();
    request.fields['isCarEntrance'] = isCarEntrance.toString();
    request.fields['isAppendix'] = isAppendix.toString();
    request.fields['isKitchen'] = isKitchen.toString();
    request.fields['isFurnished'] = isFurnished.toString();
    request.fields['StreetWidth'] = StreetWidth.toString();
    request.fields['Floor'] = Floor.toString();
    request.fields['Trees'] = Trees.toString();
    request.fields['Wells'] = Wells.toString();
    request.fields['Stores'] = Stores.toString();
    request.fields['Apartments'] = Apartments.toString();
    request.fields['AgeOfRealEstate'] = AgeOfRealEstate.toString();
    request.fields['Rooms'] = Rooms.toString();
    request.fields['Toilets'] = Toilets.toString();
    request.fields['Lounges'] = Lounges.toString();
    request.fields['selectedTypeAqar'] = selectedTypeAqar.toString();
    request.fields['selectedFamily'] = selectedFamily.toString();
    request.fields['interfaceSelected'] = interfaceSelected.toString();
    request.fields['totalSpace'] = totalSpace.toString();
    request.fields['totalPrice'] = totalPrice.toString();
    request.fields['selectedPlan'] = selectedPlan.toString();
    request.fields['id_category'] = id_category_final.toString();
    request.fields['selectedAdderRelation'] = selectedAdderRelation.toString();
    request.fields['selectedMarketerRelation'] =
        selectedMarketerRelation.toString();
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم تعديل تفاصيل الإعلان بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الأدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<dynamic> getAdvancedSearchFunc(
      String category,
      String min_price,
      String max_price,
      String min_space,
      String max_space,
      String type_aqar,
      String interface,
      String plan,
      String age_of_real_estate,
      String apartements,
      String floor,
      String lounges,
      String rooms,
      String stores,
      String street_width,
      String toilets,
      String trees,
      String wells,
      String bool_feature1,
      String bool_feature2,
      String bool_feature3,
      String bool_feature4,
      String bool_feature5,
      String bool_feature6,
      String bool_feature7,
      String bool_feature8,
      String bool_feature9,
      String bool_feature10,
      String bool_feature11,
      String bool_feature12,
      String bool_feature13,
      String bool_feature14,
      String bool_feature15,
      String bool_feature16,
      String bool_feature17,
      String bool_feature18) async {
    // TODO add filter by area
    final uri = Uri.parse('$BaseURL/search/advanced_search.php');

    var response = await http.post(uri, body: {
      'auth_key': _token,
      'category': category,
      'min_price': min_price,
      'max_price': max_price,
      'min_space': min_space,
      'max_space': max_space,
      'type_aqar': type_aqar,
      'interface': interface,
      'plan': plan,
      'age_of_real_estate': age_of_real_estate,
      'apartements': apartements,
      'floor': floor,
      'lounges': lounges,
      'rooms': rooms,
      'stores': stores,
      'street_width': street_width,
      'toilets': toilets,
      'trees': trees,
      'wells': wells,
      'bool_feature1': bool_feature1,
      'bool_feature2': bool_feature2,
      'bool_feature3': bool_feature3,
      'bool_feature4': bool_feature4,
      'bool_feature5': bool_feature5,
      'bool_feature6': bool_feature6,
      'bool_feature7': bool_feature7,
      'bool_feature8': bool_feature8,
      'bool_feature9': bool_feature9,
      'bool_feature10': bool_feature10,
      'bool_feature11': bool_feature11,
      'bool_feature12': bool_feature12,
      'bool_feature13': bool_feature13,
      'bool_feature14': bool_feature14,
      'bool_feature15': bool_feature15,
      'bool_feature16': bool_feature16,
      'bool_feature17': bool_feature17,
      'bool_feature18': bool_feature18
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return;
    }
  }

  Future<dynamic> updateAdsFunc(String id_ads) async {
    var url = '$BaseURL/ads/update_ad.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'id_ads': id_ads,
    });
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> setLastSeenFunc(String phone) async {
    var url = '$BaseURL/login/set_last_seen.php';
    var response = await http.post(url, body: {
      'auth_key': _token,
      'phone': phone,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> addNewAdsFunc(
    
    String detailsAqar,
    String isFootballCourt,
    String isVolleyballCourt,
    String isAmusementPark,
    String isFamilyPartition,
    String isVerse,
    String isCellar,
    String isYard,
    String isMaidRoom,
    String isSwimmingPool,
    String isDriverRoom,
    String isDuplex,
    String isHallStaircase,
    String isConditioner,
    String isElevator,
    String isCarEntrance,
    String isAppendix,
    String isKitchen,
    String isFurnished,
    String StreetWidth,
    String Floor,
    String Trees,
    String Wells,
    String Stores,
    String Apartments,
    String AgeOfRealEstate,
    String Rooms,
    String Toilets,
    String Lounges,
    String selectedTypeAqar,
    String selectedFamily,
    String interfaceSelected,
    String totalSpace,
    String totalPrice,
    String selectedPlan,
    String id_category,
    String ads_cordinates_lat,
    String ads_cordinates_lng,
    String selectedAdderRelation,
    String selectedMarketerRelation,
    String phone,
    String ads_city,
    String ads_neighborhood,
    String ads_road,
    File video,
    List<File> imagesList,
  ) async {
    var uri = Uri.parse('$BaseURL/ads/add_new_ads.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['auth_key'] = _token;
    request.fields['detailsAqar'] = detailsAqar.toString();
    request.fields['isFootballCourt'] = isFootballCourt.toString();
    request.fields['isVolleyballCourt'] = isVolleyballCourt.toString();
    request.fields['isAmusementPark'] = isAmusementPark.toString();
    request.fields['isFamilyPartition'] = isFamilyPartition.toString();
    request.fields['isVerse'] = isVerse.toString();
    request.fields['isCellar'] = isCellar.toString();
    request.fields['isYard'] = isYard.toString();
    request.fields['isMaidRoom'] = isMaidRoom.toString();
    request.fields['isSwimmingPool'] = isSwimmingPool.toString();
    request.fields['isDriverRoom'] = isDriverRoom.toString();
    request.fields['isDuplex'] = isDuplex.toString();
    request.fields['isHallStaircase'] = isHallStaircase.toString();
    request.fields['isConditioner'] = isConditioner.toString();
    request.fields['isElevator'] = isElevator.toString();
    request.fields['isCarEntrance'] = isCarEntrance.toString();
    request.fields['isAppendix'] = isAppendix.toString();
    request.fields['isKitchen'] = isKitchen.toString();
    request.fields['isFurnished'] = isFurnished.toString();
    request.fields['StreetWidth'] = StreetWidth.toString();
    request.fields['Floor'] = Floor.toString();
    request.fields['Trees'] = Trees.toString();
    request.fields['Wells'] = Wells.toString();
    request.fields['Stores'] = Stores.toString();
    request.fields['Apartments'] = Apartments.toString();
    request.fields['AgeOfRealEstate'] = AgeOfRealEstate.toString();
    request.fields['Rooms'] = Rooms.toString();
    request.fields['Toilets'] = Toilets.toString();
    request.fields['Lounges'] = Lounges.toString();
    request.fields['selectedTypeAqar'] = selectedTypeAqar.toString();
    request.fields['selectedFamily'] = selectedFamily.toString();
    request.fields['interfaceSelected'] = interfaceSelected.toString();
    request.fields['totalSpace'] = totalSpace.toString();
    request.fields['totalPrice'] = totalPrice.toString();
    request.fields['selectedPlan'] = selectedPlan.toString();
    request.fields['id_category'] = id_category.toString();
    request.fields['ads_cordinates_lat'] = ads_cordinates_lat.toString();
    request.fields['ads_cordinates_lng'] = ads_cordinates_lng.toString();
    request.fields['selectedAdderRelation'] = selectedAdderRelation.toString();
    request.fields['selectedMarketerRelation'] =
        selectedMarketerRelation.toString();
    request.fields['_phone'] = phone.toString();
    request.fields['ads_city'] = ads_city.toString();
    request.fields['ads_neighborhood'] = ads_neighborhood.toString();
    request.fields['ads_road'] = ads_road.toString();

    if (video != null) {
      var ved = await http.MultipartFile.fromPath('video', video.path);
      request.files.add(ved);
    }

    for (var i = 0; i < imagesList.length; i++) {
      await http.MultipartFile.fromPath('image[]', imagesList[i].path)
          .then((value) {
        request.files.add(value);
      });
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم نشر الإعلان بنجاح.', toastLength: Toast.LENGTH_SHORT);
    } else {
      await Fluttertoast.showToast(
          msg: 'Error', toastLength: Toast.LENGTH_SHORT);
    }
  }

  // Future sendMessFunc( String content, String phone, String phone_user) async {
  //   var url = '$BaseURL/conversations/send_mes.php';
  //   await http.post(url, body: {
  //     'phone': phone,
  //     'other_phone': phone_user,
  //     'message': content,
  //   });
  // }

  Future sendMessFunc(List<File> imagesList, File voiceMsg, String content, String phone, String phone_user, String msgType, int voiceDuration) async {
    var uri = Uri.parse('$BaseURL/conversations/send_mes.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['auth_key'] = _token;
    request.fields['phone'] = phone;
    request.fields['other_phone'] = phone_user;
    request.fields['message'] = content ?? '';
    request.fields['msg_type'] = msgType;
    request.fields['voice_duration'] = (voiceDuration??0).toString();

    if (voiceMsg != null) {
      var voice = await http.MultipartFile.fromPath('voice', voiceMsg.path);
      request.files.add(voice);
    }

    if(imagesList.isNotEmpty){
      for (var i = 0; i < imagesList.length; i++) {
        await http.MultipartFile.fromPath('image[]', imagesList[i].path)
            .then((value) {
          request.files.add(value);
        });
      }
    }
    var response = await request.send();
    if (response.statusCode == 200) {

    } else {
      await Fluttertoast.showToast(msg: 'Error', toastLength: Toast.LENGTH_SHORT);
    }
  }


  Future sendOfficesVRInfo(
      
      String phone,
      String CRNumber,
      String officeName,
      String office_cordinates_lat,
      String office_cordinates_lng,
      File image
      ) async {
    final uri = Uri.parse('$BaseURL/login/officesVR.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['auth_key'] = _token;
    request.fields['phone'] = phone;
    request.fields['CRNumber'] = CRNumber;
    request.fields['officeName'] = officeName;
    request.fields['lat'] = office_cordinates_lat;
    request.fields['lng'] = office_cordinates_lng;
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'لقد تم إرسال طلب التوثيق بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الإدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future updateMyProfileFunc(
      
      int selectedMembership,
      String userName,
      String company_name,
      String office_name,
      String email,
      String personalProfile,
      String phone,
      File image
      ) async {
    final uri =
    Uri.parse('$BaseURL/login/uploadAvatar.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['auth_key'] = _token;
    request.fields['id_mem'] = (selectedMembership??-1).toString();
    request.fields['userName'] = userName ?? '';
    request.fields['company_name'] = company_name ?? '';
    request.fields['office_name'] = office_name ?? '';
    request.fields['email'] = email ?? '';
    request.fields['about'] = personalProfile ?? '';
    request.fields['phone'] = phone;
    if (image != null) {
      var pic = await http.MultipartFile.fromPath('image', image.path);
      request.files.add(pic);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'لقد تم تحديث معلومات المستخدم بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الإدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future sendInfoAqarVRFunc(
      
      String identity_number,
      String saq_number,
      String identity_type,
      String id_description,
      File image
      ) async {
    final uri = Uri.parse('$BaseURL/ads/aqar_vr.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['auth_key'] = _token;
    request.fields['identity_number'] = identity_number;
    request.fields['saq_number'] = saq_number;
    request.fields['identity_type'] = identity_type;
    request.fields['id_description'] = id_description;
    var pic2 = await http.MultipartFile.fromPath('img_saq', image.path);
    request.files.add(pic2);
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'لقد تم إرسال طلب التوثيق بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الإدارة',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<void> sendTransfer(
      
      String phone,
      String fullName,
      String reason,
      String refrencedNumber,
      String radioValue1,
      File imageInvoice
      ) async {
    final uri = Uri.parse('$BaseURL/bankTransfer/transfer_form.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['auth_key'] = _token;
    request.fields['phone'] = phone;
    request.fields['full_name'] = fullName;
    request.fields['reason'] = reason;
    request.fields['ref_number'] = refrencedNumber;
    request.fields['id_payment_type'] = radioValue1;
    var pic = await http.MultipartFile.fromPath('img_invoice', imageInvoice.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      await Fluttertoast.showToast(
          msg: 'تم إرسال نموذج التحويل بنجاح',
          toastLength: Toast.LENGTH_SHORT);
    } else {
      await Fluttertoast.showToast(
          msg: 'هناك خطاء راجع الإدارة',
          toastLength: Toast.LENGTH_SHORT);
    }
  }



}

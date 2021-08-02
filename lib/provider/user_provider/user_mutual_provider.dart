import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/mainWidgets/my_account/other/body/other_account.dart';
import 'package:tadawl_app/mainWidgets/my_account/owner/body/owen_account.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/OfficeModel.dart';
import 'package:tadawl_app/models/UserEstimateModel.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:tadawl_app/provider/ads_provider/main_page_provider.dart';
import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';


class UserMutualProvider extends ChangeNotifier{

  UserMutualProvider(){
    getSession().then((value) {
      print("UserMutualProvider _phone: $_phone");
    });

  }
  String _phone;
  int _called;
  final List<UserEstimateModel> _estimates = [];
  List _EstimateData = [];
  String _rating, _commentRating;
  final List<UserEstimateModel> _sumEstimates = [];
  List _SumEstimateData = [];
  final List<UserModel> _avatars = [];
  List _AvatarData = [];
  final List<AdsModel> _userAds = [];
  List _UserAdsData = [];
  final List<OfficeModel> _offices = [];
  List _OfficeData = [];
  String _userPhone;
  final List<UserModel> _users = [];
  List _UserData = [];
  String _userName, _companyName, _email, _personalProfile, _officeNameUser;
  final List<bool> _membershipType = List.generate(5, (_) => false);
  int _selectedMembership;
  bool _wait = false;

  File _imageUpdateProfile;
  final _picker2 = ImagePicker();

  Future<void> getImageUpdateProfile() async {
    final _pickedFile2 = await _picker2.getImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile2 != null) {
      _imageUpdateProfile = File(_pickedFile2.path);
      notifyListeners();
    }
  }

  File get imageUpdateProfile => _imageUpdateProfile;

  Future getSession() async {
    var p = await SharedPreferences.getInstance();
    _phone = p.getString('token');
    // notifyListeners(); // TODO this case problem because provider repeating this func too many times
  }

  Future logout() async {
    var p = await SharedPreferences.getInstance();
    await p.remove('token');
    await getSession();
    notifyListeners();
  }

  void callNumber(BuildContext context, String phoneEstimated) async {
    if (_estimates.isNotEmpty) {
      for (var i = 0; i < countEstimates(); i++) {
        if (_estimates[i].phone_user == _phone &&
            _estimates[i].phone_user_estimated == phoneEstimated) {
          _called = 1;
        }
      }
      if (called == 1) {
      } else {
        showRatingDialog(context, phoneEstimated);
      }
    } else {
      showRatingDialog(context, phoneEstimated);
    }
    if (phoneEstimated == _phone) {
      var number = '+$_phone';
      try{
        await FlutterPhoneDirectCaller.callNumber(number);
      }catch(e){
        await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
      }
    } else {
      var number = '+$phoneEstimated';
      try{
        await FlutterPhoneDirectCaller.callNumber(number);
      }catch(e){
        await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
      }
    }
  }

  void showRatingDialog(BuildContext context, String phoneEstimated) {
    final _dialog = RatingDialog(
      title: AppLocalizations.of(context).ratingDialog,
      commentHint: AppLocalizations.of(context).ratingCommentHint,
      message: AppLocalizations.of(context).ratingHint,
      image: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: const AssetImage('assets/images/avatar.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
      submitButton: AppLocalizations.of(context).send,
      onSubmitted: (response) {
        if(_phone != null){
          _rating = response.rating.toString();
          _commentRating = response.comment;
          Provider.of<MutualProvider>(context, listen: false).sendEstimate(
              context,
              _phone,
              phoneEstimated,
              _rating,
              _commentRating,
              Provider.of<MutualProvider>(context, listen: false).idDescription);
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
      },
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  void setCalled() {
    _called = 1;
    notifyListeners();
  }

  int countEstimates() {
    if (_estimates.isNotEmpty) {
      return _estimates.length;
    } else {
      return 0;
    }
  }

  void getUsersList( String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if(Phone != null) {
        Api().getUserInfoFunc(Phone).then((value) {
          _UserData = value;
          _users.clear();
          _UserData.forEach((element) {
            _users.add(UserModel.users(element));
          });
          // TODO ADDED
          // notifyListeners();
        });

        if (_users.isNotEmpty) {
          setUsernameController(_users.first.username);
          setEmailController(_users.first.email);
          setAboutController(_users.first.about);
          setCompanyNameController(_users.first.company_name);
          setOfficeNameController(_users.first.office_name);
          setUsername(_users.first.username);
          setCompanyName(_users.first.company_name);
          setOfficeNameUser(_users.first.office_name);
          setEmail(_users.first.email);
          setPersonalProfile(_users.first.about);

          // if (_users.first.id_mem != null) {
          //   initMembershipType(_users.first.id_mem);
          // }

        }

      }
    });
  }

  void getEstimatesInfo( String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_estimates.isEmpty) {
        Api().getEstimates(Phone).then((value) {
          _EstimateData = value;

          _EstimateData.forEach((element) {
            _estimates.add(UserEstimateModel.estimates(element));
          });
          // TODO ADDED
          // notifyListeners();
          // Provider.of<AdsProvider>(context,listen: false).update();
        });
      }
      else {
        Api().getEstimates(Phone).then((value) {
          _EstimateData = value;
          _estimates.clear();
          _EstimateData.forEach((element) {
            _estimates.add(UserEstimateModel.estimates(element));
          });
          // TODO ADDED
          // notifyListeners();

        });
      }
    });
    //notifyListeners();
  }

  void getSumEstimatesInfo( String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_sumEstimates.isEmpty) {
        Api().getSumEstimates(Phone).then((value) {
          _SumEstimateData = value;
          _SumEstimateData.forEach((element) {
            _sumEstimates.add(UserEstimateModel.sumEstimates(element));
          });
          // TODO ADDED
          notifyListeners();
          // Provider.of<AdsProvider>(context, listen: false).update();
        });
      }
      else {
        Api().getSumEstimates(Phone).then((value) {
          _SumEstimateData = value;
          _sumEstimates.clear();
          _SumEstimateData.forEach((element) {
            _sumEstimates.add(UserEstimateModel.sumEstimates(element));
          });
          // TODO ADDED
          notifyListeners();
          // Provider.of<AdsProvider>(context, listen: false).update();
        });
      }
    });
    //notifyListeners();
  }

  void getAvatarList( String PhoneOther) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_avatars.isEmpty) {
        Api().getUserInfoFunc(PhoneOther).then((value) {
          _AvatarData = value;
          _AvatarData.forEach((element) {
            _avatars.add(UserModel.users(element));
          });
        });
      } else {
        Api().getUserInfoFunc(PhoneOther).then((value) {
          _AvatarData = value;
          _avatars.clear();
          _AvatarData.forEach((element) {
            _avatars.add(UserModel.users(element));
          });
        });
      }
    });
  }

  void getUserAdsList( String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_userAds.isEmpty) {
        Api().getUserAdsFunc(Phone).then((value) {
          _UserAdsData = value;
          _UserAdsData.forEach((element) {
            _userAds.add(AdsModel.ads(element));
          });
          // TODO ADDED
          // notifyListeners();
        });
      } else {
        Api().getUserAdsFunc(Phone).then((value) {
          _UserAdsData = value;
          _userAds.clear();
          _UserAdsData.forEach((element) {
            _userAds.add(AdsModel.ads(element));
          });
          // TODO ADDED
          // notifyListeners();
        });
      }
    });
  }

  void checkOfficeInfo( String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_offices.isEmpty) {
        Api().getOfficeCheckFunc(Phone).then((value) {
          _OfficeData = value;
          _OfficeData.forEach((element) {
            _offices.add(OfficeModel.offices(element));
          });
          // TODO ADDED
          notifyListeners();
        });
      } else {
        Api().getOfficeCheckFunc(Phone).then((value) {
          _OfficeData = value;
          _offices.clear();
          _OfficeData.forEach((element) {
            _offices.add(OfficeModel.offices(element));
          });
          // TODO ADDED
          notifyListeners();
        });
      }
    });
  }

  void setUserPhone(String userPhone) {
    _userPhone = userPhone;
    // notifyListeners();
  }

  void setRating(String ratingg) {
    _rating = ratingg;
    notifyListeners();
  }

  void setCommentRating(String commentRatingg) {
    _commentRating = commentRatingg;
    notifyListeners();
  }

  int countAvatars() {
    if (_avatars.isNotEmpty) {
      return _avatars.length;
    } else {
      return 0;
    }
  }

  int countUserAds() {
    if (_userAds.isNotEmpty) {
      return _userAds.length;
    } else {
      return 0;
    }
  }

  int countUsers() {
    if (_users.isNotEmpty) {
      return _users.length;
    } else {
      return 0;
    }
  }

  void setUsernameController(String usernameController) {
    //_usernameController..text = usernameController;
    //notifyListeners();
  }

  void setUsernameControllerUpdate(String val) {
    //_usernameControllerUpdate..text = val;
    //notifyListeners();
  }

  void setEmailController(String emailController) {
    //_emailController..text = emailController;
    //notifyListeners();
  }

  void setAboutController(String aboutController) {
    //_aboutController..text = aboutController;
    //notifyListeners();
  }

  void setCompanyNameController(String companyNameController) {
    //_companyNameController..text = companyNameController;
    //notifyListeners();
  }

  void setOfficeNameController(String OfficeNameController) {
    //_OfficeNameController..text = OfficeNameController;
    //notifyListeners();
  }

  void setUsername(String userName) {
    _userName = userName;
    //notifyListeners();
  }

  void setCompanyName(String company_name) {
    _companyName = company_name;
    //notifyListeners();
  }

  void setOfficeNameUser(String office_name) {
    _officeNameUser = office_name;
    //notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    //notifyListeners();
  }

  void setPersonalProfile(String personalProfile) {
    _personalProfile = personalProfile;
    //notifyListeners();
  }

  void setInitMembershipType(){
    for (var buttonIndex2 = 0; buttonIndex2 < _membershipType.length; buttonIndex2++) {
      if(_users.first.id_mem != null){
        if(int.tryParse(_users.first.id_mem) - 1 == buttonIndex2){
          _membershipType[buttonIndex2] = true;
          _selectedMembership = buttonIndex2 + 1;
        }else{
          _membershipType[buttonIndex2] = false;
        }
      }
    }
  }

  void updateMembershipType(int index, bool update) {
    for (var buttonIndex2 = 0; buttonIndex2 < _membershipType.length; buttonIndex2++) {

      if (buttonIndex2 == index) {
        _membershipType[buttonIndex2] = true;
        _selectedMembership = buttonIndex2 + 1;
      } else {
        _membershipType[buttonIndex2] = false;
      }
    }
    if(update){
      notifyListeners();
    }
  }

  void clearUpdatingInformation(){
    _userName = null;
    _companyName = null;
    _email = null;
    _personalProfile = null;
    _officeNameUser = null;
    _selectedMembership = null;
    _imageUpdateProfile = null;
  }

  void setWaitState(bool wait) {
    _wait = wait;
  }

  void goToAvatar(BuildContext context, String phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      _wait = true;
      getAvatarList(phone);
      getUserAdsList(phone);
      getEstimatesInfo(phone);
      getSumEstimatesInfo(phone);
      checkOfficeInfo(phone);
      setUserPhone(phone);
    });
    Future.delayed(Duration(seconds: 0), () {
      _wait = false;
      if (_userPhone == _phone){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OwenAccount()),
        );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtherAccount()),
        );
      }
    });
    notifyListeners();
  }

  void update() => notifyListeners();

  Future updateMyProfile(
      BuildContext context,
      int selectedMembership,
      String userName,
      String company_name,
      String office_name,
      String email,
      String personalProfile,
      String phone,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateMyProfileFunc(
          selectedMembership,
          userName,
          company_name,
          office_name,
          email,
          personalProfile,
          phone,
          image);
    });
    getAvatarList(phone);
    getUserAdsList(phone);
    getEstimatesInfo(phone);
    getSumEstimatesInfo(phone);
    checkOfficeInfo(phone);
    setUserPhone(phone);

    clearUpdatingInformation();
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<MainPageProvider>(context, listen: false).removeMarkers();
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
      Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
      Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }


  String get phone => _phone;
  int get called => _called;
  String get rating => _rating;
  String get commentRating => _commentRating;
  List<UserEstimateModel> get estimates => _estimates;
  List<UserEstimateModel> get sumEstimates => _sumEstimates;
  List<UserModel> get avatars => _avatars;
  List<AdsModel> get userAds => _userAds;
  List<OfficeModel> get offices => _offices;
  String get userPhone => _userPhone;
  List<UserModel> get users => _users;
  String get userName => _userName;
  String get company_name => _companyName;
  String get email => _email;
  String get personalProfile => _personalProfile;
  String get officeNameUser => _officeNameUser;
  List<bool> get membershipType => _membershipType;
  int get selectedMembership => _selectedMembership;
  bool get wait => _wait;


}
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tadawl_app/models/AdsModel.dart';
import 'package:tadawl_app/models/OfficeModel.dart';
import 'package:tadawl_app/models/UserEstimateModel.dart';
import 'package:tadawl_app/models/UserModel.dart';
import 'package:tadawl_app/provider/ads_provider.dart';
import 'package:tadawl_app/provider/api/ApiFunctions.dart';
import 'package:tadawl_app/provider/bottom_nav_provider.dart';
import 'package:tadawl_app/provider/mutual_provider.dart';
import 'package:tadawl_app/provider/test/mutual_provider.dart';
import 'package:tadawl_app/screens/account/login.dart';
import 'package:tadawl_app/screens/account/my_account.dart';
import 'package:tadawl_app/screens/account/real_estate_offices.dart';
import 'package:tadawl_app/screens/ads/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<UserModel> _users = [];
  final List<UserModel> _avatars = [];
  final List<AdsModel> _userAds = [];
  final List<AdsModel> _userAdsFav = [];
  final List<UserEstimateModel> _estimates = [];
  final List<UserEstimateModel> _sumEstimates = [];
  final List<OfficeModel> _offices = [];



  final List<bool> _membershipType = List.generate(5, (_) => false);
  final List<bool> _isSelected = List.generate(2, (_) => false);
  final List<bool> _isSelected2 = List.generate(2, (_) => false);
  //TextEditingController _usernameController = TextEditingController();
  //TextEditingController _emailController = TextEditingController();
  //TextEditingController _aboutController = TextEditingController();
  //TextEditingController _companyNameController = TextEditingController();
  //TextEditingController _OfficeNameController = TextEditingController();

  //TextEditingController _usernameControllerUpdate = TextEditingController();

  StreamSubscription _streamChatSubscription;

  List _UserData = [];
  List _AvatarData = [];
  List _UserAdsData = [];
  List _UserAdsFavData = [];
  List _EstimateData = [];
  List _SumEstimateData = [];
  List _OfficeData = [];


  String _userName, _companyName, _email, _personalProfile, _officeNameUser;
  String _phone;
  String _userPhone;
  String _rating, _commentRating;
  String _verificationCode;
  String _newPass, _reNewPass;
  String _CRNumber, _officeName;
  String _fullName, _reason, _refrencedNumber;
  int _called;
  int _selectedNav = 0;
  int _current_stage;
  int _selectedMembership;
  int _buttonClicked;
  int _currentStageOfficeVR;
  int _radioValue1 = -1;
  int _selectedNav2;
  // final int _scrollState = 0;
  bool _wait = false;
  bool _passwordVisible = false;

  bool _Accepted = false;


  /// voice recorder
  // FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();

  File _imageOfficeVR;
  File _imageUpdateProfile;
  File _imageInvoice;
  final _picker = ImagePicker();
  final _picker2 = ImagePicker();
  final _picker3 = ImagePicker();



  String _currentPhone;
  String _newPhone;
  String _newAccountPhone;
  // TODO expended list count
  int _expendedListCount = 4;





  void setCurrentPhone(String val) {
    _currentPhone = filterPhone(val);
    notifyListeners();
  }

  void setNewAccountPhone(String val) {
    _newAccountPhone = filterPhone(val);
    notifyListeners();
  }

  void setNewPhone(String val) {
    _newPhone = filterPhone(val);
    notifyListeners();
  }

  String filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      Phone = Phone.toString().replaceFirst('0', '966');
      return Phone;
    } else if (Phone.toString().startsWith('5')) {
      Phone = Phone.toString().replaceFirst('5', '9665');
      return Phone;
    } else if (Phone.toString().startsWith('00')) {
      Phone = Phone.toString().replaceFirst('00', '');
      return Phone;
    } else if (Phone.toString().startsWith('+')) {
      Phone = Phone.toString().replaceFirst('+', '');
      return Phone;
    } else {
      return Phone;
    }
  }




  void initStateSelected() {
    _isSelected[0] = true;
  }

  void getUsersList(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if(Phone != null) {
        Api().getUserInfoFunc(context, Phone).then((value) {
          _UserData = value;
          _users.clear();
          _UserData.forEach((element) {
            _users.add(UserModel(
              image: element['image'],
              username: element['username'],
              timeRegistered: element['timeRegistered'],
              lastActive: element['lastActive'],
              about: element['about'],
              phone: element['phone'],
              company_name: element['company_name'],
              office_name: element['office_name'],
              email: element['email'],
              id_mem: element['id_mem'],
            ));
          });
          // TODO ADDED
          notifyListeners();
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

          if (_users.first.id_mem != null) {
            initMembershipType(_users.first.id_mem);
          }

        }

      }
    });
  }

  void getAvatarList(BuildContext context, String PhoneOther) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_avatars.isEmpty) {
        Api().getUserInfoFunc(context, PhoneOther).then((value) {
          _AvatarData = value;
          _AvatarData.forEach((element) {
            _avatars.add(UserModel(
              image: element['image'],
              username: element['username'],
              timeRegistered: element['timeRegistered'],
              lastActive: element['lastActive'],
              about: element['about'],
              phone: element['phone'],
              company_name: element['company_name'],
              office_name: element['office_name'],
              email: element['email'],
              id_mem: element['id_mem'],
            ));
          });
        });
      } else {
        Api().getUserInfoFunc(context, PhoneOther).then((value) {
          _AvatarData = value;
          _avatars.clear();
          _AvatarData.forEach((element) {
            _avatars.add(UserModel(
              image: element['image'],
              username: element['username'],
              timeRegistered: element['timeRegistered'],
              lastActive: element['lastActive'],
              about: element['about'],
              phone: element['phone'],
              company_name: element['company_name'],
              office_name: element['office_name'],
              email: element['email'],
              id_mem: element['id_mem'],
            ));
          });
        });
      }
    });
  }

  void getUserAdsList(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_userAds.isEmpty) {
        Api().getUserAdsFunc(context, Phone).then((value) {
          _UserAdsData = value;
          _UserAdsData.forEach((element) {
            _userAds.add(AdsModel(
              id_ads: element['id'],
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              timeUpdated: element['timeUpdated'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
          notifyListeners();
        });
      } else {
        Api().getUserAdsFunc(context, Phone).then((value) {
          _UserAdsData = value;
          _userAds.clear();
          _UserAdsData.forEach((element) {
            _userAds.add(AdsModel(
              id_ads: element['id'],
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              timeUpdated: element['timeUpdated'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
          notifyListeners();
        });
      }
    });
  }

  void update(){
    notifyListeners();
  }

  void getUserAdsFavList(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_userAdsFav.isEmpty) {
        Api().getFavAdsFunc(context, Phone).then((value) {
          _UserAdsFavData = value ?? [];
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel(
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              id_fav: element['id_fav'],
              isFav: element['isFav'],
              id_ads: element['id'],
              phone_faved_user: element['phone_faved_user'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
          // notifyListeners();
        });
      } else {
        Api().getFavAdsFunc(context, Phone).then((value) {
          _UserAdsFavData = value;
          _userAdsFav.clear();
          _UserAdsFavData.forEach((element) {
            _userAdsFav.add(AdsModel(
              idDescription: element['id_description'],
              idUser: element['id_user'],
              price: element['price'],
              lat: element['lat'],
              lng: element['lng'],
              ads_city: element['ads_city'],
              ads_neighborhood: element['ads_neighborhood'],
              ads_road: element['ads_road'],
              description: element['description'],
              ads_image: element['ads_image'],
              title: element['title'],
              space: element['space'],
              idSpecial: element['id_special'],
              video: element['video'],
              timeAdded: element['timeAdded'],
              id_fav: element['id_fav'],
              isFav: element['isFav'],
              id_ads: element['id'],
              phone_faved_user: element['phone_faved_user'],
              idCategory: element['id_category'],
            ));
          });
          // TODO ADDED
          // notifyListeners();
        });
      }
    });
  }

  String getIsFav(String idDescription){
    String isFav;
    _userAdsFav.forEach((element) {
      if(element.idDescription == idDescription){
        isFav = element.isFav;
      }
    });
    return isFav;
  }

  void getEstimatesInfo(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_estimates.isEmpty) {
        Api().getEstimates(context, Phone).then((value) {
          _EstimateData = value;
          _EstimateData.forEach((element) {
            _estimates.add(UserEstimateModel(
              id_UE: element['id_UE'],
              phone_user: element['phone_user'],
              phone_user_estimated: element['phone_user_estimated'],
              rate: element['rate'],
              comment: element['comment'],
            ));
          });
          // TODO ADDED
          // notifyListeners();
          // Provider.of<AdsProvider>(context,listen: false).update();
        });
      } else {
        Api().getEstimates(context, Phone).then((value) {
          _EstimateData = value;
          _estimates.clear();
          _EstimateData.forEach((element) {
            _estimates.add(UserEstimateModel(
              id_UE: element['id_UE'],
              phone_user: element['phone_user'],
              phone_user_estimated: element['phone_user_estimated'],
              rate: element['rate'],
              comment: element['comment'],
            ));
          });
          // TODO ADDED
          // notifyListeners();

        });
      }
    });
    //notifyListeners();
  }

  void getSumEstimatesInfo(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_sumEstimates.isEmpty) {
        Api().getSumEstimates(context, Phone).then((value) {
          _SumEstimateData = value;
          _SumEstimateData.forEach((element) {
            _sumEstimates.add(UserEstimateModel(
              sum_estimates: element['SUM(`rate`)'],
            ));
          });
          // TODO ADDED
          notifyListeners();
          Provider.of<AdsProvider>(context, listen: false).update();
        });
      } else {
        Api().getSumEstimates(context, Phone).then((value) {
          _SumEstimateData = value;
          _sumEstimates.clear();
          _SumEstimateData.forEach((element) {
            _sumEstimates.add(UserEstimateModel(
              sum_estimates: element['SUM(`rate`)'],
            ));
          });
          // TODO ADDED
          notifyListeners();
          Provider.of<AdsProvider>(context, listen: false).update();
        });
      }
    });
    //notifyListeners();
  }

  void checkOfficeInfo(BuildContext context, String Phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (_offices.isEmpty) {
        Api().getOfficeCheckFunc(context, Phone).then((value) {
          _OfficeData = value;
          _OfficeData.forEach((element) {
            _offices.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
          // TODO ADDED
          notifyListeners();
        });
      } else {
        Api().getOfficeCheckFunc(context, Phone).then((value) {
          _OfficeData = value;
          _offices.clear();
          _OfficeData.forEach((element) {
            _offices.add(OfficeModel(
              office_name: element['office_name'],
              phone_user: element['phone_user'],
              office_lat: element['office_lat'],
              office_lng: element['office_lng'],
              state: element['state'],
            ));
          });
          // TODO ADDED
          notifyListeners();
        });
      }
    });
  }



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

  void saveSession(String phone) async {
    var p = await SharedPreferences.getInstance();
    await p.setString('token', phone.toString());
    // ignore: deprecated_member_use
    await p.commit();
  }

  void setWaitState(bool wait) {
    _wait = wait;
  }

  void setPasswordVisibleState(bool state) {
    _passwordVisible = state;
    notifyListeners();
  }









  //void closeStreamChat() {
    //_streamChatSubscription.pause();
    //notifyListeners();
 // }



  // void scrollDown() {
  //   if (_scrollState == 1) {
  //     _scrollChatController
  //         .jumpTo(_scrollChatController.position.maxScrollExtent + 23);
  //     notifyListeners();
  //   }
  // }






  // void initScrollDown() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     _scrollChatController.animateTo(0,
  //         duration: Duration(seconds: 1), curve: Curves.easeIn);
  //   });
  //   _scrollChatController.addListener(() {
  //     if (_scrollChatController.position.atEdge) {
  //       if (_scrollChatController.position.pixels == 0) {
  //         _atBottom = false;
  //       } else {
  //         _atBottom = true;
  //       }
  //     } else {
  //       _atBottom = false;
  //     }
  //   });
  //
  //   //notifyListeners();
  // }



  void setUserPhone(String userPhone) {
    _userPhone = userPhone;
    // notifyListeners();
  }

  void setCalled() {
    _called = 1;
    notifyListeners();
  }

  void setRating(String ratingg) {
    _rating = ratingg;
    notifyListeners();
  }

  void setCommentRating(String commentRatingg) {
    _commentRating = commentRatingg;
    notifyListeners();
  }

  void setNewPass(String newPass) {
    _newPass = newPass;
    notifyListeners();
  }

  void setReNewPass(String reNewPass) {
    _reNewPass = reNewPass;
    notifyListeners();
  }

  void setVerCode(String verCode) {
    _verificationCode = verCode;
    notifyListeners();
  }

  void setCurrentStage(int currentStage) {
    _current_stage = currentStage;
    notifyListeners();
  }

  void updateSelected(int index) {
    for (var buttonIndex = 0; buttonIndex < countIsSelected(); buttonIndex++) {
      if (buttonIndex == index) {
        _isSelected[buttonIndex] = true;
        _selectedNav = buttonIndex;
      } else {
        _isSelected[buttonIndex] = false;
      }
    }
    notifyListeners();
  }



  void setButtonClicked(int state) {
    _buttonClicked = state;
    notifyListeners();
  }

  void setCurrentStageOfficeVR(int stage) {
    _currentStageOfficeVR = stage;
    notifyListeners();
  }

  Future<void> sendOfficesVRInfo(
      BuildContext context,
      String phone,
      String CRNumber,
      String officeName,
      String office_cordinates_lat,
      String office_cordinates_lng,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().sendOfficesVRInfo(context, phone, CRNumber, officeName,
          office_cordinates_lat, office_cordinates_lng, image);
    });

    getAvatarList(context, phone);
    getUserAdsList(context, phone);
    getEstimatesInfo(context, phone);
    getSumEstimatesInfo(context, phone);
    checkOfficeInfo(context, phone);
    setUserPhone(phone);

    Future.delayed(Duration(seconds: 0), () {
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(2);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RealEstateOffices()),
      );
    });
  }



  Future<void> getImageOfficesVR() async {
    final _pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (_pickedFile != null) {
      _imageOfficeVR = File(_pickedFile.path);
      notifyListeners();
    } else {}
  }

  void setCRNumber(String CRNumber) {
    _CRNumber = CRNumber;
    notifyListeners();
  }

  void setOfficeName(String officeName) {
    _officeName = officeName;
    notifyListeners();
  }

  Future updateMyProfile(
      BuildContext context,
      String selectedMembership,
      String userName,
      String company_name,
      String office_name,
      String email,
      String personalProfile,
      String phone,
      File image) async {
    Future.delayed(Duration(milliseconds: 0), () {
      Api().updateMyProfileFunc(
          context,
          selectedMembership,
          userName,
          company_name,
          office_name,
          email,
          personalProfile,
          phone,
          image);
    });

    getAvatarList(context, phone);
    getUserAdsList(context, phone);
    getEstimatesInfo(context, phone);
    getSumEstimatesInfo(context, phone);
    checkOfficeInfo(context, phone);
    setUserPhone(phone);

    clearUpdatingInformation();
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });

  }

  Future<void> getImageUpdateProfile() async {
    final _pickedFile2 = await _picker2.getImage(
      source: ImageSource.gallery,
      //maxHeight: 200,
      //maxWidth: 200,
      //imageQuality: 80,
    );
    if (_pickedFile2 != null) {
      _imageUpdateProfile = File(_pickedFile2.path);
    }
    //notifyListeners();
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

  void updateMembershipType(int index) {
    for (var buttonIndex2 = 0; buttonIndex2 < _membershipType.length; buttonIndex2++) {

      if (buttonIndex2 == index) {
        _membershipType[buttonIndex2] = true;
        _selectedMembership = buttonIndex2 + 1;
      } else {
        membershipType[buttonIndex2] = false;
      }
    }

    notifyListeners();
  }

  // TODO ADDED
  void clearUpdatingInformation(){
    _selectedMembership = null;
    _userName = null;
    _companyName = null;
    _email = null;
    _personalProfile = null;
    _officeNameUser = null;
    _imageUpdateProfile = null;
  }

  void initMembershipType(String idMem) {
   // _membershipType[int.parse(idMem) - 1] = true;
   // _selectedMembership = int.parse(idMem);

    //notifyListeners();
  }

  Future<void> sendTransfer(
      BuildContext context,
      String phone,
      String fullName,
      String reason,
      String refrencedNumber,
      String radioValue1,
      File imageInvoice) async {
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  Future<void> getImageInvoice() async {
    final _pickedFile3 = await _picker3.getImage(
      source: ImageSource.gallery,
    );
    if (_pickedFile3 != null) {
      _imageInvoice = File(_pickedFile3.path);
    } else {}
    notifyListeners();
  }

  void deleteImageInvoice() {
    _imageInvoice = null;
    notifyListeners();
  }

  void updateAccepted(bool Accepted) {
    _Accepted = Accepted;
    notifyListeners();
  }

  void setFullName(String fullName) {
    _fullName = fullName;
    notifyListeners();
  }

  void setReason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  void setRefrencedNumber(String refrencedNumber) {
    _refrencedNumber = refrencedNumber;
    notifyListeners();
  }

  void handleRadioValueChange1(int value) {
    _radioValue1 = value;
    notifyListeners();
  }

  void updateTransferChoice(int index) {
    for (var buttonIndex3 = 0;
        buttonIndex3 < _isSelected2.length;
        buttonIndex3++) {
      if (buttonIndex3 == index) {
        _isSelected2[buttonIndex3] = true;
        _selectedNav2 = buttonIndex3;
      } else {
        _isSelected2[buttonIndex3] = false;
      }
    }

    notifyListeners();
  }

  void goToAvatar(BuildContext context, String phone) {
    Future.delayed(Duration(milliseconds: 0), () {
      _wait = true;
      getAvatarList(context, phone);
      getUserAdsList(context, phone);
      getEstimatesInfo(context, phone);
      getSumEstimatesInfo(context, phone);
      checkOfficeInfo(context, phone);
      setUserPhone(phone);
    });
    Future.delayed(Duration(seconds: 0), () {
      _wait = false;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyAccount()),
      );
    });
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
          Provider.of<AdsProvider>(context, listen: false).sendEstimate(
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



  int countUsers() {
    if (_users.isNotEmpty) {
      return _users.length;
    } else {
      return 0;
    }
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

  int countUserAdsFav() {
    if (_userAdsFav.isNotEmpty) {
      return _userAdsFav.length;
    } else {
      return 0;
    }
  }

  int countEstimates() {
    if (_estimates.isNotEmpty) {
      return _estimates.length;
    } else {
      return 0;
    }
  }



  int countIsSelected() {
    if (_isSelected.isNotEmpty) {
      return _isSelected.length;
    } else {
      return 0;
    }
  }
// TODO ADDED
  void setExpendedListCount(int val){
    _expendedListCount = val;
    notifyListeners();
  }
// TODO ADDED
  void clearExpendedListCount(){
    _expendedListCount = 4;
  }

  List<UserModel> get users => _users;
  List<UserModel> get avatars => _avatars;
  List<AdsModel> get userAds => _userAds;
  List<AdsModel> get userAdsFav => _userAdsFav;
  List<UserEstimateModel> get estimates => _estimates;
  List<UserEstimateModel> get sumEstimates => _sumEstimates;
  List<OfficeModel> get offices => _offices;



  List<bool> get isSelected => _isSelected;
  List<bool> get membershipType => _membershipType;
  List<bool> get isSelected2 => _isSelected2;




  //TextEditingController get usernameController => _usernameController;
  //TextEditingController get emailController => _emailController;
  //TextEditingController get aboutController => _aboutController;
  //TextEditingController get companyNameController => _companyNameController;
  //TextEditingController get OfficeNameController => _OfficeNameController;
  //TextEditingController get usernameControllerUpdate => _usernameControllerUpdate;
  String get phone => _phone;
  String get userPhone => _userPhone;
  String get rating => _rating;
  String get commentRating => _commentRating;
  String get verificationCode => _verificationCode;
  String get newPass => _newPass;
  String get CRNumber => _CRNumber;
  String get officeName => _officeName;
  String get userName => _userName;
  String get company_name => _companyName;
  String get email => _email;
  String get personalProfile => _personalProfile;
  String get officeNameUser => _officeNameUser;
  String get reNewPass => _reNewPass;
  String get fullName => _fullName;
  String get reason => _reason;
  String get refrencedNumber => _refrencedNumber;


  bool get wait => _wait;
  bool get passwordVisible => _passwordVisible;
  bool get Accepted => _Accepted;
  int get called => _called;
  int get selectedNav => _selectedNav;
  int get current_stage => _current_stage;
  int get buttonClicked => _buttonClicked;
  int get currentStageOfficeVR => _currentStageOfficeVR;
  int get selectedMembership => _selectedMembership;
  int get radioValue1 => _radioValue1;
  int get selectedNav2 => _selectedNav2;
  File get imageOfficeVR => _imageOfficeVR;
  File get imageUpdateProfile => _imageUpdateProfile;
  File get imageInvoice => _imageInvoice;



  StreamSubscription get streamChatSubscription => _streamChatSubscription;
  String get currentPhone => _currentPhone;
  String get newPhone => _newPhone;
  String get newAccountPhone => _newAccountPhone;
  // TODO Added
  int get expendedListCount => _expendedListCount;
}

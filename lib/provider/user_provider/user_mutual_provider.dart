// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:rating_dialog/rating_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tadawl_app/mainWidgets/my_account/other/body/other_account.dart';
// import 'package:tadawl_app/mainWidgets/my_account/owner/body/owen_account.dart';
// import 'package:tadawl_app/models/AdsModel.dart';
// import 'package:tadawl_app/models/OfficeModel.dart';
// import 'package:tadawl_app/models/UserEstimateModel.dart';
// import 'package:tadawl_app/models/UserModel.dart';
// import 'package:tadawl_app/provider/ads_provider/mutual_provider.dart';
// import 'package:tadawl_app/provider/api/ApiFunctions.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:tadawl_app/provider/bottom_nav_provider.dart';
// import 'package:tadawl_app/provider/locale_provider.dart';
// import 'package:tadawl_app/screens/account/login.dart';
// import 'package:tadawl_app/screens/general/home.dart';
//
//
// class UserMutualProvider extends ChangeNotifier{
//
//   UserMutualProvider(){
//     // getUsersList(_phone);
//     // getUserAdsList(_phone);
//     // getAvatarList(_phone);
//     // getEstimatesInfo(_phone);
//     // getSumEstimatesInfo(_phone);
//     // checkOfficeInfo(_phone);
//     // setUserPhone(_phone);
//     print("UserMutualProvider init");
//     // getUsersList(_phone);
//   }
//   @override
//   void dispose() {
//     print("UserMutualProvider dispose");
//     super.dispose();
//   }
//
//   int _called;
//   final List<UserEstimateModel> _estimates = [];
//   List _EstimateData = [];
//   String _rating, _commentRating;
//   final List<AdsModel> _userAds = [];
//   List _UserAdsData = [];
//   String _userPhone;
//   OfficeModel _offices;
//   UserModel _users;
//   UserEstimateModel _sumEstimates;
//   UserModel _avatars;
//   String _userName, _companyName, _email, _personalProfile, _officeNameUser;
//   final List<bool> _membershipType = List.generate(5, (_) => false);
//   int _selectedMembership;
//   bool _wait = false;
//
//   File _imageUpdateProfile;
//   final _picker2 = ImagePicker();
//
//   Future<void> getImageUpdateProfile() async {
//     final _pickedFile2 = await _picker2.getImage(
//       source: ImageSource.gallery,
//     );
//     if (_pickedFile2 != null) {
//       _imageUpdateProfile = File(_pickedFile2.path);
//       notifyListeners();
//     }
//   }
//
//   File get imageUpdateProfile => _imageUpdateProfile;
//
//
//
//   Future logout(BuildContext context) async {
//     var p = await SharedPreferences.getInstance();
//     await p.remove('token');
//     await Provider.of<LocaleProvider>(context, listen: false).getSession();
//     notifyListeners();
//   }
//
//   void callNumber(BuildContext context, String phoneEstimated) async {
//     final locale = Provider.of<LocaleProvider>(context, listen: false);
//     if (_estimates.isNotEmpty) {
//       for (var i = 0; i < countEstimates(); i++) {
//         if (_estimates[i].phone_user == locale.phone &&
//             _estimates[i].phone_user_estimated == phoneEstimated) {
//           _called = 1;
//         }
//       }
//       if (called == 1) {
//       } else {
//         showRatingDialog(context, phoneEstimated);
//       }
//     } else {
//       showRatingDialog(context, phoneEstimated);
//     }
//     if (phoneEstimated == locale.phone) {
//       var number = '+${locale.phone}';
//       try{
//         await FlutterPhoneDirectCaller.callNumber(number);
//       }catch(e){
//         await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
//       }
//     } else {
//       var number = '+$phoneEstimated';
//       try{
//         await FlutterPhoneDirectCaller.callNumber(number);
//       }catch(e){
//         await Fluttertoast.showToast(msg: 'هنالك خطأ $e');
//       }
//     }
//   }
//
//   void showRatingDialog(BuildContext context, String phoneEstimated) {
//     final locale = Provider.of<LocaleProvider>(context, listen: false);
//     final _dialog = RatingDialog(
//       title: AppLocalizations.of(context).ratingDialog,
//       commentHint: AppLocalizations.of(context).ratingCommentHint,
//       message: AppLocalizations.of(context).ratingHint,
//       image: Container(
//         width: 100.0,
//         height: 100.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             image: const AssetImage('assets/images/avatar.png'),
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//       submitButton: AppLocalizations.of(context).send,
//       onSubmitted: (response) {
//         if(locale.phone != null){
//           _rating = response.rating.toString();
//           _commentRating = response.comment;
//           Provider.of<MutualProvider>(context, listen: false).sendEstimate(
//               context,
//               locale.phone,
//               phoneEstimated,
//               _rating,
//               _commentRating,
//               Provider.of<MutualProvider>(context, listen: false).idDescription);
//         }else{
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Login()),
//           );
//         }
//       },
//     );
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) => _dialog,
//     );
//   }
//
//   void setCalled() {
//     _called = 1;
//     notifyListeners();
//   }
//
//   int countEstimates() {
//     if (_estimates.isNotEmpty) {
//       return _estimates.length;
//     } else {
//       return 0;
//     }
//   }
//
//   Future<void> getUsersList( String Phone) async{
//     Future.delayed(Duration(milliseconds: 0), () async{
//       if(Phone != null) {
//         await Api().getUserInfoFunc(Phone).then((value) {
//           _users = UserModel.users(value);
//           if (_users != null) {
//             setUsername(_users.username);
//             setCompanyName(_users.company_name);
//             setOfficeNameUser(_users.office_name);
//             setEmail(_users.email);
//             setPersonalProfile(_users.about);
//             // notifyListeners();
//           }
//         });
//       }
//     });
//   }
//
//   Future<void> getEstimatesInfo( String Phone) async{
//     Future.delayed(Duration(milliseconds: 0), () async{
//       if (_estimates.isEmpty) {
//         await Api().getEstimates(Phone).then((value) {
//           _EstimateData = value;
//           _EstimateData.forEach((element) {
//             _estimates.add(UserEstimateModel.estimates(element));
//           });
//           // TODO ADDED
//           // notifyListeners();
//           // Provider.of<AdsProvider>(context,listen: false).update();
//         });
//       }
//       else {
//         await Api().getEstimates(Phone).then((value) {
//           _EstimateData = value;
//           _estimates.clear();
//           _EstimateData.forEach((element) {
//             _estimates.add(UserEstimateModel.estimates(element));
//           });
//           // TODO ADDED
//           // notifyListeners();
//
//         });
//       }
//     });
//     //notifyListeners();
//   }
//
//   Future<void> getSumEstimatesInfo( String Phone) async{
//     Future.delayed(Duration(milliseconds: 0), () async{
//       await Api().getSumEstimates(Phone).then((value) {
//         _sumEstimates = UserEstimateModel.sumEstimates(value);
//         // notifyListeners();
//       });
//     });
//     //notifyListeners();
//   }
//
//   Future<void> getAvatarList( String PhoneOther) async{
//     Future.delayed(Duration(milliseconds: 0), () async{
//       await Api().getUserInfoFunc(PhoneOther).then((value) {
//         _avatars = UserModel.users(value);
//         // notifyListeners();
//       });
//     });
//   }
//
//   Future<void> getUserAdsList( String Phone) async{
//     Future.delayed(Duration(milliseconds: 0), () async{
//       if (_userAds.isEmpty) {
//         await Api().getUserAdsFunc(Phone).then((value) {
//           _UserAdsData = value;
//           _UserAdsData.forEach((element) {
//             _userAds.add(AdsModel.ads(element));
//           });
//           // TODO ADDED
//           // notifyListeners();
//         });
//       } else {
//         await Api().getUserAdsFunc(Phone).then((value) {
//           _UserAdsData = value;
//           _userAds.clear();
//           _UserAdsData.forEach((element) {
//             _userAds.add(AdsModel.ads(element));
//           });
//           // TODO ADDED
//           // notifyListeners();
//         });
//       }
//     });
//   }
//
//   Future<void> checkOfficeInfo( String Phone) async {
//     Future.delayed(Duration(milliseconds: 0), () async{
//       await Api().getOfficeCheckFunc(Phone).then((value) {
//         print("getOfficeCheckFunc(P: ${value.runtimeType}");
//         if(value != null){
//           print("getOfficeCheckFunc(P 2: $value");
//           _offices = OfficeModel.offices(value);
//         }
//
//         // TODO ADDED
//         // notifyListeners();
//       });
//     });
//   }
//
//   void setUserPhone(String userPhone) {
//     _userPhone = userPhone;
//     // notifyListeners();
//   }
//
//   void setRating(String ratingg) {
//     _rating = ratingg;
//     notifyListeners();
//   }
//
//   void setCommentRating(String commentRatingg) {
//     _commentRating = commentRatingg;
//     notifyListeners();
//   }
//
//   int countUserAds() {
//     if (_userAds.isNotEmpty) {
//       return _userAds.length;
//     } else {
//       return 0;
//     }
//   }
//
//   void setUsername(String userName) {
//     _userName = userName;
//     //notifyListeners();
//   }
//
//   void setCompanyName(String company_name) {
//     _companyName = company_name;
//     //notifyListeners();
//   }
//
//   void setOfficeNameUser(String office_name) {
//     _officeNameUser = office_name;
//     //notifyListeners();
//   }
//
//   void setEmail(String email) {
//     _email = email;
//     //notifyListeners();
//   }
//
//   void setPersonalProfile(String personalProfile) {
//     _personalProfile = personalProfile;
//
//   }
//
//   void setInitMembershipType(){
//     for (var buttonIndex2 = 0; buttonIndex2 < _membershipType.length; buttonIndex2++) {
//       if(_users.id_mem != null){
//         if(int.tryParse(_users.id_mem) - 1 == buttonIndex2){
//           _membershipType[buttonIndex2] = true;
//           _selectedMembership = buttonIndex2 + 1;
//         }else{
//           _membershipType[buttonIndex2] = false;
//         }
//       }
//     }
//   }
//
//   void updateMembershipType(int index, bool update) {
//     for (var buttonIndex2 = 0; buttonIndex2 < _membershipType.length; buttonIndex2++) {
//
//       if (buttonIndex2 == index) {
//         _membershipType[buttonIndex2] = true;
//         _selectedMembership = buttonIndex2 + 1;
//       } else {
//         _membershipType[buttonIndex2] = false;
//       }
//     }
//     if(update){
//       notifyListeners();
//     }
//   }
//
//   void clearUpdatingInformation(){
//     _userName = null;
//     _companyName = null;
//     _email = null;
//     _personalProfile = null;
//     _officeNameUser = null;
//     _selectedMembership = null;
//     _imageUpdateProfile = null;
//   }
//
//   void setWaitState(bool wait) {
//     _wait = wait;
//   }
//
//   Future<void> goToAvatar(BuildContext context, String phone) async{
//     final locale = Provider.of<LocaleProvider>(context, listen: false);
//     Future.delayed(Duration(milliseconds: 0), () async{
//       _wait = true;
//       await getAvatarList(phone);
//       await getEstimatesInfo(phone);
//       await getSumEstimatesInfo(phone);
//       await checkOfficeInfo(phone);
//       await getUserAdsList(phone).then((value) {
//         _wait = false;
//         if (_userPhone == locale.phone){
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     OwenAccount()),
//           );
//         }else{
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     OtherAccount()),
//           );
//         }
//       });
//       await setUserPhone(phone);
//     });
//     Future.delayed(Duration(seconds: 0), () {
//
//     });
//     notifyListeners();
//   }
//
//   void update() => notifyListeners();
//
//   Future updateMyProfile(
//       BuildContext context,
//       int selectedMembership,
//       String userName,
//       String company_name,
//       String office_name,
//       String email,
//       String personalProfile,
//       String phone,
//       File image) async {
//     Future.delayed(Duration(milliseconds: 0), () {
//       Api().updateMyProfileFunc(
//           selectedMembership,
//           userName,
//           company_name,
//           office_name,
//           email,
//           personalProfile,
//           phone,
//           image);
//     });
//     await getAvatarList(phone);
//     await getUserAdsList(phone);
//     await getEstimatesInfo(phone);
//     await getSumEstimatesInfo(phone);
//     await checkOfficeInfo(phone);
//     setUserPhone(phone);
//
//     clearUpdatingInformation();
//     Future.delayed(Duration(seconds: 0), () {
//       // Provider.of<MainPageProvider>(context, listen: false).removeMarkers();
//       Provider.of<BottomNavProvider>(context, listen: false).setCurrentPage(0);
//       // Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
//       // Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => Home()),
//           ModalRoute.withName('/Home')
//       );
//     });
//   }
//
//
//   int get called => _called;
//   String get rating => _rating;
//   String get commentRating => _commentRating;
//   List<UserEstimateModel> get estimates => _estimates;
//   UserEstimateModel get sumEstimates => _sumEstimates;
//   UserModel get avatars => _avatars;
//   List<AdsModel> get userAds => _userAds;
//   OfficeModel get offices => _offices;
//   String get userPhone => _userPhone;
//   UserModel get users => _users;
//   String get userName => _userName;
//   String get company_name => _companyName;
//   String get email => _email;
//   String get personalProfile => _personalProfile;
//   String get officeNameUser => _officeNameUser;
//   List<bool> get membershipType => _membershipType;
//   int get selectedMembership => _selectedMembership;
//   bool get wait => _wait;
//
//
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadawl_app/mainWidgets/custom_text_style.dart';
import 'package:tadawl_app/provider/user_provider/user_mutual_provider.dart';

enum FieldType{
  username,
  email,
  about,
  companyName,
  officeTypeName
}

class UpdateInfoTextField extends StatelessWidget {
  const UpdateInfoTextField({
    Key key,
    @required this.labelText,
    @required this.fieldType,
    @required this.icon,
  }) : super(key: key);
  final String labelText;
  final FieldType fieldType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width * 0.8,
      child: Consumer<UserMutualProvider>(builder: (context, userMutual, child) {
        return TextFormField(
          decoration: InputDecoration(
            suffixIcon: Icon(
              icon,
              color: Color(0xff00cccc),
              size: 40,
            ),
            labelText: labelText,
          ),
          initialValue:
          fieldType == FieldType.username ? userMutual.users.first.username ?? ''
              :
          fieldType == FieldType.email ? userMutual.users.first.email ?? ''
              :
          fieldType == FieldType.about ? userMutual.users.first.about ?? ''
              :
          fieldType == FieldType.companyName ? userMutual.users.first.company_name ?? ''
              :
          fieldType == FieldType.officeTypeName ? userMutual.users.first.office_name ?? ''
              :
          '',
          style: CustomTextStyle(
            fontSize: 13,
            color: Color(0xff989696),
          ).getTextStyle(),
          keyboardType: fieldType == FieldType.email ? TextInputType.emailAddress : TextInputType.text,
          validator: (String value) {
            return null;
          },
          onSaved: (String value) {
            //userUpdate.setUsernameController(value);
            final userMutual = Provider.of<UserMutualProvider>(context, listen: false);
            if(fieldType == FieldType.username){
              userMutual.setUsername(value);
            }else if(fieldType == FieldType.email){
              userMutual.setEmail(value);
            }else if(fieldType == FieldType.about){
              userMutual.setPersonalProfile(value);
            }else if(fieldType == FieldType.companyName){
              userMutual.setCompanyName(value);
            }else if(fieldType == FieldType.officeTypeName){
              userMutual.setOfficeNameUser(value);
            }
          },
        );
      }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ke_employee/baseController/base_textfield.dart';
import 'package:ke_employee/dialogs/bottomsheet.dart';
import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:ke_employee/helper/string_res.dart';
import 'package:ke_employee/injection/dependency_injection.dart';
import 'package:ke_employee/manager/screens_manager.dart';
import 'package:ke_employee/manager/settings_manager.dart';
import 'package:ke_employee/manager/theme_manager.dart';
import 'package:ke_employee/models/parameter.dart';
import 'package:ke_employee/routes/custom_router.dart';
import 'package:ke_employee/routes/route_names.dart';

import 'drawer.dart';


class ProfileAndSettingsPagePortrait extends StatefulWidget {
  @override
  _ProfileAndSettingsPagePortraitState createState() => _ProfileAndSettingsPagePortraitState();
}

class _ProfileAndSettingsPagePortraitState extends State<ProfileAndSettingsPagePortrait> {

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  bool isSwitched = false;

  List<SettingsOptions> settingsOptionsList = [
    SettingsOptions.language,
    SettingsOptions.switchMode,
    SettingsOptions.sound,
    SettingsOptions.selectCompany,
    SettingsOptions.changePassword,
    SettingsOptions.privacyAndPolicy,
    SettingsOptions.termsAnsConditions,
    SettingsOptions.contactUs,
    SettingsOptions.logout
  ];

  String selectedLanguage;
  String selectedMode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = "Yu Hsin";
    usernameController.text = "yuhsin36";
    emailController.text = "yuhsin.36@gmail.com";
    this.selectedLanguage = LanguageBottomSheetOptions.english.title;
    this.selectedMode = SwitchModeBottomSheetOptions.modernVersion.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Utils().showAppBarWithDrawer(ScreensManager().bottomNavigationPortraitState.context, BottomItems.profileAndSettings),
        body: SingleChildScrollView(
          child: Column(
            children: [
              showUserDetails(),
              showSettingsOptions()
            ],
          ),
        )
    );
  }

  showUserDetails() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            showImageAndEditProfile(),
            SizedBox(height: 20),
            showUserField(),
            SizedBox(height: 5),
          ],
        )
    );
  }

  showImageAndEditProfile() {
    return Container(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
                      ),
                      child : Image.asset(Utils.getAssetsImg("book"), height: Utils.getDeviceHeight(context) * 0.165)
                  ),
                  Padding(padding: EdgeInsets.all(5),
                      child: Text("Marco", style: TextStyle(color: ThemeManager().getDarkColor(), fontSize: 18))
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: ThemeManager().getStaticGradientColor(),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
                ),
                child : Text(Utils.getText(context, StringRes.editProfile), style: TextStyle(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1())))
            )
          ],
        )
    );
  }

  showUserField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseTextField(
            hintText: Utils.getText(context, StringRes.name),
            controller: nameController,
            textInputType: TextInputType.text,
            focusNode: AlwaysDisabledFocusNode(),
            enableInteractiveSelection: false,
            fillColor: ThemeManager().getStaticGradientColor(),
            validator: (value){
              return null;
            }),
        SizedBox(height: Utils.getDeviceHeight(context) / 60),
        BaseTextField(
            hintText: Utils.getText(context, StringRes.usernameText),
            controller: usernameController,
            textInputType: TextInputType.text,
            focusNode: AlwaysDisabledFocusNode(),
            enableInteractiveSelection: false,
            fillColor: ThemeManager().getStaticGradientColor(),
            validator: (value){
              return null;
            }),
        SizedBox(height: Utils.getDeviceHeight(context) / 60),
        BaseTextField(
            hintText: Utils.getText(context, StringRes.emailId),
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            focusNode: AlwaysDisabledFocusNode(),
            enableInteractiveSelection: false,
            fillColor: ThemeManager().getStaticGradientColor(),
            validator: (value){
              return null;
            }),
        SizedBox(height: Utils.getDeviceHeight(context) / 60),
      ],
    );
  }

  showSettingsOptions() {
    return Container(
      color: ThemeManager().getBgGradientLight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(thickness: 0.5, height: 1, color: Colors.grey),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Text(
                  Utils.getText(context, StringRes.settings),
                  style: TextStyle(
                      color: ThemeManager().getDarkColor(),
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                  ))),
          showOptions()
        ],
      ),
    );
  }

  showOptions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemCount: this.settingsOptionsList.length,
          itemBuilder: (context, index){
            return showItem(index);
          }
      ),);
  }

  showItem(int index) {
    return InkResponse(
      onTap: () {
        if(this.settingsOptionsList[index] == SettingsOptions.language)
          BottomSheets.languageBottomSheet(this.settingsOptionsList[index].title, this.settingsOptionsList[index].color, (selectedLanguage) {
            setState(() {
              this.selectedLanguage = selectedLanguage;
            });
          });
        else if(this.settingsOptionsList[index] == SettingsOptions.switchMode)
          BottomSheets.switchModeBottomSheet(this.settingsOptionsList[index].title, this.settingsOptionsList[index].color, (selectedMode) {
            setState(() {
              this.selectedMode = selectedMode;
            });
          });
        else if(this.settingsOptionsList[index] == SettingsOptions.changePassword) {
          Utils.playClickSound();
          Navigator.of(context).push(CustomRouter.getRoute(name: changePasswordRoute, parameter: ChangePwdParam(context: this.context, isFromProfile: true, isOldPasswordRequired: true)));
        } else if(this.settingsOptionsList[index] == SettingsOptions.logout){
          Injector.logout();
          Navigator.of(ScreensManager().bottomNavigationPortraitState.context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
        }
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(this.settingsOptionsList[index].title, style: TextStyle(color: this.settingsOptionsList[index].color)),
            this.settingsOptionsList[index].selectionOption == true
                ? this.settingsOptionsList[index] == SettingsOptions.sound
                ? Container(
              alignment: Alignment.center,
              child: Switch(
                value: isSwitched,
                onChanged: (value){
                  setState(() {
                    isSwitched=value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity3()),
                activeColor: ThemeManager().getDarkColor(),
              ),
            ) : Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
                width: 100,
                decoration: BoxDecoration(
                    color: ThemeManager().getBgGradientLight(),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1()), width: 0.5)
                ),
                child : Text(this.settingsOptionsList[index] == SettingsOptions.language ? this.selectedLanguage
                    : this.settingsOptionsList[index] == SettingsOptions.switchMode ? this.selectedMode : "On",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ThemeManager().getDarkColor().withOpacity(ThemeManager().getOpacity1())))
            ) : Container()
          ],
        ),
      ),
    );
  }

}

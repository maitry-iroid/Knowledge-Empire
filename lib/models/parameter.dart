import 'package:flutter/cupertino.dart';

class ChangePwdParam {
  final BuildContext context;
  final bool isFromProfile;
  final bool isOldPasswordRequired;

  ChangePwdParam({this.context, this.isFromProfile, this.isOldPasswordRequired});
}
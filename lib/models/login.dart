import 'package:knowledge_empire/helper/constant.dart';
import 'package:knowledge_empire/manager/encryption_manager.dart';

class LoginRequest {
  String email;
  String password;
  String secret;
  String language;
  String companyCode;

  LoginRequest({this.email, this.password, this.secret, this.language});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    secret = json['secret'];
    language = json['language'];
    companyCode = json['companyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['secret'] = this.secret;
    data['language'] = this.language;
    data['companyCode'] = this.companyCode;
    return data;
  }
}

class BaseResponse<T> {
  String flag;
  String result;
  String msg;
  T data;

  BaseResponse({this.flag, this.result, this.msg, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}

class UserData {
  int userId;
  String name;
  String nickName;
  String email;
  String phone;
  String address;
  String country;
  String createdAt;
  int isPasswordChanged;
  String profileImage;
  String accessToken;
  String companyName;
  String manager;
  int activeCompany;
  int isSeenPrivacyPolicy;
  int isManager;
  int salesPersonCount = 0;
  bool isFirstTimeLogin = false;
  bool isSoundEnable = false;
  String language = Const.english;
  int mode;
  int isAnonymousName = 0;

  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nickName = json['nickName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    country = json['country'];
    createdAt = json['createdAt'];
    isPasswordChanged = json['isPasswordChanged'];
    profileImage = json['profileImage'];
    accessToken = json['accessToken'];
    companyName = json['companyName'];
    isManager = json['isManager'];
    manager = json['manager'];
    activeCompany = json['activeCompany'];
    isSeenPrivacyPolicy = json['isSeenPrivacyPolicy'];
    isFirstTimeLogin = json['isFirstTimeLogin'];
    language = json['language'];
    mode = json['mode'];
    isAnonymousName = json['isAnonymousName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['isPasswordChanged'] = this.isPasswordChanged;
    data['profileImage'] = this.profileImage;
    data['accessToken'] = this.accessToken;
    data['isManager'] = this.isManager;
    data['companyName'] = this.companyName;
    data['manager'] = this.manager;
    data['activeCompany'] = this.activeCompany;
    data['isSeenPrivacyPolicy'] = this.isSeenPrivacyPolicy;
    data['isFirstTimeLogin'] = this.isFirstTimeLogin;
    data['language'] = this.language;
    data['mode'] = this.mode;
    data['isAnonymousName'] = this.isAnonymousName;
    return data;
  }

  encryptRequiredData() async {
    this.name = await EncryptionManager().stringEncryption(this.name);
    this.nickName = await EncryptionManager().stringEncryption(this.nickName);
    this.email = await EncryptionManager().stringEncryption(this.email);
  }

  decryptRequiredData() async {
    await this.decryptName();
    await this.decryptNickName();
    this.email = await EncryptionManager().stringDecryption(this.email);
  }

  decryptName() async {
    List<String> fullName = this.name.toString().split(" ");
    this.name = "";
    if (fullName.length > 0) {
      if (fullName.length > 1) {
        String decryptedFName = await EncryptionManager().stringDecryption(fullName.first);
        String decryptedLName = await EncryptionManager().stringDecryption(fullName.last);
        this.name = decryptedFName + " " + decryptedLName;
      } else {
        String decryptedFName = await EncryptionManager().stringDecryption(fullName.first);
        this.name = decryptedFName;
      }
    }
  }

  decryptNickName() async {
    this.nickName = await EncryptionManager().stringDecryption(this.nickName);
  }
}

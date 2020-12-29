import 'package:ke_employee/manager/encryption_manager.dart';

class GetFriendsRequest {
  int userId;
  int category;
  int searchBy;
  int filter;
  int groupId;
  int scrollType;
  int lastUserId;

  GetFriendsRequest({this.userId, this.category, this.searchBy, this.filter});

  GetFriendsRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    category = json['category'];
    searchBy = json['searchBy'];
    filter = json['filter'];
    groupId = json['groupId'];
    scrollType = json['scrollType'];
    lastUserId = json['lastUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['category'] = this.category;
    data['searchBy'] = this.searchBy;
    data['filter'] = this.filter;
    data['groupId'] = this.groupId;
    data['scrollType'] = this.scrollType;
    data['lastUserId'] = this.lastUserId;
    return data;
  }
}


class GetFriendsData {
  int userId;
  String name;
  String companyName;
  int score;
  int isFriend;
  String rate;
  String profileImage;

//  bool isFriends = false;

  GetFriendsData({this.userId, this.name, this.score, this.isFriend, this.profileImage});

  GetFriendsData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    companyName = json['companyName'];
    score = json['score'];
    isFriend = json['isFriend'];
    rate = json['rate'];
    profileImage = json['profileImage'];
//    isFriends = json['isFriends'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['companyName'] = this.companyName;
    data['score'] = this.score;
    data['isFriend'] = this.isFriend;
    data['rate'] = this.rate;
    data['profileImage'] = this.profileImage;
//    data['isFriends'] = this.isFriends;
    return data;
  }
}


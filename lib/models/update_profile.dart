class UpdateProfileRequest {
  String userId;
  String profileImage;
  String name;
  String nickName;

  UpdateProfileRequest({this.userId, this.profileImage, this.name, this.nickName});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileImage = json['profileImage'];
    name = json['name'];
    nickName = json['nickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profileImage'] = this.profileImage;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    return data;
  }
}

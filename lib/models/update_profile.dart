class UpdateProfileRequest {
  String userId;
  String profileImage;
  String name;

  UpdateProfileRequest({this.userId, this.profileImage, this.name});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileImage = json['profileImage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profileImage'] = this.profileImage;
    data['name'] = this.name;
    return data;
  }
}

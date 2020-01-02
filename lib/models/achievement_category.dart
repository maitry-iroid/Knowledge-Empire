class AchievementCategoryRequest {
  int userId;

  AchievementCategoryRequest({this.userId});

  AchievementCategoryRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    return data;
  }
}

class AchievementCategoryResponse {
  String flag;
  String result;
  String msg;
  List<AchievementCategoryData> data;

  AchievementCategoryResponse({this.flag, this.result, this.msg, this.data});

  AchievementCategoryResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<AchievementCategoryData>();
      json['data'].forEach((v) {
        data.add(new AchievementCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AchievementCategoryData {
  String name;
  int categoryId;

  AchievementCategoryData({this.name, this.categoryId});

  AchievementCategoryData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    return data;
  }
}


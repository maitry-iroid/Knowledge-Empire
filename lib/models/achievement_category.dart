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


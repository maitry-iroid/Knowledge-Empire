class GetAchievementRequest {
  int userId;
  String categoryId;

  GetAchievementRequest({this.userId, this.categoryId});

  GetAchievementRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    return data;
  }
}


class GetAchievementData {
  String achievementCategory;
  List<SubCategory> subCategory;

  GetAchievementData({this.achievementCategory, this.subCategory});

  GetAchievementData.fromJson(Map<String, dynamic> json) {
    achievementCategory = json['achievementCategory'];
    if (json['subCategory'] != null) {
      subCategory = new List<SubCategory>();
      json['subCategory'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achievementCategory'] = this.achievementCategory;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  String achievementName;
  int currentLevel;
  int currentLevelBlonus;
  String currentLevelText;
  int nextLevelBlonus;
  String nextLevelText;

  SubCategory(
      {this.achievementName,
      this.currentLevel,
      this.currentLevelBlonus,
      this.currentLevelText,
      this.nextLevelBlonus,
      this.nextLevelText});

  SubCategory.fromJson(Map<String, dynamic> json) {
    achievementName = json['achievementName'];
    currentLevel = json['currentLevel'];
    currentLevelBlonus = json['currentLevelBlonus'];
    currentLevelText = json['currentLevelText'];
    nextLevelBlonus = json['nextLevelBlonus'];
    nextLevelText = json['nextLevelText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['achievementName'] = this.achievementName;
    data['currentLevel'] = this.currentLevel;
    data['currentLevelBlonus'] = this.currentLevelBlonus;
    data['currentLevelText'] = this.currentLevelText;
    data['nextLevelBlonus'] = this.nextLevelBlonus;
    data['nextLevelText'] = this.nextLevelText;
    return data;
  }
}

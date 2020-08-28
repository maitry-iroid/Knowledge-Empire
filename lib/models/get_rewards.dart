
class GetRewardRequest {
  int userId;
  int categoryId;
  String searchText;
  int offset;

  GetRewardRequest({this.userId, this.categoryId, this.searchText, this.offset});

  GetRewardRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    categoryId = json['categoryId'];
    searchText = json['searchText'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['searchText'] = this.searchText;
    data['offset'] = this.offset;
    return data;
  }
}


class RewardResponse {
  String flag="";
  String result="";
  String msg="";
  List<RewardData> data;

  RewardResponse({this.flag, this.result, this.msg, this.data});

  RewardResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<RewardData>();
      json['data'].forEach((v) {
        data.add(new RewardData.fromJson(v));
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

class RewardData {
  int rewardId;
  String reward="";
  String description="";
  String media;
  String mediaThumb;
  String keywords;
  int points;
  int leftUnits;
  int isRedeem;
  int multipleTimes;
  int isAlreadyPurchase;
  var userBalance;


  RewardData();

  RewardData.fromJson(Map<String, dynamic> json) {
    rewardId = json['rewardId'];
    reward = json['reward'];
    description = json['description'];
    media = json['media'];
    mediaThumb = json['mediaThumb'];
    keywords = json['keywords'];
    points = json['points'];
    leftUnits = json['leftUnits'];
    isRedeem = json['isRedeem'];
    multipleTimes = json['multipleTimes'];
    isAlreadyPurchase = json['isAlreadyPurchase'];
    userBalance = json['userBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rewardId'] = this.rewardId;
    data['reward'] = this.reward;
    data['description'] = this.description;
    data['media'] = this.media;
    data['mediaThumb'] = this.mediaThumb;
    data['keywords'] = this.keywords;
    data['points'] = this.points;
    data['leftUnits'] = this.leftUnits;
    data['isRedeem'] = this.isRedeem;
    data['multipleTimes'] = this.multipleTimes;
    data['isAlreadyPurchase'] = this.isAlreadyPurchase;
    data['userBalance'] = userBalance;
    return data;
  }
}



class RedeemRewardRequest {
  String userId;
  String rewardId;
  String timezone;

  RedeemRewardRequest(
      {this.userId, this.rewardId, this.timezone});

  RedeemRewardRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rewardId = json['rewardId'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['rewardId'] = this.rewardId;
    data['timezone'] = this.timezone;
    return data;
  }
}
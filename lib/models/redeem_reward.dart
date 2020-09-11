class RedeemRewardRequest {
  String userId;
  String rewardId;

  RedeemRewardRequest(
      {this.userId, this.rewardId});

  RedeemRewardRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rewardId = json['rewardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['rewardId'] = this.rewardId;
    return data;
  }
}
class IntroModel {
  String learningModule1;
  String learningModule2;
  String newCustomer1;
  String newCustomer2;
  String customerSituation;
  String existingCustomer1;
  String existingCustomer2;
  String profile1;
  String profile2;
  String org1;
  String org2;
  String org3;
  String org4;
  String rewards;
  String pl1;
  String pl2;
  String ranking1;
  String ranking2;
  String challenge1;
  String challenge2;
  String team1;
  String team2;
  String team3;
  String reward2;
  String firstName;

  IntroModel(
      {this.learningModule1,
        this.learningModule2,
        this.newCustomer1,
        this.newCustomer2,
        this.customerSituation,
        this.existingCustomer1,
        this.existingCustomer2,
        this.profile1,
        this.profile2,
        this.org1,
        this.org2,
        this.org3,
        this.org4,
        this.rewards,
        this.pl1,
        this.pl2,
        this.ranking1,
        this.ranking2,
        this.challenge1,
        this.challenge2,
        this.team1,
        this.team2,
        this.team3,
        this.reward2,
        this.firstName
      });

  IntroModel.fromJson(Map<String, dynamic> json) {
    learningModule1 = json['learningModule1'];
    learningModule2 = json['learningModule2'];
    newCustomer1 = json['newCustomer1'];
    newCustomer2 = json['newCustomer2'];
    customerSituation = json['customerSituation'];
    existingCustomer1 = json['existingCustomer1'];
    existingCustomer2 = json['existingCustomer2'];
    profile1 = json['profile1'];
    profile2 = json['profile2'];
    org1 = json['org1'];
    org2 = json['org2'];
    org3 = json['org3'];
    org4 = json['org4'];
    rewards = json['rewards'];
    pl1 = json['pl1'];
    pl2 = json['pl2'];
    ranking1 = json['ranking1'];
    ranking2 = json['ranking2'];
    challenge1 = json['challenge1'];
    challenge2 = json['challenge2'];
    team1 = json['team1'];
    team2 = json['team2'];
    team3 = json['team3'];
    reward2 = json['reward2'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['learningModule1'] = this.learningModule1;
    data['learningModule2'] = this.learningModule2;
    data['newCustomer1'] = this.newCustomer1;
    data['newCustomer2'] = this.newCustomer2;
    data['customerSituation'] = this.customerSituation;
    data['existingCustomer1'] = this.existingCustomer1;
    data['existingCustomer2'] = this.existingCustomer2;
    data['profile1'] = this.profile1;
    data['profile2'] = this.profile2;
    data['org1'] = this.org1;
    data['org2'] = this.org2;
    data['org3'] = this.org3;
    data['org4'] = this.org4;
    data['rewards'] = this.rewards;
    data['pl1'] = this.pl1;
    data['pl2'] = this.pl2;
    data['ranking1'] = this.ranking1;
    data['ranking2'] = this.ranking2;
    data['challenge1'] = this.challenge1;
    data['challenge2'] = this.challenge2;
    data['team1'] = this.team1;
    data['team2'] = this.team2;
    data['team3'] = this.team3;
    data['reward2'] = this.reward2;
    data['firstName'] = this.firstName;
    return data;
  }
}

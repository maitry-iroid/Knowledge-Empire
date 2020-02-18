class PerformanceRequest {
  int userId;
  int mode;
  int type;

  PerformanceRequest({this.userId, this.mode, this.type});

  PerformanceRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    mode = json['mode'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['mode'] = this.mode;
    data['type'] = this.type;
    return data;
  }
}

class PerformanceResponse {
  String flag;
  String result;
  String msg;
  PerformanceData data;

  PerformanceResponse({this.flag, this.result, this.msg, this.data});

  PerformanceResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    data = json['data'] != null
        ? new PerformanceData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PerformanceData {
  List<ResourceCost> resourceCost;
  List<ModuleRevenue> moduleRevenue;
  OtherRevenue otherRevenue;
  OtherCost otherCost;
  List<Graph> graph;

  PerformanceData(
      {this.resourceCost, this.moduleRevenue, this.otherRevenue, this.graph});

  PerformanceData.fromJson(Map<String, dynamic> json) {
    if (json['resourceCost'] != null) {
      resourceCost = new List<ResourceCost>();
      json['resourceCost'].forEach((v) {
        resourceCost.add(new ResourceCost.fromJson(v));
      });
    }
    if (json['moduleRevenue'] != null) {
      moduleRevenue = new List<ModuleRevenue>();
      json['moduleRevenue'].forEach((v) {
        moduleRevenue.add(new ModuleRevenue.fromJson(v));
      });
    }
    otherRevenue = json['otherRevenue'] != null
        ? new OtherRevenue.fromJson(json['otherRevenue'])
        : null;

    otherCost = json['otherCost'] != null
        ? new OtherCost.fromJson(json['otherCost'])
        : null;
    if (json['graph'] != null) {
      graph = new List<Graph>();
      json['graph'].forEach((v) {
        graph.add(new Graph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceCost != null) {
      data['resourceCost'] = this.resourceCost.map((v) => v.toJson()).toList();
    }
    if (this.moduleRevenue != null) {
      data['moduleRevenue'] =
          this.moduleRevenue.map((v) => v.toJson()).toList();
    }
    if (this.otherRevenue != null) {
      data['otherRevenue'] = this.otherRevenue.toJson();
    }
    if (this.otherCost != null) {
      data['otherCost'] = this.otherCost.toJson();
    }
    if (this.graph != null) {
      data['graph'] = this.graph.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResourceCost {
  int type;
  String name;
  int lastCost;
  int lastEmployee;
  int currentCost;
  int currentEmployee;

  ResourceCost(
      {this.type,
      this.name,
      this.lastCost,
      this.lastEmployee,
      this.currentCost,
      this.currentEmployee});

  ResourceCost.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    lastCost = json['lastCost'];
    lastEmployee = json['lastEmployee'];
    currentCost = json['currentCost'];
    currentEmployee = json['currentEmployee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['lastCost'] = this.lastCost;
    data['lastEmployee'] = this.lastEmployee;
    data['currentCost'] = this.currentCost;
    data['currentEmployee'] = this.currentEmployee;
    return data;
  }
}

class OtherCost {
  int lastCost;
  int currentCost;

  OtherCost({this.lastCost, this.currentCost});

  OtherCost.fromJson(Map<String, dynamic> json) {
    lastCost = json['lastCost'];
    currentCost = json['currentCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastCost'] = this.lastCost;
    data['currentCost'] = this.currentCost;
    return data;
  }
}

class ModuleRevenue {
  String moduleName;
  int lastRevenue;
  int currentRevenue;
  int lastTotalCustomer;
  int currentTotalCustomer;

  ModuleRevenue(
      {this.moduleName,
      this.lastRevenue,
      this.currentRevenue,
      this.lastTotalCustomer,
      this.currentTotalCustomer});

  ModuleRevenue.fromJson(Map<String, dynamic> json) {
    moduleName = json['moduleName'];
    lastRevenue = json['lastRevenue'];
    currentRevenue = json['currentRevenue'];
    lastTotalCustomer = json['lastTotalCustomer'];
    currentTotalCustomer = json['currentTotalCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleName'] = this.moduleName;
    data['lastRevenue'] = this.lastRevenue;
    data['currentRevenue'] = this.currentRevenue;
    data['lastTotalCustomer'] = this.lastTotalCustomer;
    data['currentTotalCustomer'] = this.currentTotalCustomer;
    return data;
  }
}

class OtherRevenue {
  int lastRevenue;
  int currentRevenue;

  OtherRevenue({this.lastRevenue, this.currentRevenue});

  OtherRevenue.fromJson(Map<String, dynamic> json) {
    lastRevenue = json['lastRevenue'];
    currentRevenue = json['currentRevenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastRevenue'] = this.lastRevenue;
    data['currentRevenue'] = this.currentRevenue;
    return data;
  }
}

class Graph {
  int day;
  int revenue;
  int cost;
  int cash;

  Graph({this.day, this.revenue, this.cost, this.cash});

  Graph.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    revenue = json['revenue'];
    cost = json['cost'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['revenue'] = this.revenue;
    data['cost'] = this.cost;
    data['cash'] = this.cash;
    return data;
  }
}

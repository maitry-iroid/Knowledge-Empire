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
  List<Cost> cost;
  List<Revenue> revenue;
  List<Graph> graph;
  Cash cash;

  PerformanceData({this.cost, this.revenue, this.graph, this.cash});

  PerformanceData.fromJson(Map<String, dynamic> json) {
    if (json['cost'] != null) {
      cost = new List<Cost>();
      json['cost'].forEach((v) {
        cost.add(new Cost.fromJson(v));
      });
    }
    if (json['revenue'] != null) {
      revenue = new List<Revenue>();
      json['revenue'].forEach((v) {
        revenue.add(new Revenue.fromJson(v));
      });
    }
    if (json['graph'] != null) {
      graph = new List<Graph>();
      json['graph'].forEach((v) {
        graph.add(new Graph.fromJson(v));
      });
    }
    cash = json['cash'] != null ? new Cash.fromJson(json['cash']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cost != null) {
      data['cost'] = this.cost.map((v) => v.toJson()).toList();
    }
    if (this.revenue != null) {
      data['revenue'] = this.revenue.map((v) => v.toJson()).toList();
    }
    if (this.graph != null) {
      data['graph'] = this.graph.map((v) => v.toJson()).toList();
    }
    if (this.cash != null) {
      data['cash'] = this.cash.toJson();
    }
    return data;
  }
}

class Cost {
  int type;
  String name;
  int lastCost;
  int lastEmployee;
  int currentCost;
  int currentEmployee;

  Cost(
      {this.type,
        this.name,
        this.lastCost,
        this.lastEmployee,
        this.currentCost,
        this.currentEmployee});

  Cost.fromJson(Map<String, dynamic> json) {
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

class Revenue {
  String name;
  int lastRevenue;
  int currentRevenue;
  int lastTotalCustomer;
  int currentTotalCustomer;

  Revenue({this.name, this.lastRevenue, this.currentRevenue});

  Revenue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastRevenue = json['lastRevenue'];
    currentRevenue = json['currentRevenue'];
    lastTotalCustomer = json['lastTotalCustomer'];
    currentTotalCustomer = json['currentTotalCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lastRevenue'] = this.lastRevenue;
    data['currentRevenue'] = this.currentRevenue;
    data['lastTotalCustomer'] = this.lastTotalCustomer;
    data['currentTotalCustomer'] = this.currentTotalCustomer;
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

class Cash {
  int oneDayPreviousCash;
  int previousCash;
  int todayCash;

  Cash({this.oneDayPreviousCash, this.previousCash, this.todayCash});

  Cash.fromJson(Map<String, dynamic> json) {
    oneDayPreviousCash = json['oneDayPreviousCash'];
    previousCash = json['previousCash'];
    todayCash = json['todayCash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oneDayPreviousCash'] = this.oneDayPreviousCash;
    data['previousCash'] = this.previousCash;
    data['todayCash'] = this.todayCash;
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


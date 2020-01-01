class ManageModulePermissionRequest {
  String userId;
  String moduleId;
  String type;

  ManageModulePermissionRequest({this.userId, this.moduleId, this.type});

  ManageModulePermissionRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    moduleId = json['moduleId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['moduleId'] = this.moduleId;
    data['type'] = this.type;
    return data;
  }
}

class ManageModulePermissionResponse {
  String flag;
  String result;
  String msg;
  List<Data> data;

  ManageModulePermissionResponse({this.flag, this.result, this.msg, this.data});

  ManageModulePermissionResponse.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    result = json['result'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Null>();
      json['data'].forEach((v) {
//        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['result'] = this.result;
    data['msg'] = this.msg;
    if (this.data != null) {
//      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Data();
}

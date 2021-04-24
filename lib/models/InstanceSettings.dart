class InstanceSettings {
  Instance instance;
  String authURL;
  String apiURL;
  String clientID;

  InstanceSettings({this.instance, this.authURL, this.apiURL, this.clientID});

  InstanceSettings.fromJson(Map<String, dynamic> json) {
    instance = json['instance'] != null
        ? new Instance.fromJson(json['instance'])
        : null;
    authURL = json['authURL'];
    apiURL = json['apiURL'];
    clientID = json['clientID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.instance != null) {
      data['instance'] = this.instance.toJson();
    }
    data['authURL'] = this.authURL;
    data['apiURL'] = this.apiURL;
    data['clientID'] = this.clientID;
    return data;
  }
}

class Instance {
  String name;
  String loginHint;
  String primaryColor;

  Instance({this.name, this.loginHint, this.primaryColor});

  Instance.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    loginHint = json['loginHint'];
    primaryColor = json['primaryColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['loginHint'] = this.loginHint;
    data['primaryColor'] = this.primaryColor;
    return data;
  }
}
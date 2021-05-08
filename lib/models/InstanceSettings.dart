// generated with https://javiercbk.github.io/json_to_dart/
class InstanceSettings {
  Instance instance;
  String authURL;
  String tokenURL;
  String apiURL;
  String redirectURL;
  String clientID;
  int loopBackPort;
  bool pgpPasswordRequired;

  InstanceSettings(
      {this.instance,
      this.authURL,
      this.tokenURL,
      this.apiURL,
      this.redirectURL,
      this.clientID,
      this.loopBackPort,
      this.pgpPasswordRequired});

  InstanceSettings.fromJson(Map<String, dynamic> json) {
    instance = json['instance'] != null
        ? new Instance.fromJson(json['instance'])
        : null;
    authURL = json['authURL'];
    tokenURL = json['tokenURL'];
    apiURL = json['apiURL'];
    redirectURL = json['redirectURL'];
    clientID = json['clientID'];
    loopBackPort = json['loopBackPort'];
    pgpPasswordRequired = json['pgpPasswordRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.instance != null) {
      data['instance'] = this.instance.toJson();
    }
    data['authURL'] = this.authURL;
    data['tokenURL'] = this.tokenURL;
    data['apiURL'] = this.apiURL;
    data['redirectURL'] = this.redirectURL;
    data['clientID'] = this.clientID;
    data['loopBackPort'] = this.loopBackPort;
    data['pgpPasswordRequired'] = this.pgpPasswordRequired;
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

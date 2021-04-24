class InstanceStatus {
  bool isLoggedIn;
  bool isConfigured;
  bool hasPGPKey;

  InstanceStatus({this.isLoggedIn, this.isConfigured, this.hasPGPKey});

  InstanceStatus.fromJson(Map<String, dynamic> json) {
    isLoggedIn = json['isLoggedIn'];
    isConfigured = json['isConfigured'];
    hasPGPKey = json['hasPGPKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLoggedIn'] = this.isLoggedIn;
    data['isConfigured'] = this.isConfigured;
    data['hasPGPKey'] = this.hasPGPKey;
    return data;
  }
}
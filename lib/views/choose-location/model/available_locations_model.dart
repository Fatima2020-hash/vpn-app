class AvailableLocationsModel {
  Id? iId;
  String? ip;
  int? httpPort;
  int? socks5Port;
  String? login;
  String? password;
  String? country;

  AvailableLocationsModel(
      {this.iId,
        this.ip,
        this.httpPort,
        this.socks5Port,
        this.login,
        this.password,
        this.country});

  AvailableLocationsModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    ip = json['ip'];
    httpPort = json['http_port'];
    socks5Port = json['socks5_port'];
    login = json['login'];
    password = json['password'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['ip'] = this.ip;
    data['http_port'] = this.httpPort;
    data['socks5_port'] = this.socks5Port;
    data['login'] = this.login;
    data['password'] = this.password;
    data['country'] = this.country;
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

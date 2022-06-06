class LoginResponse {
  String? fullName;
  String? partnerId;
  String? response;
  String? linkflg;
  Sessiontokendtls? sessiontokendtls;
  String? mobileno;
  String? respcode;

  LoginResponse(
      {this.fullName,
        this.partnerId,
        this.response,
        this.linkflg,
        this.sessiontokendtls,
        this.mobileno,
        this.respcode});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    partnerId = json['partner_id'];
    response = json['response'];
    linkflg = json['linkflg'];
    sessiontokendtls = json['sessiontokendtls'] != null
        ? new Sessiontokendtls.fromJson(json['sessiontokendtls'])
        : null;
    mobileno = json['mobileno'];
    respcode = json['respcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['partner_id'] = this.partnerId;
    data['response'] = this.response;
    data['linkflg'] = this.linkflg;
    if (this.sessiontokendtls != null) {
      data['sessiontokendtls'] = this.sessiontokendtls!.toJson();
    }
    data['mobileno'] = this.mobileno;
    data['respcode'] = this.respcode;
    return data;
  }
}

class Sessiontokendtls {
  String? tokenkey;
  String? expiredate;

  Sessiontokendtls({this.tokenkey, this.expiredate});

  Sessiontokendtls.fromJson(Map<String, dynamic> json) {
    tokenkey = json['tokenkey'];
    expiredate = json['expiredate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenkey'] = this.tokenkey;
    data['expiredate'] = this.expiredate;
    return data;
  }
}
class LoggedInResponse {
  String? message;
  String? accessToken;
  int? userId;
  String? name;
  String? tokenType;
  String? uuid;
  int? expiresIn;
  String? referalStatus;

  LoggedInResponse(
      {this.message,
        this.accessToken,
        this.userId,
        this.name,
        this.tokenType,
        this.uuid,
        this.expiresIn,
        this.referalStatus});

  LoggedInResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    userId = json['user_id'];
    name = json['name'];
    tokenType = json['token_type'];
    uuid = json['uuid'];
    expiresIn = json['expires_in'];
    referalStatus = json['referal_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['token_type'] = this.tokenType;
    data['uuid'] = this.uuid;
    data['expires_in'] = this.expiresIn;
    data['referal_status'] = this.referalStatus;
    return data;
  }
}


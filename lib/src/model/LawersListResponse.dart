class LawersListResponse {
  String? message;
  int? code;
  List<UserList>? userList;
  int? pages;
  List<States>? states;

  LawersListResponse(
      {this.message, this.code, this.userList, this.pages, this.states});

  LawersListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      userList = <UserList>[];
      json['data'].forEach((v) {
        userList!.add( UserList.fromJson(v));
      });
    }
    pages = json['pages'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add( States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    if (this.userList != null) {
      data['data'] = this.userList!.map((v) => v.toJson()).toList();
    }
    data['pages'] = pages;
    if (states != null) {
      data['states'] =states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  int? id;
  String? uuid;
  String? name;
  String? address;
  String? state;
  String? fieldOfExpertise;
  String? bio;
  String? level;
  String? hoursLogged;
  String? phoneNo;
  String? email;
  String? profilePicture;
  String? rating;
  String? ranking;

  UserList(
      {this.id,
        this.uuid,
        this.name,
        this.address,
        this.state,
        this.fieldOfExpertise,
        this.bio,
        this.level,
        this.hoursLogged,
        this.phoneNo,
        this.email,
        this.profilePicture,
        this.rating,
        this.ranking});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    address = json['address'];
    state = json['state'];
    fieldOfExpertise = json['field_of_expertise'];
    bio = json['bio'];
    level = json['level'];
    hoursLogged = json['hours_logged'];
    phoneNo = json['phone_no'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    rating = json['rating'];
    ranking = json['ranking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['name'] = name;
    data['address'] = address;
    data['state'] = state;
    data['field_of_expertise'] = fieldOfExpertise;
    data['bio'] = bio;
    data['level'] = level;
    data['hours_logged'] = hoursLogged;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['rating'] = rating;
    data['ranking'] = ranking;
    return data;
  }
}

class States {
  String? stateName;
  int? id;

  States({this.stateName, this.id});

  States.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_name'] = stateName;
    data['id'] = id;
    return data;
  }
}


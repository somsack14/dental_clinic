class ClientInfo {
  bool status;
  Data data;

  ClientInfo({this.status, this.data});

  ClientInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String firstname;
  String lastname;
  String username;
  String password;
  String birthday;
  String gender;
  String address;
  String phone;
  String deviceToken;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.firstname,
        this.lastname,
        this.username,
        this.password,
        this.birthday,
        this.gender,
        this.address,
        this.phone,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    password = json['password'];
    birthday = json['birthday'];
    gender = json['gender'];
    address = json['address'];
    phone = json['phone'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

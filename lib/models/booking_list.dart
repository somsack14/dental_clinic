class BookingList {
  bool status;
  List<Data> data;

  BookingList({this.status, this.data});

  BookingList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String timeService;
  List<String> serviceList;
  String status;
  String userReceive;
  String timeBooking;
  String timePeriod;

  Data(
      {this.id,
        this.timeService,
        this.serviceList,
        this.status,
        this.userReceive,
        this.timeBooking,
        this.timePeriod});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeService = json['time_service'];
    serviceList = json['service_list'].cast<String>();
    status = json['status'];
    userReceive = json['user_receive'];
    timeBooking = json['time_booking'];
    timePeriod = json['time_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_service'] = this.timeService;
    data['service_list'] = this.serviceList;
    data['status'] = this.status;
    data['user_receive'] = this.userReceive;
    data['time_booking'] = this.timeBooking;
    data['time_period'] = this.timePeriod;
    return data;
  }
}

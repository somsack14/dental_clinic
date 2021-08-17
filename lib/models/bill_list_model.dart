class BillList {
  bool status;
  List<Data> data;

  BillList({this.status, this.data});

  BillList.fromJson(Map<String, dynamic> json) {
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
  int payPrice;
  int percentDiscount;
  int priceUnDiscount;
  String typePay;
  List<BillDetail> billDetail;

  Data(
      {this.id,
        this.timeService,
        this.payPrice,
        this.percentDiscount,
        this.priceUnDiscount,
        this.typePay,
        this.billDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeService = json['time_service'];
    payPrice = json['pay_price'];
    percentDiscount = json['percent_discount'];
    priceUnDiscount = json['price_UnDiscount'];
    typePay = json['type_pay'];
    if (json['bill_detail'] != null) {
      billDetail = new List<BillDetail>();
      json['bill_detail'].forEach((v) {
        billDetail.add(new BillDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_service'] = this.timeService;
    data['pay_price'] = this.payPrice;
    data['percent_discount'] = this.percentDiscount;
    data['price_UnDiscount'] = this.priceUnDiscount;
    data['type_pay'] = this.typePay;
    if (this.billDetail != null) {
      data['bill_detail'] = this.billDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillDetail {
  String nameService;
  int price;
  int amount;
  int totalPrice;

  BillDetail({this.nameService, this.price, this.amount, this.totalPrice});

  BillDetail.fromJson(Map<String, dynamic> json) {
    nameService = json['name_service'];
    price = json['price'];
    amount = json['amount'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_service'] = this.nameService;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

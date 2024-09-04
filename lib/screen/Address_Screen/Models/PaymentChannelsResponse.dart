import 'dart:io';

class PaymentChannelsResponse {
  List<PaymentChannels>? paymentChannels;
  TransactionDetail? transactionDetail;
  List<ServiceTypeList>? serviceTypeList;
  bool? success;
  String? code;
  String? message;

  PaymentChannelsResponse(
      {this.paymentChannels,
        this.transactionDetail,
        this.serviceTypeList,
        this.success,
        this.code,
        this.message});

  PaymentChannelsResponse.fromJson(Map<String, dynamic> json) {
    if (json['PaymentChannels'] != null) {
      paymentChannels = <PaymentChannels>[];
      json['PaymentChannels'].forEach((v) {
        if (Platform.isIOS && v['ChannelName'] != "GooglePay")
          paymentChannels!.add(new PaymentChannels.fromJson(v));

        if (Platform.isAndroid && v['ChannelName'] != "ApplePay")
          paymentChannels!.add(new PaymentChannels.fromJson(v));
      });
    }
    transactionDetail = json['TransactionDetail'] != null
        ? new TransactionDetail.fromJson(json['TransactionDetail'])
        : null;
    if (json['ServiceTypeList'] != null) {
      serviceTypeList = <ServiceTypeList>[];
      json['ServiceTypeList'].forEach((v) {
        serviceTypeList!.add(new ServiceTypeList.fromJson(v));
      });
    }
    success = json['success'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentChannels != null) {
      data['PaymentChannels'] =
          this.paymentChannels!.map((v) => v.toJson()).toList();
    }
    if (this.transactionDetail != null) {
      data['TransactionDetail'] = this.transactionDetail!.toJson();
    }
    if (this.serviceTypeList != null) {
      data['ServiceTypeList'] =
          this.serviceTypeList!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class PaymentChannels {
  int? iD;
  String? channelName;
  String? imageLocation;
  String? paymentURL;
  int? serviceTypeID;
  String? serviceTypeName;

  PaymentChannels(
      {this.iD,
        this.channelName,
        this.imageLocation,
        this.paymentURL,
        this.serviceTypeID,
        this.serviceTypeName});

  PaymentChannels.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    channelName = json['ChannelName'];
    imageLocation = json['ImageLocation'];
    paymentURL = json['PaymentURL'];
    serviceTypeID = json['ServiceTypeID'];
    serviceTypeName = json['ServiceTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ChannelName'] = this.channelName;
    data['ImageLocation'] = this.imageLocation;
    data['PaymentURL'] = this.paymentURL;
    data['ServiceTypeID'] = this.serviceTypeID;
    data['ServiceTypeName'] = this.serviceTypeName;
    return data;
  }
}

class TransactionDetail {
  String? merchantName;
  String? transactionDescription;
  double? amount;
  String? reference;
  String? mobileNumber;
  String? email;
  String? customerEmail;
  String? customerMobile;
  String? customerName;
  String? merchantLogo;
  String? website;
  String? redirectURl;

  TransactionDetail(
      {this.merchantName,
        this.transactionDescription,
        this.amount,
        this.reference,
        this.mobileNumber,
        this.email,
        this.customerEmail,
        this.customerMobile,
        this.customerName,
        this.merchantLogo,
        this.website,
        this.redirectURl});

  TransactionDetail.fromJson(Map<String, dynamic> json) {
    merchantName = json['MerchantName'];
    transactionDescription = json['TransactionDescription'];
    amount = json['Amount'];
    reference = json['Reference'];
    mobileNumber = json['MobileNumber'];
    email = json['Email'];
    customerEmail = json['CustomerEmail'];
    customerMobile = json['CustomerMobile'];
    customerName = json['CustomerName'];
    merchantLogo = json['MerchantLogo'];
    website = json['Website'];
    redirectURl = json['RedirectURl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MerchantName'] = this.merchantName;
    data['TransactionDescription'] = this.transactionDescription;
    data['Amount'] = this.amount;
    data['Reference'] = this.reference;
    data['MobileNumber'] = this.mobileNumber;
    data['Email'] = this.email;
    data['CustomerEmail'] = this.customerEmail;
    data['CustomerMobile'] = this.customerMobile;
    data['CustomerName'] = this.customerName;
    data['MerchantLogo'] = this.merchantLogo;
    data['Website'] = this.website;
    data['RedirectURl'] = this.redirectURl;
    return data;
  }
}

class ServiceTypeList {
  int? iD;
  String? text;

  ServiceTypeList({this.iD, this.text});

  ServiceTypeList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Text'] = this.text;
    return data;
  }
}
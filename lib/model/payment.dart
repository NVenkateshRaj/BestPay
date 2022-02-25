import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentCollection {
  String? customerName;
  String? nickName;
  String? accountNumber;
  String? phoneNumber;
  String? purpose;
  String? amount;
  String? bearer;
  String? total;
  String? paymentId;
  String? date;
  String? time;
  Timestamp? createdAt;
  PaymentCollection({this.customerName, this.nickName, this.accountNumber,this.createdAt,
    this.phoneNumber, this.purpose, this.amount, this.bearer, this.total,this.paymentId,this.date,this.time});

  factory PaymentCollection.fromJson(Map<String, dynamic> json) => PaymentCollection(
      customerName : json['customerName'],
      nickName : json['nickName'],
      paymentId :json['paymentId'],
      phoneNumber : json['phoneNumber'],
      accountNumber :json['accountNumber'],
      purpose: json['purpose'],
      amount: json['amount'],
      total: json['total'],
      bearer: json['bearer'],
    date: json['date'],
    time: json['time'],
      createdAt : json['createdAt']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['nickName'] = this.nickName;
    data['paymentId'] = this.paymentId;
    data['phoneNumber'] = this.phoneNumber;
    data['accountNumber'] = this.accountNumber;
    data['purpose'] = this.purpose;
    data['amount'] = this.amount;
    data['total'] = this.total;
    data['bearer'] = this.bearer;
    data['date'] = this.date;
    data['time'] = this.time;
    data['createdAt'] =this.createdAt;
    return data;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerCollection{
  String? customerName;
  String? nickName;
  String? customerId;
  String? phoneNumber;
  String? accountNumber;
  String? ifscCode;
  Timestamp? createdAt;
  CustomerCollection({this.customerName, this.customerId, this.phoneNumber,
    this.accountNumber, this.ifscCode,this.nickName,this.createdAt});
  factory CustomerCollection.fromJson(Map<String, dynamic> json) =>
   CustomerCollection(
          customerName : json['customerName'],
          nickName : json['nickName'],
          customerId :json['customerId'],
          phoneNumber : json['phoneNumber'],
          accountNumber :json['accountNumber'],
          createdAt:  json['createdAt'],
          ifscCode : json['IFSC']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['nickName'] = this.nickName;
    data['customerId'] = this.customerId;
    data['phoneNumber'] = this.phoneNumber;
    data['accountNumber'] = this.accountNumber;
    data['IFSC'] = this.ifscCode;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
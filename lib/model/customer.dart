class CustomerCollection{
  String? customerName;
  String? nickName;
  String? customerId;
  String? phoneNumber;
  String? accountNumber;
  String? ifscCode;
  CustomerCollection({this.customerName, this.customerId, this.phoneNumber,
    this.accountNumber, this.ifscCode,this.nickName});
  factory CustomerCollection.fromJson(Map<String, dynamic> json) =>
   CustomerCollection(
          customerName : json['customerName'],
          nickName : json['nickName'],
          customerId :json['customerId'],
          phoneNumber : json['phoneNumber'],
          accountNumber :json['accountNumber'],
          ifscCode : json['IFSC']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['nickName'] = this.nickName;
    data['customerId'] = this.customerId;
    data['phoneNumber'] = this.phoneNumber;
    data['accountNumber'] = this.accountNumber;
    data['IFSC'] = this.ifscCode;
    return data;
  }
}
import 'base_model.dart';

class BankList extends BaseModel{
  int? id;
  String? bankName;
  BankList({this.id, this.bankName});
  factory BankList.fromJson(Map<String, dynamic> json) =>
      BankList(
          id : json['id'],
          bankName : json['bank'],
      );
  BankList fromJson(Map<String, dynamic> json) => BankList.fromJson(json);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bankName;
    return data;
  }
  @override
  bool operator == (Object other) {
    return other is BankList && other.id == id;
  }
}
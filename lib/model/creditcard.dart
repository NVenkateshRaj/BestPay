class CreditCard{
  String? name;
  String? cardNumber;
  String? cardId;
  String? bankName;
  String? cardType;
  CreditCard({this.name, this.cardNumber, this.cardId, this.bankName,this.cardType});
  factory CreditCard.fromJson(Map<String,dynamic> json)=>CreditCard(
    name: json['name'],
    cardNumber: json['cardNumber'],
      cardId: json['cardId'],
    bankName: json['bank'],
    cardType:json['cardType'],
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cardNumber'] = this.cardNumber;
    data['cardId'] = this.cardId;
    data['bank'] = this.bankName;
    data['cardType'] = this.cardType;
    return data;
  }
}
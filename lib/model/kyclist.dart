class KYCDetails{
  String? name;
  String? aadharNumber;
  String? address;
  String? aadharImage;
  String? imageUrl;
  String? aadharId;
  KYCDetails({this.name, this.aadharNumber, this.address, this.imageUrl,this.aadharId,this.aadharImage});
  factory KYCDetails.fromJson(Map<String,dynamic> json)=>KYCDetails(
      name: json['name'],
      aadharNumber: json['aadharNumber'],
      address: json['address'],
      aadharId: json['aadharId'],
      imageUrl: json['imageUrl'],
    aadharImage: json['aadharImage']
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['aadharNumber'] = this.aadharNumber;
    data['address'] = this.address;
    data['imageUrl'] = this.imageUrl;
    data['aadharId'] = this.aadharId;
    data['aadharImage'] = this.aadharImage;
    return data;
  }

}
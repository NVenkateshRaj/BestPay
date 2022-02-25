class UserDetails{
  String? name;
  String? phoneNumber;
  String? password;
  String? userId;
  UserDetails({this.name, this.phoneNumber, this.password,this.userId});
  factory UserDetails.fromJson(Map<String,dynamic> json)=>UserDetails(
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    userId: json['userId'],
    password: json['password']
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['userId'] = this.userId;
    return data;
  }

}
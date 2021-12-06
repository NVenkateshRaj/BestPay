class UserDetails{
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? userId;
  UserDetails({this.name, this.phoneNumber, this.email, this.password,this.userId});
  factory UserDetails.fromJson(Map<String,dynamic> json)=>UserDetails(
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    email: json['email'],
    userId: json['userId'],
    password: json['password']
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['userId'] = this.userId;
    return data;
  }

}
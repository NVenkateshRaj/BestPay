import 'base_model.dart';
class PurposeType extends BaseModel{
  int? id;
  String? purpose;
  PurposeType({this.id, this.purpose});
  factory PurposeType.fromJson(Map<String, dynamic> json) {
   return PurposeType(
      id : json['id'],
      purpose : json['purpose'],
    );
  }
  PurposeType fromJson(Map<String, dynamic> json) => PurposeType.fromJson(json);
  @override
  bool operator == (Object other) {
    return other is PurposeType && other.id == id;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purpose'] = this.purpose;
    return data;
  }
}

class BearerType extends BaseModel{

  int? id;
  String? bearer;

  BearerType({this.id, this.bearer});

  factory BearerType.fromJson(Map<String, dynamic> json) {
    return BearerType(
      id : json['id'],
      bearer : json['bearer'],
    );
  }

  BearerType fromJson(Map<String, dynamic> json) => BearerType.fromJson(json);

  @override
  bool operator == (Object other) {
    return other is BearerType && other.id == id;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bearer'] = this.bearer;
    return data;
  }
}


class TranscationType extends BaseModel{

  int? id;
  String? type;
  double? percentage;

  TranscationType({this.id, this.type,this.percentage});

  factory TranscationType.fromJson(Map<String, dynamic> json) {
    return TranscationType(
      id : json['id'],
        type : json['type'],
      percentage : json['percentage']
    );
  }

  TranscationType fromJson(Map<String, dynamic> json) => TranscationType.fromJson(json);

  @override
  bool operator == (Object other) {
    return other is TranscationType && other.id == id;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['percentage'] = this.percentage;
    return data;
  }
}
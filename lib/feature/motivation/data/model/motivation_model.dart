import 'package:motivation_notification/feature/motivation/domain/entity/motivation_entity.dart';

class MotivationModel {
  String? q;
  String? a;
  String? h;

  MotivationModel({this.q, this.a, this.h});

  MotivationModel.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    a = json['a'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = q;
    data['a'] = a;
    data['h'] = h;
    return data;
  }

  MotivationEntity modelToEntity() {
    return MotivationEntity(author: a, quote: q);
  }
}

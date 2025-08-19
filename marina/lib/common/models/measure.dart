import 'package:marina/common/models/measure_type.dart';

class Measure {
  String? id;
  MeasureType? measureTypeId;
  int? value;

  Measure({this.id, this.measureTypeId, this.value});

  factory Measure.fromJson(Map<String, dynamic> json) => Measure(
    id: json["_id"],
    measureTypeId: MeasureType.fromJson(json["measureTypeId"]),
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "measureTypeId": measureTypeId!.toJson(),
    "value": value,
  };
}

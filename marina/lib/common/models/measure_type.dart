class MeasureType {
  String? id;
  String? name;
  String? text;

  MeasureType({this.id, this.name, this.text});

  factory MeasureType.fromJson(Map<String, dynamic> json) =>
      MeasureType(id: json["_id"], name: json["name"], text: json["text"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "text": text};
}

class Domain {
  String? id;
  String? name;

  Domain({this.id, this.name});

  factory Domain.fromJson(Map<String, dynamic> json) =>
      Domain(id: json["_id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

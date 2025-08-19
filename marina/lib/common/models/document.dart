import 'package:marina/common/models/domain.dart';

class Document {
  String? id;
  Domain? domainId;
  String? title;
  String? text;

  Document({this.id, this.domainId, this.title, this.text});

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["_id"],
    domainId: Domain.fromJson(json["domainId"]),
    title: json["title"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "domainId": domainId!.toJson(),
    "title": title,
    "text": text,
  };
}

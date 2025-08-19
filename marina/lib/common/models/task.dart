import 'package:marina/common/models/document.dart';
import 'package:marina/common/models/measure.dart';
import 'package:marina/common/utils/typedefs.dart';

class TaskModel {
  String? id;
  Document? docId;
  String? userId;
  bool? read;
  DateTime? dtDeadline;
  int? score;
  List<Measure>? measures;
  String? status;
  String? comment;
  DateTime? dtCr;
  int? v;

  TaskModel({
    this.id,
    this.docId,
    this.userId,
    this.read,
    this.dtDeadline,
    this.score,
    this.measures,
    this.status,
    this.comment,
    this.dtCr,
    this.v,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["_id"],
    docId: Document.fromJson(json["docId"]),
    userId: json["userId"],
    read: json["read"],
    dtDeadline: DateTime.parse(json["dtDeadline"]),
    score: json["score"],
    measures: List<Measure>.from(
      json["measures"].map((x) => Measure.fromJson(x)),
    ),
    status: json["status"],
    comment: json['comment'],
    dtCr: DateTime.parse(json["dtCr"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "docId": docId!.toJson(),
    "userId": userId,
    "read": read,
    "dtDeadline": dtDeadline!.toIso8601String(),
    "score": score,
    "measures": List<dynamic>.from(measures!.map((x) => x.toJson())),
    "status": status,
    "comment": comment,
    "dtCr": dtCr!.toIso8601String(),
    "__v": v,
  };
}

class UserTask {
  String? id;
  String? docId;
  String? docTitle;
  bool? read;
  DateTime? dtDeadline;
  String? status;

  UserTask({
    this.id,
    this.docId,
    this.docTitle,
    this.read,
    this.dtDeadline,
    this.status,
  });

  factory UserTask.fromJson(DataMap json) {
    return UserTask(
      id: json['_id'],
      docId: json['docId']['_id'],
      docTitle: json['docId']['title'],
      read: json['read'],
      dtDeadline: DateTime.parse(json['dtDeadline']),
      status: json['status'],
    );
  }

  DataMap toJson() => {
    "_id": id,
    "docId": {"_id": docId, "title": docTitle},
    "read": read,
    "dtDeadline": dtDeadline?.toIso8601String(),
    "status": status,
  };
}

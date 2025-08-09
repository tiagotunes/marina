import 'package:marina/common/utils/typedefs.dart';

class Task {
  String? id;
  String? docId;
  bool? read;
  DateTime? dtDeadline;
  String? status;
  String? comment;
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

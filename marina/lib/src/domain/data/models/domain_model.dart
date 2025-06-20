import 'dart:convert';

import 'package:marina/src/domain/domain/entities/domain.dart';
import 'package:marina/core/utils/typedefs.dart';

class DomainModel extends Domain {
  const DomainModel({
    required super.id,
    required super.name,
    required super.status,
    required super.plannedStatus,
    super.dtStatus,
  });

  const DomainModel.empty()
    : this(
        id: 'Test',
        name: 'empty',
        status: 'inactive',
        plannedStatus: 'inactive',
        dtStatus: null,
      );

  DomainModel copyWith({
    String? id,
    String? name,
    String? status,
    String? plannedStatus,
    DateTime? dtStatus,
  }) {
    return DomainModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      plannedStatus: plannedStatus ?? this.plannedStatus,
      dtStatus: dtStatus ?? this.dtStatus,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'plannedStatus': plannedStatus,
      if (dtStatus != null) 'dtStatus': dtStatus,
    };
  }

  factory DomainModel.fromJson(String source) {
    return DomainModel.fromMap(jsonDecode(source) as DataMap);
  }

  factory DomainModel.fromMap(Map<String, dynamic> map) {
    return DomainModel(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      plannedStatus: map['plannedStatus'] as String,
      dtStatus: map['dtStatus'] as DateTime?,
    );
  }

  String toJson() => jsonEncode(toMap());
}

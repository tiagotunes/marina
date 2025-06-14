import 'package:equatable/equatable.dart';

class Domain extends Equatable {
  const Domain({
    this.id,
    this.name,
    this.status,
    this.plannedStatus,
    this.dtStatus,
  });

  const Domain.empty()
    : id = 'Test',
      name = 'empty',
      status = 'inactive',
      plannedStatus = 'inactive',
      dtStatus = null;

  final String? id;
  final String? name;
  final String? status;
  final String? plannedStatus;
  final DateTime? dtStatus;

  bool get isEmpty =>
      id == null &&
      name == null &&
      status == null &&
      plannedStatus == null &&
      dtStatus == null;

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [id, name, status, plannedStatus, dtStatus];
}

import 'package:equatable/equatable.dart';

class Domain extends Equatable {
  const Domain({
    required this.id,
    required this.name,
    required this.status,
    required this.plannedStatus,
    this.dtStatus,
  });

  const Domain.empty()
    : id = 'Test',
      name = 'empty',
      status = 'inactive',
      plannedStatus = 'inactive',
      dtStatus = null;

  final String id;
  final String name;
  final String status;
  final String plannedStatus;
  final DateTime? dtStatus;

  @override
  List<Object?> get props => [id, name, status, plannedStatus, dtStatus];
}

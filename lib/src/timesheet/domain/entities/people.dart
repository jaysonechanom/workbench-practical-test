
import 'package:equatable/equatable.dart';

class People extends Equatable {
  final int id;
  final String fullName;

  const People({required this.id, required this.fullName});

  @override
  List<Object?> get props => [id, fullName];
}
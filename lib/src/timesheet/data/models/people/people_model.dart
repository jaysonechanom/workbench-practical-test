
import 'package:json_annotation/json_annotation.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
part 'people_model.g.dart';

@JsonSerializable()
class PeopleModel extends People {
  const PeopleModel({
    required super.id,
    required super.fullName
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);

  PeopleModel.fromMap(Map<String, dynamic> map)
      : this(
    id: map['id'] as int,
    fullName: map['fullName'] as String
  );

}
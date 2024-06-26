import 'package:hive/hive.dart';

part 'batch.g.dart';

@HiveType(typeId: 0)
class Batch {
  @HiveField(0)
  String name;

  @HiveField(1)
  String course;

  @HiveField(2)
  String subject;

  @HiveField(3)
  double admissionFee;

  @HiveField(4)
  double fees;

  @HiveField(5)
  String status;

  @HiveField(6)
  String email;

  @HiveField(7)
  List<String> students;

  @HiveField(8)
  List<String> schedule;

  Batch({
    required this.name,
    required this.course,
    required this.subject,
    required this.admissionFee,
    required this.fees,
    required this.status,
    this.email = '',
    this.students = const [],
    this.schedule = const [],
  });
}

class TimeRange {
  final DateTime startTime;
  final DateTime endTime;

  TimeRange({required this.startTime, required this.endTime});
}

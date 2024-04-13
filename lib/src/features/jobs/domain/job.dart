// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:equatable/equatable.dart';

typedef JobID = String;

@immutable
class Job extends Equatable {
  const Job({required this.id, required this.name, required this.ratePerHour});
  factory Job.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    final ratePerHour = data['ratePerHour'] as int;
    return Job(id: id, name: name, ratePerHour: ratePerHour);
  }

  final JobID id;
  final String name;
  final int ratePerHour;

  @override
  List<Object> get props => [name, ratePerHour];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {'name': name, 'ratePerHour': ratePerHour};
  }
}

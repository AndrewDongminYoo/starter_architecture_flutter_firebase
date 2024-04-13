// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.g.dart';
part 'job.freezed.dart';

typedef JobID = String;

@freezed
class Job with _$Job {
  @JsonSerializable(explicitToJson: true)
  const factory Job({
    required JobID id,
    required String name,
    required int ratePerHour,
  }) = _Job;

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    final json = data..['id'] = id;
    return Job.fromJson(json);
  }

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}

extension ToMapExt on Job {
  Map<String, dynamic> toMap() => toJson();
}

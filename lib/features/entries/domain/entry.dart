// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import '../../jobs/domain/job.dart';

part 'entry.g.dart';
part 'entry.freezed.dart';

typedef EntryID = String;

@freezed
class Entry with _$Entry {
  @JsonSerializable(explicitToJson: true)
  const factory Entry({
    required final EntryID id,
    required final JobID jobId,
    required final DateTime start,
    required final DateTime end,
    required final String comment,
  }) = _Entry;

  factory Entry.fromMap(Map<String, dynamic> data, EntryID id) {
    final json = data..['id'] = id;
    return Entry.fromJson(json);
  }

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}

extension EntryToMap on Entry {
  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  Map<String, dynamic> toMap() {
    return toJson();
  }
}

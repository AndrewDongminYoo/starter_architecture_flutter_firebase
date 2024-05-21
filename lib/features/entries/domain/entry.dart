// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import '../../jobs/domain/job.dart' show JobID;

part 'entry.freezed.dart';

typedef EntryID = String;

@freezed
class Entry with _$Entry {
  const factory Entry({
    required final EntryID id,
    required final JobID jobId,
    required final DateTime start,
    required final DateTime end,
    required final String comment,
  }) = _Entry;

  factory Entry.fromMap(Map<dynamic, dynamic> value, EntryID id) {
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      jobId: value['jobId'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }
}

extension EntryToMap on Entry {
  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}

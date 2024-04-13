// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import '../../jobs/domain/job.dart';
import 'entry.dart';

part 'entry_job.freezed.dart';

@freezed
class EntryJob with _$EntryJob {
  const factory EntryJob(
    final Entry entry,
    final Job job,
  ) = _EntryJob;
}

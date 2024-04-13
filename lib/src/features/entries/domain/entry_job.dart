// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'entry.dart';
import '../../jobs/domain/job.dart';

class EntryJob extends Equatable {
  const EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;

  @override
  List<Object?> get props => [entry, job];

  @override
  bool? get stringify => true;
}

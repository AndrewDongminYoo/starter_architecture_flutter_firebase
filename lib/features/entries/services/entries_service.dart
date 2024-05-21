// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

// 🌎 Project imports:
import '../../../utils/format.dart' show Format;
import '../../auth/data/firebase_auth_repository.dart' show firebaseAuthProvider;
import '../../auth/domain/app_user.dart' show UserID;
import '../../jobs/data/jobs_repository.dart' show JobsRepository, jobsRepositoryProvider;
import '../../jobs/domain/job.dart' show Job;
import '../data/entries_repository.dart' show EntriesRepository, entriesRepositoryProvider;
import '../domain/daily_jobs_details.dart' show DailyJobsDetails, JobDetails;
import '../domain/entries_list_tile_model.dart' show EntriesListTileModel;
import '../domain/entry.dart' show Entry;
import '../domain/entry_job.dart' show EntryJob;

part 'entries_service.g.dart';

class EntriesService {
  EntriesService({
    required this.jobsRepository,
    required this.entriesRepository,
  });

  final JobsRepository jobsRepository;
  final EntriesRepository entriesRepository;

  /// List<Job>, List<Entry>를 List<EntryJob>으로 결합합니다.
  Stream<List<EntryJob>> _allEntriesStream(UserID uid) =>
      CombineLatestStream.combine2(
        entriesRepository.watchEntries(uid: uid),
        jobsRepository.watchJobs(uid: uid),
        _entriesJobsCombiner,
      );

  static List<EntryJob> _entriesJobsCombiner(
    List<Entry> entries,
    List<Job> jobs,
  ) {
    return entries.map((entry) {
      final job = jobs.firstWhere((job) => job.id == entry.jobId);
      return EntryJob(entry, job);
    }).toList();
  }

  /// Output stream
  Stream<List<EntriesListTileModel>> entriesTileModelStream(UserID uid) =>
      _allEntriesStream(uid).map(_createModels);

  static List<EntriesListTileModel> _createModels(List<EntryJob> allEntries) {
    if (allEntries.isEmpty) {
      return [];
    }
    final allDailyJobsDetails = DailyJobsDetails.all(allEntries);

    // 모든 작업의 총 소요 시간
    final totalDuration = allDailyJobsDetails
        .map((dateJobsDuration) => dateJobsDuration.duration)
        .reduce((value, element) => value + element);

    // 모든 작업의 총 급여
    final totalPay = allDailyJobsDetails
        .map((dateJobsDuration) => dateJobsDuration.pay)
        .reduce((value, element) => value + element);

    return <EntriesListTileModel>[
      EntriesListTileModel(
        leadingText: 'All Entries',
        middleText: Format.currency(totalPay),
        trailingText: Format.hours(totalDuration),
      ),
      for (final DailyJobsDetails dailyJobsDetails in allDailyJobsDetails) ...[
        EntriesListTileModel(
          isHeader: true,
          leadingText: Format.date(dailyJobsDetails.date),
          middleText: Format.currency(dailyJobsDetails.pay),
          trailingText: Format.hours(dailyJobsDetails.duration),
        ),
        for (final JobDetails jobDuration in dailyJobsDetails.jobsDetails)
          EntriesListTileModel(
            leadingText: jobDuration.name,
            middleText: Format.currency(jobDuration.pay),
            trailingText: Format.hours(jobDuration.durationInHours),
          ),
      ],
    ];
  }
}

@riverpod
EntriesService entriesService(EntriesServiceRef ref) {
  return EntriesService(
    jobsRepository: ref.watch(jobsRepositoryProvider),
    entriesRepository: ref.watch(entriesRepositoryProvider),
  );
}

@riverpod
Stream<List<EntriesListTileModel>> entriesTileModelStream(
  EntriesTileModelStreamRef ref,
) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null when fetching entries");
  }
  final entriesService = ref.watch(entriesServiceProvider);
  return entriesService.entriesTileModelStream(user.uid);
}

// 🌎 Project imports:
import 'entry.dart';
import 'entry_job.dart';

/// 추적된 시간을 저장하고 작업 비용을 지불하는 임시 모델 클래스
class JobDetails {
  JobDetails({
    required this.name,
    required this.durationInHours,
    required this.pay,
  });

  final String name;
  double durationInHours;
  double pay;
}

/// 특정 날짜의 모든 작업/항목을 그룹화합니다.
class DailyJobsDetails {
  DailyJobsDetails({required this.date, required this.jobsDetails});

  final DateTime date;
  final List<JobDetails> jobsDetails;

  double get pay => jobsDetails
      .map((jobDuration) => jobDuration.pay)
      .reduce((value, element) => value + element);

  double get duration => jobsDetails
      .map((jobDuration) => jobDuration.durationInHours)
      .reduce((value, element) => value + element);

  /// 모든 항목을 날짜별로 별도의 그룹으로 나눕니다.
  static Map<DateTime, List<EntryJob>> _entriesByDate(List<EntryJob> entries) {
    final map = <DateTime, List<EntryJob>>{};
    for (final entryJob in entries) {
      final entryDayStart = DateTime(
        entryJob.entry.start.year,
        entryJob.entry.start.month,
        entryJob.entry.start.day,
      );
      if (map[entryDayStart] == null) {
        map[entryDayStart] = [entryJob];
      } else {
        map[entryDayStart]!.add(entryJob);
      }
    }
    return map;
  }

  /// 정렬되지 않은 EntryJob 목록을 날짜 정보가 포함된 DailyJobsDetails 목록에 매핑합니다.
  static List<DailyJobsDetails> all(List<EntryJob> entries) {
    final byDate = _entriesByDate(entries);
    final list = <DailyJobsDetails>[];
    for (final pair in byDate.entries) {
      final date = pair.key;
      final entriesByDate = pair.value;
      final byJob = _jobsDetails(entriesByDate);
      list.add(DailyJobsDetails(date: date, jobsDetails: byJob));
    }
    return list.toList();
  }

  /// 작업별로 항목 그룹화
  static List<JobDetails> _jobsDetails(List<EntryJob> entries) {
    final jobDuration = <String, JobDetails>{};
    for (final entryJob in entries) {
      final entry = entryJob.entry;
      final pay = entry.durationInHours * entryJob.job.ratePerHour;
      if (jobDuration[entry.jobId] == null) {
        jobDuration[entry.jobId] = JobDetails(
          name: entryJob.job.name,
          durationInHours: entry.durationInHours,
          pay: pay,
        );
      } else {
        jobDuration[entry.jobId]!.pay += pay;
        jobDuration[entry.jobId]!.durationInHours += entry.durationInHours;
      }
    }
    return jobDuration.values.toList();
  }
}

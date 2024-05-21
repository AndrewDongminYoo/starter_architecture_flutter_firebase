// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import '../../../auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../../data/jobs_repository.dart' show jobsRepositoryProvider;
import '../../domain/job.dart' show Job, JobID;
import 'job_submit_exception.dart' show JobSubmitException;

part 'edit_job_screen_controller.g.dart';

@riverpod
class EditJobScreenController extends _$EditJobScreenController {
  @override
  FutureOr<void> build() {
    // 반환 타입이 FutureOr<void>인 경우 이 값을 비워두어도 괜찮습니다.
  }

  Future<bool> submit({
    JobID? jobId,
    Job? oldJob,
    required String name,
    required int ratePerHour,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError("User can't be null");
    }
    // 로딩 상태 설정
    state = const AsyncLoading().copyWithPrevious(state);
    // 이미 사용 중인 이름인지 확인
    final repository = ref.read(jobsRepositoryProvider);
    final jobs = await repository.fetchJobs(uid: currentUser.uid);
    final allLowerCaseNames =
        jobs.map((job) => job.name.toLowerCase()).toList();
    // 이전 작업과 동일한 이름을 사용해도 괜찮습니다.
    if (oldJob != null) {
      allLowerCaseNames.remove(oldJob.name.toLowerCase());
    }
    // check if name is already used
    if (allLowerCaseNames.contains(name.toLowerCase())) {
      state = AsyncError(JobSubmitException(), StackTrace.current);
      return false;
    } else {
      // job previously existed
      if (jobId != null) {
        final job = Job(id: jobId, name: name, ratePerHour: ratePerHour);
        state = await AsyncValue.guard(
          () => repository.updateJob(uid: currentUser.uid, job: job),
        );
      } else {
        state = await AsyncValue.guard(
          () => repository.addJob(
            uid: currentUser.uid,
            name: name,
            ratePerHour: ratePerHour,
          ),
        );
      }
      return state.hasError == false;
    }
  }
}

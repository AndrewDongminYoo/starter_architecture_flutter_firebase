// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import '../../../auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../../data/jobs_repository.dart' show jobsRepositoryProvider;
import '../../domain/job.dart' show Job;

part 'jobs_screen_controller.g.dart';

@riverpod
class JobsScreenController extends _$JobsScreenController {
  @override
  FutureOr<void> build() {
    // 반환 타입이 FutureOr<void>인 경우 이 값을 비워두어도 괜찮습니다.
  }

  Future<void> deleteJob(Job job) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError("User can't be null");
    }
    final repository = ref.read(jobsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => repository.deleteJob(uid: currentUser.uid, jobId: job.id),
    );
  }
}

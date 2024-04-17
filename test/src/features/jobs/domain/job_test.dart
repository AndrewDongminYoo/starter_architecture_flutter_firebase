// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:starter_architecture_flutter_firebase/features/jobs/domain/job.dart';

void main() {
  group('fromMap', () {
    test('job with all properties', () {
      final job = Job.fromMap(
        const {
          'name': 'Blogging',
          'ratePerHour': 10,
        },
        'abc',
      );
      expect(job, const Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing name', () {
      // * 'name'이 누락되면 이 에러가 발생합니다:
      // * _CastError:<타입 'Null'은 형 변환에서 'String' 타입의 하위 타입이 아닙니다>.
      // * 테스트가 TypeError를 던질 것으로 예상하여 이를 감지할 수 있습니다.
      expect(
        () => Job.fromMap(
          const {
            'ratePerHour': 10,
          },
          'abc',
        ),
        throwsA(isInstanceOf<TypeError>()),
      );
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const job = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job.toMap(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(name: 'Blogging', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job1 == job2, true);
    });
  });
}

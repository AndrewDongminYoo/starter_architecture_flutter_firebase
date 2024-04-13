// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntryJob {
  Entry get entry => throw _privateConstructorUsedError;
  Job get job => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EntryJobCopyWith<EntryJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryJobCopyWith<$Res> {
  factory $EntryJobCopyWith(EntryJob value, $Res Function(EntryJob) then) =
      _$EntryJobCopyWithImpl<$Res, EntryJob>;
  @useResult
  $Res call({Entry entry, Job job});

  $EntryCopyWith<$Res> get entry;
  $JobCopyWith<$Res> get job;
}

/// @nodoc
class _$EntryJobCopyWithImpl<$Res, $Val extends EntryJob>
    implements $EntryJobCopyWith<$Res> {
  _$EntryJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? job = null,
  }) {
    return _then(_value.copyWith(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as Entry,
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EntryCopyWith<$Res> get entry {
    return $EntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JobCopyWith<$Res> get job {
    return $JobCopyWith<$Res>(_value.job, (value) {
      return _then(_value.copyWith(job: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryJobImplCopyWith<$Res>
    implements $EntryJobCopyWith<$Res> {
  factory _$$EntryJobImplCopyWith(
          _$EntryJobImpl value, $Res Function(_$EntryJobImpl) then) =
      __$$EntryJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Entry entry, Job job});

  @override
  $EntryCopyWith<$Res> get entry;
  @override
  $JobCopyWith<$Res> get job;
}

/// @nodoc
class __$$EntryJobImplCopyWithImpl<$Res>
    extends _$EntryJobCopyWithImpl<$Res, _$EntryJobImpl>
    implements _$$EntryJobImplCopyWith<$Res> {
  __$$EntryJobImplCopyWithImpl(
      _$EntryJobImpl _value, $Res Function(_$EntryJobImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? job = null,
  }) {
    return _then(_$EntryJobImpl(
      null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as Entry,
      null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
    ));
  }
}

/// @nodoc

class _$EntryJobImpl implements _EntryJob {
  const _$EntryJobImpl(this.entry, this.job);

  @override
  final Entry entry;
  @override
  final Job job;

  @override
  String toString() {
    return 'EntryJob(entry: $entry, job: $job)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryJobImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.job, job) || other.job == job));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry, job);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryJobImplCopyWith<_$EntryJobImpl> get copyWith =>
      __$$EntryJobImplCopyWithImpl<_$EntryJobImpl>(this, _$identity);
}

abstract class _EntryJob implements EntryJob {
  const factory _EntryJob(final Entry entry, final Job job) = _$EntryJobImpl;

  @override
  Entry get entry;
  @override
  Job get job;
  @override
  @JsonKey(ignore: true)
  _$$EntryJobImplCopyWith<_$EntryJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

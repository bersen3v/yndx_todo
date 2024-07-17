// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_gen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskData _$TaskDataFromJson(Map<String, dynamic> json) {
  return _TaskData.fromJson(json);
}

/// @nodoc
mixin _$TaskData {
  bool get done => throw _privateConstructorUsedError;
  DateTime? get changedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get lastUpdatedBy => throw _privateConstructorUsedError;
  Importance? get importance => throw _privateConstructorUsedError;
  String? get files => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDataCopyWith<TaskData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDataCopyWith<$Res> {
  factory $TaskDataCopyWith(TaskData value, $Res Function(TaskData) then) =
      _$TaskDataCopyWithImpl<$Res, TaskData>;
  @useResult
  $Res call(
      {bool done,
      DateTime? changedAt,
      DateTime createdAt,
      String text,
      String id,
      DateTime? deadline,
      String lastUpdatedBy,
      Importance? importance,
      String? files});
}

/// @nodoc
class _$TaskDataCopyWithImpl<$Res, $Val extends TaskData>
    implements $TaskDataCopyWith<$Res> {
  _$TaskDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? changedAt = freezed,
    Object? createdAt = null,
    Object? text = null,
    Object? id = null,
    Object? deadline = freezed,
    Object? lastUpdatedBy = null,
    Object? importance = freezed,
    Object? files = freezed,
  }) {
    return _then(_value.copyWith(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      changedAt: freezed == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      importance: freezed == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDataImplCopyWith<$Res>
    implements $TaskDataCopyWith<$Res> {
  factory _$$TaskDataImplCopyWith(
          _$TaskDataImpl value, $Res Function(_$TaskDataImpl) then) =
      __$$TaskDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool done,
      DateTime? changedAt,
      DateTime createdAt,
      String text,
      String id,
      DateTime? deadline,
      String lastUpdatedBy,
      Importance? importance,
      String? files});
}

/// @nodoc
class __$$TaskDataImplCopyWithImpl<$Res>
    extends _$TaskDataCopyWithImpl<$Res, _$TaskDataImpl>
    implements _$$TaskDataImplCopyWith<$Res> {
  __$$TaskDataImplCopyWithImpl(
      _$TaskDataImpl _value, $Res Function(_$TaskDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? changedAt = freezed,
    Object? createdAt = null,
    Object? text = null,
    Object? id = null,
    Object? deadline = freezed,
    Object? lastUpdatedBy = null,
    Object? importance = freezed,
    Object? files = freezed,
  }) {
    return _then(_$TaskDataImpl(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      changedAt: freezed == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      importance: freezed == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDataImpl extends _TaskData {
  const _$TaskDataImpl(
      {required this.done,
      this.changedAt = null,
      required this.createdAt,
      required this.text,
      required this.id,
      this.deadline = null,
      required this.lastUpdatedBy,
      this.importance = Importance.low,
      this.files = null})
      : super._();

  factory _$TaskDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDataImplFromJson(json);

  @override
  final bool done;
  @override
  @JsonKey()
  final DateTime? changedAt;
  @override
  final DateTime createdAt;
  @override
  final String text;
  @override
  final String id;
  @override
  @JsonKey()
  final DateTime? deadline;
  @override
  final String lastUpdatedBy;
  @override
  @JsonKey()
  final Importance? importance;
  @override
  @JsonKey()
  final String? files;

  @override
  String toString() {
    return 'TaskData(done: $done, changedAt: $changedAt, createdAt: $createdAt, text: $text, id: $id, deadline: $deadline, lastUpdatedBy: $lastUpdatedBy, importance: $importance, files: $files)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDataImpl &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.files, files) || other.files == files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, done, changedAt, createdAt, text,
      id, deadline, lastUpdatedBy, importance, files);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDataImplCopyWith<_$TaskDataImpl> get copyWith =>
      __$$TaskDataImplCopyWithImpl<_$TaskDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDataImplToJson(
      this,
    );
  }
}

abstract class _TaskData extends TaskData {
  const factory _TaskData(
      {required final bool done,
      final DateTime? changedAt,
      required final DateTime createdAt,
      required final String text,
      required final String id,
      final DateTime? deadline,
      required final String lastUpdatedBy,
      final Importance? importance,
      final String? files}) = _$TaskDataImpl;
  const _TaskData._() : super._();

  factory _TaskData.fromJson(Map<String, dynamic> json) =
      _$TaskDataImpl.fromJson;

  @override
  bool get done;
  @override
  DateTime? get changedAt;
  @override
  DateTime get createdAt;
  @override
  String get text;
  @override
  String get id;
  @override
  DateTime? get deadline;
  @override
  String get lastUpdatedBy;
  @override
  Importance? get importance;
  @override
  String? get files;
  @override
  @JsonKey(ignore: true)
  _$$TaskDataImplCopyWith<_$TaskDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

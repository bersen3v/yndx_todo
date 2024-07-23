import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yndx_todo/core/enums/importance.dart';

part 'task_gen.freezed.dart';
part 'task_gen.g.dart';

@freezed
class TaskData with _$TaskData {
  const TaskData._();
  const factory TaskData({
    required bool done,
    @Default(null) DateTime? changedAt,
    required DateTime createdAt,
    required String text,
    required String id,
    @Default(null) DateTime? deadline,
    required String lastUpdatedBy,
    @Default(Importance.low) Importance? importance,
    @Default(null) String? files,
  }) = _TaskData;

  factory TaskData.fromJson(Map<String, dynamic> json) =>
      _$TaskDataFromJson(json);
}



// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'task_gen.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// _$TaskDataImpl _$$TaskDataImplFromJson(Map<String, dynamic> json) =>
//     _$TaskDataImpl(
//       done: json['done'] as bool,
//       changedAt: json['changedAt'] == null
//           ? null
//           : DateTime.fromMillisecondsSinceEpoch(json['changed_at'] as int),
//       createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
//       text: json['text'] as String,
//       id: json['id'] as String,
//       deadline: json['deadline'] == null
//           ? null
//           : DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int),
//       lastUpdatedBy: json['last_updated_by'] as String,
//       importance:
//           $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
//               Importance.low,
//       files: json['files'] as String? ?? null,
//     );

// Map<String, dynamic> _$$TaskDataImplToJson(_$TaskDataImpl instance) =>
//     <String, dynamic>{
//       'done': instance.done,
//       'changedAt': instance.changedAt?.toIso8601String(),
//       'createdAt': instance.createdAt.toIso8601String(),
//       'text': instance.text,
//       'id': instance.id,
//       'deadline': instance.deadline?.toIso8601String(),
//       'lastUpdatedBy': instance.lastUpdatedBy,
//       'importance': _$ImportanceEnumMap[instance.importance],
//       'files': instance.files,
//     };

// const _$ImportanceEnumMap = {
//   Importance.low: 'low',
//   Importance.basic: 'basic',
//   Importance.important: 'important',
// };

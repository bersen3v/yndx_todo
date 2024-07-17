// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_gen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskDataImpl _$$TaskDataImplFromJson(Map<String, dynamic> json) =>
    _$TaskDataImpl(
      done: json['done'] as bool,
      changedAt: json['changedAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['changed_at'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      text: json['text'] as String,
      id: json['id'] as String,
      deadline: json['deadline'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['deadline'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.low,
      files: json['files'] as String? ?? null,
    );

Map<String, dynamic> _$$TaskDataImplToJson(_$TaskDataImpl instance) =>
    <String, dynamic>{
      'done': instance.done,
      'changed_at': instance.changedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'text': instance.text,
      'id': instance.id,
      'deadline': instance.deadline?.toIso8601String(),
      'last_updated_by': instance.lastUpdatedBy,
      'importance': _$ImportanceEnumMap[instance.importance],
      'files': instance.files,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.basic: 'basic',
  Importance.important: 'important',
};

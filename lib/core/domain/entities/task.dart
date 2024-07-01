// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:yndx_todo/core/enums/importance.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  DateTime? deadline;
  @HiveField(1)
  DateTime? createdAt;
  @HiveField(2)
  DateTime? changedAt;
  @HiveField(3)
  bool? done;
  @HiveField(4)
  String? text;
  @HiveField(5)
  Importance? importance;
  @HiveField(6)
  String? lastUpdatedBy;
  @HiveField(7)
  int? id;

  Task({
    this.deadline,
    this.createdAt,
    this.changedAt,
    this.done,
    this.text,
    required this.importance,
    this.lastUpdatedBy,
    this.id,
  });

  Task clone() {
    return Task(
        importance: importance,
        deadline: deadline,
        changedAt: changedAt,
        createdAt: createdAt,
        done: done,
        text: text,
        id: id,
        lastUpdatedBy: lastUpdatedBy);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'deadline': deadline?.millisecondsSinceEpoch,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'changed_at': changedAt?.millisecondsSinceEpoch,
      'done': done,
      'text': text,
      'importance': switch (importance) {
        Importance.low => 'low',
        Importance.basic => 'basic',
        Importance.important => 'important',
        null => 'low',
      },
      'last_updated_by': lastUpdatedBy.toString()
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      deadline: map['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : null,
      changedAt: map['changed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['changed_at'] as int)
          : null,
      done: map['done'] != null ? map['done'] as bool : null,
      text: map['text'],
      importance: switch (map['importance']) {
        'low' => Importance.low,
        'basic' => Importance.basic,
        'important' => Importance.important,
        Object() => Importance.low,
        null => Importance.low,
      },
      lastUpdatedBy: map['last_updated_by'],
      id: int.parse(map['id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id ,deadline: $deadline, createdAt: $createdAt, changedAt: $changedAt, done: $done, text: $text, importance: $importance, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  int get hashCode {
    return deadline.hashCode ^
        createdAt.hashCode ^
        changedAt.hashCode ^
        done.hashCode ^
        text.hashCode ^
        importance.hashCode ^
        lastUpdatedBy.hashCode ^
        id.hashCode;
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
    return other.deadline == deadline &&
        other.createdAt == createdAt &&
        other.changedAt == changedAt &&
        other.done == done &&
        other.text == text &&
        other.importance == importance &&
        other.lastUpdatedBy == lastUpdatedBy &&
        other.id == id;
  }

  Task copyWith({
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? changedAt,
    bool? done,
    String? text,
    Importance? importance,
    String? lastUpdatedBy,
    int? id,
  }) {
    return Task(
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      done: done ?? this.done,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      id: id ?? this.id,
    );
  }
}

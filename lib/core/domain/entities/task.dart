import 'dart:convert';

import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';

class Task {
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? changedAt;
  bool? done;
  String? text;
  Importance? importance;
  String? lastUpdatedBy;
  int? id;

  Task({
    this.deadline,
    this.createdAt,
    this.changedAt,
    this.done,
    this.text,
    this.importance,
    this.lastUpdatedBy,
    this.id,
  });

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
    return 'Task(deadline: $deadline, createdAt: $createdAt, changedAt: $changedAt, done: $done, text: $text, importance: $importance, lastUpdatedBy: $lastUpdatedBy)';
  }
}

import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';

class NewTaskService {
  Task task = Task(importance: Importance.basic);

  void resetTask() {
    task = Task(importance: Importance.basic);
  }
}

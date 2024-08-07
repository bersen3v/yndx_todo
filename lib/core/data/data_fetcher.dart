import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger.dart';

class MyHttpClient {
  late int revision;
  String baseUrl = 'https://beta.mrdekk.ru/todo/';

  Future<List<Task>?> get() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/list"),
        headers: {
          "Authorization": "Bearer Calion",
        },
      );

      if (response.statusCode != 200) return null;

      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (map['list'] as List<dynamic>)
          .map((e) => Task.fromMap(e as Map<String, dynamic>))
          .toList();
      revision = map['revision'];
      return list;
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<Task?> getAt(int id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/list/$id"),
        headers: {
          "Authorization": "Bearer Calion",
        },
      );
      if (response.statusCode != 200) return null;
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      revision = map['revision'];
      return Task.fromMap(map['element']);
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<List<Task>?> patch(List<Task> tasks) async {
    try {
      final body = jsonEncode({'list': tasks.map((e) => e.toMap()).toList()});

      final response = await http.patch(
        Uri.parse('$baseUrl/list'),
        headers: {
          "Authorization": "Bearer Calion",
          "X-Last-Known-Revision": '$revision',
        },
        body: body,
      );

      if (response.statusCode != 200) return null;
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (map['list'] as List<dynamic>)
          .map((e) => Task.fromMap(e as Map<String, dynamic>))
          .toList();
      revision = map['revision'];
      return list;
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<Task?> post(Task task) async {
    try {
      final body = jsonEncode({'element': task.toMap()});
      final responce = await http.post(
        Uri.parse('$baseUrl/list'),
        headers: {
          "Authorization": "Bearer Calion",
          "X-Last-Known-Revision": '$revision',
        },
        body: body,
      );
      if (responce.statusCode != 200) return null;
      final map = jsonDecode(responce.body) as Map<String, dynamic>;
      revision = map['revision'];
      return Task.fromMap(map['element']);
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<Task?> put(Task task) async {
    try {
      final body = jsonEncode({'element': task.toMap()});
      final responce = await http.put(
        Uri.parse('$baseUrl/list/${task.id}'),
        headers: {
          "Authorization": "Bearer Calion",
          "X-Last-Known-Revision": '$revision',
        },
        body: body,
      );
      if (responce.statusCode != 200) return null;
      final map = jsonDecode(responce.body) as Map<String, dynamic>;
      revision = map['revision'];
      return Task.fromMap(map['element']);
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  Future<Task?> delete(Task task) async {
    try {
      final responce = await http.delete(
        Uri.parse('$baseUrl/list/${task.id}'),
        headers: {
          "Authorization": "Bearer Calion",
          "X-Last-Known-Revision": '$revision',
        },
      );
      if (responce.statusCode != 200) return null;
      final map = jsonDecode(responce.body) as Map<String, dynamic>;
      revision = map['revision'];
      return Task.fromMap(map['element']);
    } catch (error) {
      logger.e(error);
      return null;
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yndx_todo/core/domain/entities/task.dart';

class MyHttpClient {
  late int revision;
  String baseUrl = 'https://beta.mrdekk.ru/todo/';

  MyHttpClient() {
    init();
  }

  void init() async {}

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
    } catch (_) {
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
    } catch (_) {
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
    } catch (_) {
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
    } catch (_) {
      return null;
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

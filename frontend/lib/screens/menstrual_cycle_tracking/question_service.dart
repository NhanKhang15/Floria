import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ques_ans_model.dart';
import 'package:frontend/constants/config.dart';

class QuestionService {
  final String baseUrl;
  const QuestionService({required this.baseUrl});

  Future<Question> getQuestion(int id) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/questions/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return Question.fromJson(data);
    }

    throw Exception('HTTP ${res.statusCode}: ${res.body}');
  }
}

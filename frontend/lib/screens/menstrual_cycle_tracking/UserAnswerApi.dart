import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/constants/config.dart';

class UserAnswerApi {
  UserAnswerApi();

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
      };

  Future<String> upsertAnswer({
    required int userId,
    required int questionId,
    required int answerId,
    int? cycleId,
  }) async {
    final url = Uri.parse('${AppConfig.baseUrl}/user-answers');
    final res = await http.put(
      url,
      headers: _headers(),
      body: jsonEncode({
        'userId': userId,
        'questionId': questionId,
        'answerId': answerId,
        'cycleId': cycleId,
      }),
    );
    if (res.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(res.body);
      return (json['status'] as String?) ?? 'ok';
    }
    throw Exception('Next failed: ${res.statusCode} ${res.body}');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  static final OpenAIService _instance = OpenAIService._internal();
  factory OpenAIService() => _instance;
  OpenAIService._internal();

  String get _apiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  String get _baseUrl => dotenv.env['OPENAI_BASE_URL'] ?? 'https://api.openai.com/v1';
  String get _model => dotenv.env['OPENAI_MODEL'] ?? 'gpt-4o-mini';

  Future<String> generateDescription({required String prompt, Map<String, dynamic>? extra}) async {
    if (_apiKey.isEmpty) {
      throw Exception('OPENAI_API_KEY missing in assets/env/.env');
    }
    final url = Uri.parse('$_baseUrl/chat/completions');
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'model': _model,
      'messages': [
        {'role': 'system', 'content': 'Du bist ein deutscher Immobilien-Textgenerator. Schreibe prägnante, professionelle Exposé-Texte.'},
        {'role': 'user', 'content': prompt},
      ],
      ...?(extra ?? {}),
    });
    final resp = await http.post(url, headers: headers, body: body);
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final content = json['choices']?[0]?['message']?['content'];
      if (content is String) return content;
    }
    throw Exception('OpenAI error: ${resp.statusCode} ${resp.body}');
  }
}
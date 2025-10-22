import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey =
      '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';

  Future<String> getAIResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-5-nano',
        'messages': [
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    print('Respose: $response');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final choices = data['choices'];
      if (choices != null && choices.isNotEmpty) {
        final message = choices[0]['message'];
        if (message != null && message['content'] != null) {
          return message['content'];
        }
      }
      return '⚠️ Unexpected response format from AI.';
    } else {
      return '❌ Error ${response.statusCode}: ${response.reasonPhrase}';
    }
  }
}

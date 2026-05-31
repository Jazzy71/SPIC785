// lib/services/carnest_chat_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class CarnestChatService {
  static const String apiKey = "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";
  static const String baseUrl = "https://api.groq.com/openai/v1/chat/completions";

  Future<String> sendMessage(String message) async {
    print('Sending message: $message'); // Debug log

    try {
      final requestBody = {
        'model': 'llama-3.1-8b-instant',
        'messages': [
          {
            'role': 'system',
            'content': 'You are CarsBot, an AI assistant specialized in helping users with car-related queries. You work for Carnest, a car marketplace platform. Always be helpful and friendly.'
          },
          {'role': 'user', 'content': message}
        ],
        'temperature': 0.7,
        'max_tokens': 1024,
        'top_p': 1,
      };

      print('Request body: ${jsonEncode(requestBody)}'); // Debug log

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'];
        } else {
          return "I received an unexpected response format. Please try again.";
        }
      } else if (response.statusCode == 401) {
        return "Authentication failed. Please check the API key.";
      } else if (response.statusCode == 429) {
        return "Rate limit exceeded. Please wait a moment before trying again.";
      } else {
        return "Server error (${response.statusCode}): ${response.body}";
      }
    } catch (e) {
      print('Error in sendMessage: $e'); // Debug log
      if (e.toString().contains('TimeoutException')) {
        return "Request timed out. Please check your internet connection and try again.";
      }
      return "Connection error: ${e.toString()}";
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

import 'package:dash_chat_2/dash_chat_2.dart';
import 'openai_service.dart';

class ChatbotService {
  final OpenAIService _openAI = OpenAIService();

  Future<ChatMessage> askAboutProperty({required Map<String, dynamic> property, required String question}) async {
    final prompt = _buildPropertyPrompt(property, question);
    final answer = await _openAI.generateDescription(prompt: prompt);
    return ChatMessage(
      text: answer,
      user: ChatUser(id: 'bot', firstName: 'AIMO'),
      createdAt: DateTime.now(),
    );
  }

  String _buildPropertyPrompt(Map<String, dynamic> property, String question) {
    final features = (property['features'] as List<dynamic>? ?? []).join(', ');
    final title = property['title'] ?? '';
    final address = property['address'] ?? '';
    final rooms = property['rooms']?.toString() ?? '';
    final size = property['size']?.toString() ?? '';
    final price = property['price']?.toString() ?? '';
    final status = property['status'] ?? '';
    final desc = property['description'] ?? '';
    return 'Objekt: $title\nAdresse: $address\nZimmer: $rooms\nFläche: $size m²\nPreis/ Miete: $price\nStatus: $status\nAusstattung: $features\nBeschreibung: $desc\n\nFrage des Interessenten: $question\n\nAntworte knapp, fachkundig, deutsch, und biete proaktiv Hilfe an.';
  }
}
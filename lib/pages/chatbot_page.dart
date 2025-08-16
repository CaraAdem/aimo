import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../services/chatbot_service.dart';

class ChatbotPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const ChatbotPage({super.key, required this.property});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ChatUser _me = ChatUser(id: 'me', firstName: 'Ich');
  final ChatUser _bot = ChatUser(id: 'bot', firstName: 'AIMO');
  final List<ChatMessage> _messages = [];
  final ChatbotService _service = ChatbotService();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        text: 'Hallo! Ich bin der AIMO-Chatbot. Ich kenne alle Details dieses Exposés. Wie kann ich helfen?',
        user: _bot,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _onSend(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _loading = true;
    });
    final answer = await _service.askAboutProperty(property: widget.property, question: message.text);
    setState(() {
      _messages.insert(0, answer);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chatbot',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: DashChat(
              currentUser: _me,
              messages: _messages,
              onSend: _onSend,
              messageOptions: const MessageOptions(
                currentUserContainerColor: Color(0xFF1E3A8A),
                sentMessageTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (_loading)
            const LinearProgressIndicator(minHeight: 2),
        ],
      ),
    );
  }
}
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ai_provider/utils/ai_provider_enum.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/message_item.dart';

class ChatScreen extends StatefulWidget {
  final String url;
  final String apiKey;
  final Map<String, String> selectedProvider;

  const ChatScreen({
    super.key,
    required this.url,
    required this.apiKey,
    required this.selectedProvider,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    OpenAI.apiKey = widget.apiKey;
    OpenAI.baseUrl = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is MessageError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else if (state is MessageInitial) {
                    return const Center(child: Text('Welcome to the chat!'));
                  } else {
                    return ListView.builder(
                      itemCount: state.messages.length + (state is MessageLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (state is MessageLoading && index == state.messages.length) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: MessageItem(
                              message: state.messages[index].message,
                              isUserMessage: state.messages[index].isUserMessage,
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<ChatBloc>().add(
                            SendMessage(
                              request: _controller.text,
                              selectedProvider: widget.selectedProvider['value'] ?? AIProviders.llamaCpp.name,
                            ),
                          );
                      _controller.clear();
                    }

                    _controller.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

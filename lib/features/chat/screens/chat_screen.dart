import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat Demo'),
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
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<ChatBloc>().add(SendMessage(_controller.text));
                      _controller.clear();
                    }
                    // _sendMessage(_controller.text);
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

class MessageItem extends StatelessWidget {
  final bool isUserMessage;
  final String message;

  const MessageItem({
    required this.isUserMessage,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.blueGrey[300] : Colors.grey[300],
        borderRadius: isUserMessage
            ? const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
      ),
      child: Text(
        message,
        textAlign: isUserMessage ? TextAlign.right : TextAlign.left,
      ),
    );
  }
}

class MessageModel {
  final String message;
  final bool isUserMessage;

  MessageModel({required this.message, required this.isUserMessage});
}

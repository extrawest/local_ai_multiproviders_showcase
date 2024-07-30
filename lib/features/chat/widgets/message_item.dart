import 'package:flutter/material.dart';

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

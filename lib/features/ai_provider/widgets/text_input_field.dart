import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final Function onChangedCallback;
  final Map<String, String> selectedProvider;

  const TextInputField({super.key, required this.onChangedCallback, required this.selectedProvider});

  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Add API Key',
        ),
        enabled: widget.selectedProvider['value'] == 'OpenAi' || widget.selectedProvider['value'] == 'Groq',
        onChanged: (String value) {
          widget.onChangedCallback(value)?.call();
        },
      ),
    );
  }
}

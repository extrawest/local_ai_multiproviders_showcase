import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import '../../../common/router.dart';
import '../widgets/providers_dropdown_widget.dart';

class AiProviderScreen extends StatefulWidget {
  final List<Map<String, String>> aiProviderUrls;

  const AiProviderScreen({super.key, required this.aiProviderUrls});

  @override
  State<AiProviderScreen> createState() => _AiProviderScreenState();
}

class _AiProviderScreenState extends State<AiProviderScreen> {
  final String defaultUrl = dotenv.get('LLAMACPP_URL');

  late String url = defaultUrl;
  late String apiKey = '';
  late Map<String, String> selectedProvider = {};

  @override
  Widget build(BuildContext context) {
    log('aiProviderUrls>>> ${apiKey}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AI Provider'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProvidersDropdown(
              aiProviderUrls: widget.aiProviderUrls,
              onChangedCallback: (Map<String, String> value) {
                setState(() {
                  selectedProvider = value;
                  url = value['url'] ?? '';
                  apiKey = value['api'] ?? '';
                });
              },
            ),
            // TextInputField(
            //   selectedProvider: selectedProvider,
            //   onChangedCallback: (String value) {
            //     setState(() {
            //       apiKey = value;
            //     });
            //   },
            // ),
            ElevatedButton(
              onPressed: () {
                context.push(
                  chatScreenRoute,
                  extra: {
                    'url': url,
                    'apiKey': apiKey,
                    'selectedProvider': selectedProvider,
                  },
                );
              },
              child: const Text('Lets Chat'),
            ),
          ],
        ),
      ),
    );
  }
}

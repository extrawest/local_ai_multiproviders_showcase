import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AIProviders {
  openAi,
  groq,
  llamaCpp;

  static final Map<AIProviders, String> _values = {
    AIProviders.openAi: 'OpenAi',
    AIProviders.groq: 'Groq',
    AIProviders.llamaCpp: 'LlamaCpp',
  };

  static final Map<AIProviders, String> _urls = {
    AIProviders.openAi: '',
    AIProviders.groq: '',
    AIProviders.llamaCpp: '',
  };
  static final Map<AIProviders, String> _apis = {
    AIProviders.openAi: '',
    AIProviders.groq: '',
    AIProviders.llamaCpp: '',
  };

  String get value => _values[this]!;

  String get url => _urls[this]!;

  String get api => _apis[this]!;

  bool get isOpenAi => this == AIProviders.openAi;

  bool get isGroq => this == AIProviders.groq;

  bool get isLlamaCpp => this == AIProviders.llamaCpp;

  Widget accountStatusComponent() {
    return Text('User is $value');
  }

  static void initialize() {
    _urls[AIProviders.openAi] = dotenv.get('OPENAI_URL', fallback: '');
    _urls[AIProviders.groq] = dotenv.get('GROQ_URL', fallback: '');
    _urls[AIProviders.llamaCpp] = dotenv.get('LLAMACPP_URL', fallback: '');
    _apis[AIProviders.openAi] = dotenv.get('OPENAI_API_KEY', fallback: '');
    _apis[AIProviders.groq] = dotenv.get('GROQ_API_KEY', fallback: '');
    _apis[AIProviders.llamaCpp] = '';
  }

  static List<Map<String, String>> getValuesAndUrls() {
    return AIProviders.values.map((provider) {
      return {
        'value': provider.value,
        'url': provider.url,
        'api': provider.api,
      };
    }).toList();
  }
}

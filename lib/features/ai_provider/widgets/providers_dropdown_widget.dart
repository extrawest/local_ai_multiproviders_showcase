import 'package:flutter/material.dart';

import '../utils/ai_provider_enum.dart';

class ProvidersDropdown extends StatefulWidget {
  final List<Map<String, String>> aiProviderUrls;
  final Function onChangedCallback;

  const ProvidersDropdown({super.key, required this.aiProviderUrls, required this.onChangedCallback});

  @override
  _ProvidersDropdownState createState() => _ProvidersDropdownState();
}

class _ProvidersDropdownState extends State<ProvidersDropdown> {
  AIProviders? _selectedValue;
  late final List<Map<String, String>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _dropdownItems = widget.aiProviderUrls;
    _selectedValue = AIProviders.llamaCpp;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<AIProviders>(
        value: _selectedValue,
        hint: const Text('Select an option'),
        items: AIProviders.values.map((AIProviders provider) {
          return DropdownMenuItem<AIProviders>(
            value: provider,
            child: Text(_dropdownItems.firstWhere((item) => item['value'] == provider.value)['value']!),
          );
        }).toList(),
        onChanged: (AIProviders? newValue) {
          setState(() {
            _selectedValue = newValue;
          });

          final selectedProvider = _dropdownItems.firstWhere((item) => item['url'] == newValue?.url);
          widget.onChangedCallback(selectedProvider);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'common/router.dart';
import 'features/ai_provider/utils/ai_provider_enum.dart';

Future<void> main() async {
  await dotenv.load();
  AIProviders.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'API Chat',
      routerConfig: goRouter,
    );
  }
}

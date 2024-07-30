import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_llm/common/repository/open_ai_repository.dart';

import '../features/ai_provider/screens/ai_provider_screen.dart';
import '../features/ai_provider/utils/ai_provider_enum.dart';
import '../features/chat/bloc/chat_bloc.dart';
import '../features/chat/screens/chat_screen.dart';

const String aiProviderScreenRoute = '/ai_provider_screen';
const String chatScreenRoute = '/chat_screen';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// the one and only GoRouter instance
final goRouter = GoRouter(
  initialLocation: aiProviderScreenRoute,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: aiProviderScreenRoute,
      pageBuilder: (context, state) => MaterialPage(
        child: AiProviderScreen(
          aiProviderUrls: AIProviders.getValuesAndUrls(),
        ),
      ),
    ),
    GoRoute(
      path: chatScreenRoute,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};

        return MaterialPage(
          child: RepositoryProvider(
            create: (context) => OpenAiRepository(),
            child: BlocProvider(
              create: (context) => ChatBloc(context.read<OpenAiRepository>()),
              child: ChatScreen(
                url: extra['url'] ?? '',
                selectedProvider: extra['selectedProvider'] ?? '',
                apiKey: extra['apiKey'] ?? '',
              ),
            ),
          ),
        );
      },
    ),
  ],
);

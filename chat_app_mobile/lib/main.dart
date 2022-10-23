import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sample_chat_app/core/states/chat/chat_cubit.dart';
import 'package:sample_chat_app/features/login/presentation/login_page.dart';
import 'package:sample_chat_app/generated/l10n.dart';

void main() {
  runApp(BlocProvider<ChatCubit>(
    create: (_) => ChatCubit(),
    child: const MyApp(),
  ));
}

/// Main class to start the app.
class MyApp extends StatelessWidget {
  /// Initializes [MyApp].
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Chat App Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const LoginPage(),
      );
}

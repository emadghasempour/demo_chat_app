import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_chat_app/core/extensions/index.dart';
import 'package:sample_chat_app/core/states/chat/chat_cubit.dart';
import 'package:sample_chat_app/features/rooms_list/presentation/rooms_list_page.dart';

/// Login page.
class LoginPage extends StatefulWidget {
  /// Initializes Login page.
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  late ChatCubit _chatCubit;

  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(context.localization.labelAppName)),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: BlocConsumer<ChatCubit, ChatState>(
              bloc: _chatCubit,
              listener: (BuildContext context, ChatState state) {
                if (state is ChatConnectedState) {
                  _navigateToRoomsListPage();
                }
              },
              builder: (BuildContext context, ChatState state) => Column(
                children: <Widget>[
                  Text(context.localization.labelUsername),
                  TextField(
                    controller: _usernameController,
                  ),
                  ElevatedButton(
                    child: Text(context.localization.labelOK),
                    onPressed: () {
                      final String username = _usernameController.text;
                      if (username.isNotEmpty) {
                        _chatCubit.setUsername(username);
                      }
                    },
                  ),
                  if (state is ChatLoadingState)
                    const CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      );

  void _navigateToRoomsListPage() =>
      Navigator.of(context).pushAndRemoveUntil<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (_) => const RoomsListPage(),
        ),
        (Route<dynamic> route) => false,
      );
}

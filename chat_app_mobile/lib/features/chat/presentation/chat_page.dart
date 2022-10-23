import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_chat_app/core/extensions/index.dart';
import 'package:sample_chat_app/core/states/chat/chat_cubit.dart';

/// Chat page
class ChatPage extends StatefulWidget {
  /// Initializes [ChatPage].
  const ChatPage({
    required this.roomName,
    Key? key,
  }) : super(key: key);

  /// Name of the room.
  final String roomName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatCubit _chatCubit;

  late TextEditingController _messageEditTextController;

  final List<String> _messages = <String>[];

  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context);
    _messageEditTextController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _messages.add(context.localization.msgYouJoined(widget.roomName));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.roomName),
          leading: BackButton(
            onPressed: () {
              _chatCubit.leaveRoom(widget.roomName);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              _buildChatMessagesSection(),
              _buildComposeMessageSection(),
            ],
          ),
        ),
      );

  Widget _buildChatMessagesSection() => Expanded(
        child: BlocConsumer<ChatCubit, ChatState>(
          bloc: _chatCubit,
          listener: (BuildContext context, ChatState state) {
            if (state is ChatMessageState) {
              _messages.add(
                  '${_chatCubit.username == state.username ? context.localization.msgYou : state.username}: ${state.message}');
            } else if (state is ChatNewUserJoinedState) {
              _messages.add(context.localization
                  .msgNewUserJoined(state.username, widget.roomName));
            } else if (state is ChatUserLeftState) {
              _messages.add(context.localization
                  .msgUserLeft(state.username, widget.roomName));
            } else if (state is ChatLeftRoomState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, ChatState state) => ListView.builder(
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(_messages[index]),
              dense: true,
            ),
            itemCount: _messages.length,
            shrinkWrap: true,
          ),
        ),
      );

  Widget _buildComposeMessageSection() => Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageEditTextController,
            ),
          ),
          MaterialButton(
            child: Text(context.localization.labelSend),
            onPressed: () {
              final String newMessage = _messageEditTextController.value.text;
              _chatCubit.sendMessage(newMessage);
              _messageEditTextController.clear();
            },
          ),
        ],
      );
}

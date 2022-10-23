import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_chat_app/core/extensions/index.dart';
import 'package:sample_chat_app/core/states/chat/chat_cubit.dart';
import 'package:sample_chat_app/features/chat/presentation/chat_page.dart';

/// Rooms list page.
class RoomsListPage extends StatefulWidget {
  /// Initializes [RoomsListPage].
  const RoomsListPage({Key? key}) : super(key: key);

  @override
  State<RoomsListPage> createState() => _RoomsListPageState();
}

class _RoomsListPageState extends State<RoomsListPage> {
  late ChatCubit _chatCubit;
  List<String>? rooms;

  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatCubit.getRooms();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.localization.labelRooms),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocConsumer<ChatCubit, ChatState>(
            bloc: _chatCubit,
            listener: (BuildContext context, ChatState state) {
              if (state is ChatRoomsLoadedState) {
                rooms = state.rooms;
              } else if (state is ChatJoinedRoomState) {
                _navigateToChatPage(state.room);
              }
            },
            builder: (BuildContext context, ChatState state) {
              if (state is ChatRoomsLoadedState) {
                rooms = state.rooms;
              }
              return rooms == null
                  ? const CircularProgressIndicator()
                  : _buildRoomsList(rooms!);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateRoomDialog(context),
          child: const Icon(Icons.add),
        ),
      );

  Widget _buildRoomsList(List<String> roomsList) => ListView.builder(
        itemCount: roomsList.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(roomsList[index]),
          onTap: () {
            _chatCubit.joinRoom(roomsList[index]);
          },
        ),
      );

  void _navigateToChatPage(String roomName) =>
      Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (_) => ChatPage(roomName: roomName),
        ),
      );

  void _showCreateRoomDialog(BuildContext context) {
    final TextEditingController createRoomController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(context.localization.labelRoomName),
        content: TextField(
          controller: createRoomController,
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(context.localization.labelOK),
            onPressed: () {
              if(createRoomController.text.isNotEmpty){
                _chatCubit.createRoom(createRoomController.text);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}

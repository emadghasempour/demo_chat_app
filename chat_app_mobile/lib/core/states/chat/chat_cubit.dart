import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sample_chat_app/core/services/chat_service/base_chat_service.dart';
import 'package:sample_chat_app/core/services/chat_service/chat_service.dart';

part 'chat_state.dart';

/// Handles communication between [ChatService] and UI.
class ChatCubit extends Cubit<ChatState> {
  /// Initializes [ChatCubit]
  ChatCubit({
    BaseChatService? chatService,
  }) : super(ChatInitialState()) {
    _chatService = chatService ??
        ChatService(
            onMessageEvent: _onMessage,
            onNewUserJoinedEvent: _onNewUserJoined,
            onSomeUserLeftEvent: _onUserLeft,
            onNewRoomCreatedEvent: _onNewRoomCreated);
  }

  late BaseChatService _chatService;
  late String _username;

  /// Initialize chat socket and receive the status.
  Future<void> initializeChatSocket() async {
    emit(ChatLoadingState());
    await _chatService.initializeSocketConnection();
    emit(ChatConnectedState());
  }

  /// Sends a new [message].
  void sendMessage(String message) {
    _chatService.sendMessage(message);
  }

  /// Create new room.
  void createRoom(String roomName) {
    _chatService.createRoom(roomName);
  }

  /// Returns username.
  String get username => _username;

  /// Returns socket connection state.
  bool get connected => _chatService.isConnected;

  /// Return the list of rooms as String.
  Future<void> getRooms() async {
    final List<String> rooms = await _chatService.getRooms();
    emit(ChatRoomsLoadedState(rooms: rooms));
  }

  /// Join a room
  ///
  /// [roomName: name of the room to join.
  Future<void> joinRoom(String roomName) async {
    final bool joinStatus = await _chatService.joinRoom(roomName);
    if (joinStatus) {
      emit(ChatJoinedRoomState(room: roomName));
    }
  }

  /// Leave room with name [roomName].
  Future<void> leaveRoom(String roomName) async {
    final bool leaveStatus = await _chatService.leaveRoom(roomName);
    if (leaveStatus) {
      emit(ChatLeftRoomState(room: roomName));
    }
  }

  /// Set username.
  void setUsername(String username) {
    _username = username;
    _chatService.setUsername(username);
    initializeChatSocket();
  }

  void _onMessage(dynamic data) {
    final String message = data['message'];
    final String username = data['username'];
    emit(ChatMessageState(message: message, username: username));
  }

  void _onNewUserJoined(dynamic data) {
    final String username = data['username'];
    emit(ChatNewUserJoinedState(username: username));
  }

  void _onUserLeft(dynamic data) {
    final String username = data['username'];
    emit(ChatUserLeftState(username: username));
  }

  void _onNewRoomCreated(dynamic data) {
    getRooms();
  }
}

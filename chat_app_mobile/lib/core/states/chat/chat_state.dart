part of 'chat_cubit.dart';

/// [ChatCubit] base state.
@immutable
abstract class ChatState {}

/// Chat initial state.
class ChatInitialState extends ChatState {}

/// Emitted when something in progress in ChatCubit.
class ChatLoadingState extends ChatState {}

/// Emitted when Socket connected successfully.
class ChatConnectedState extends ChatState {}

/// Emitted when user joined [room] successfully.
class ChatJoinedRoomState extends ChatState {
  /// Initializes [ChatJoinedRoomState]
  ChatJoinedRoomState({required this.room});

  /// Joined room name.
  final String room;
}

/// Emitted when user left [room] successfully.
class ChatLeftRoomState extends ChatState {
  /// Initializes [ChatLeftRoomState].
  ChatLeftRoomState({required this.room});

  /// Left room name.
  final String room;
}

/// Emitted when a new user joined [room].
class ChatNewUserJoinedState extends ChatState {
  /// Initializes [ChatNewUserJoinedState]
  ChatNewUserJoinedState({required this.username});

  /// joined user name.
  final String username;
}

/// Emitted when a user left [room].
class ChatUserLeftState extends ChatState {
  /// Initializes [ChatUserLeftState].
  ChatUserLeftState({required this.username});

  /// Left user name.
  final String username;
}

/// Emitted when list of room loaded successfully.
class ChatRoomsLoadedState extends ChatState {
  /// Initializes [ChatRoomsLoadedState].
  ChatRoomsLoadedState({
    required this.rooms,
  });

  /// List of rooms.
  final List<String> rooms;
}

/// Emitted when a new message received from socket.
class ChatMessageState extends ChatState {
  /// Initializes [ChatMessageState].
  ChatMessageState({
    required this.message,
    required this.username,
  });

  /// received message.
  final String message;

  /// username who sent [message].
  final String username;
}

/// Chat service abstract class.
abstract class BaseChatService {
  /// Indicates if socket is connected or not.
  bool get isConnected;

  /// Abstract function for initializing the socket connection.
  Future<bool> initializeSocketConnection();

  /// Abstract function for sending a message.
  void sendMessage(String message);

  /// Abstract function to get list of available rooms to join.
  Future<List<String>> getRooms();

  /// Abstract function to join room [roomName].
  Future<bool> joinRoom(String roomName);

  /// Abstract function to leave room [roomName].
  Future<bool> leaveRoom(String roomName);

  /// Abstract class to set username.
  void setUsername(String username);

  /// Abstract class for creating a new room.
  void createRoom(String roomName);

  /// Function to be called when a new message received from socket.
  late final Function(dynamic data)? onMessage;

  /// Function to be called when a new user joined current room.
  ///
  /// user information available in [data] parameter.
  late final Function(dynamic data)? onNewUserJoined;

  /// Function to be called when a new user left the current room.
  ///
  /// user information available in [data] parameter.
  late final Function(dynamic data)? onSomeUserLeft;

  /// Function to be called when a new room created.
  ///
  /// room information available in [data] parameter.
  late final Function(dynamic data)? onNewRoomCreated;

  /// Function to be called when socket disconnected.
  late final Function()? onDisconnect;
}

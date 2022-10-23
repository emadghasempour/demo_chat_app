import 'package:sample_chat_app/core/services/chat_service/base_chat_service.dart';

/// MockTradeService for test purposes
class MockChatService extends BaseChatService {
  /// Initializes.
  MockChatService({this.onMessageEvent});

  /// Mock function to be called when a new message received from socket.
  final Function(dynamic data)? onMessageEvent;

  @override
  void createRoom(String roomName) {}

  @override
  Future<List<String>> getRooms() =>
      Future<List<String>>.value(<String>['Room 1', 'Room 2']);

  @override
  Future<bool> initializeSocketConnection() => Future<bool>.value(true);

  @override
  bool get isConnected => true;

  @override
  Future<bool> joinRoom(String roomName) => Future<bool>.value(true);

  @override
  Future<bool> leaveRoom(String roomName) => Future<bool>.value(true);

  @override
  void sendMessage(String message) {
    onMessage?.call(message);
  }

  @override
  void setUsername(String username) {}

  @override
  Function(dynamic data)? get onMessage => onMessageEvent;
}

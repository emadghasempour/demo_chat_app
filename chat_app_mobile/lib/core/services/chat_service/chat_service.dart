import 'dart:async';
import 'dart:convert';

import 'package:sample_chat_app/core/constants.dart';
import 'package:sample_chat_app/core/services/chat_service/base_chat_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

/// Chat service class that handles chat socket interactions.
class ChatService extends BaseChatService {
  /// Initializes [ChatService].
  ChatService({
    this.onMessageEvent,
    this.onDisconnectEvent,
    this.onSomeUserLeftEvent,
    this.onNewUserJoinedEvent,
    this.onNewRoomCreatedEvent,
  });

  /// Function to be called when a new message received from socket.
  final Function(dynamic data)? onMessageEvent;

  /// Function to be called when a new user joined current room.
  ///
  /// user information available in [data] parameter.
  final Function(dynamic data)? onNewUserJoinedEvent;

  /// Function to be called when a new user left the current room.
  ///
  /// user information available in [data] parameter.
  final Function(dynamic data)? onSomeUserLeftEvent;

  /// Function to be called when a new room created.
  ///
  /// room information available in [data] parameter.
  final Function(dynamic data)? onNewRoomCreatedEvent;

  /// Function to be called when socket disconnected.
  final Function()? onDisconnectEvent;

  @override
  Function(dynamic data)? get onMessage => onMessageEvent;

  @override
  Function(dynamic data)? get onNewUserJoined => onNewUserJoinedEvent;

  @override
  Function(dynamic data)? get onSomeUserLeft => onSomeUserLeftEvent;

  @override
  Function(dynamic data)? get onNewRoomCreated => onNewRoomCreatedEvent;

  @override
  Function()? get onDisconnect => onDisconnectEvent;

  late Socket _socket;
  late String _username;

  @override
  Future<bool> initializeSocketConnection() async {
    final Completer<bool> connectionCompleter = Completer<bool>();

    try {
      _socket = io('http://10.0.2.2:5001', <String, dynamic>{
        'transports': <String>['websocket'],
        'autoConnect': false,
      });

      _socket
        ..on(eventConnectKey, (dynamic _) {})
        ..on(eventLoginKey, (dynamic data) {
          connectionCompleter.complete(true);
        })
        ..on(eventMessageKey, (dynamic event) {
          onMessage?.call(event);
        })
        ..on(eventDisconnectKey, (dynamic _) => onDisconnect?.call())
        ..on(eventNewUserJoinedKey, (dynamic data) {
          onNewUserJoined?.call(data);
        })
        ..on(eventUserLeftKey, (dynamic data) {
          onSomeUserLeft?.call(data);
        })
        ..on(eventNewRoomCreatedKey, (dynamic data) {
          onNewRoomCreated?.call(data);
        })
        ..connect()
        ..emit(eventAddUserKey, <String, dynamic>{'username': _username});
    } on Exception {
      rethrow;
    }

    return connectionCompleter.future;
  }

  @override
  Future<List<String>> getRooms() {
    final Completer<List<String>> roomsCompleter = Completer<List<String>>();
    _socket.emitWithAck(eventGetRoomsKey, '', ack: (dynamic result) {
      final List<String> data =
          List<String>.from(jsonDecode(result['rooms']).map((dynamic x) => x));
      roomsCompleter.complete(data);
    });

    return roomsCompleter.future;
  }

  @override
  Future<bool> joinRoom(String roomName) {
    final Completer<bool> joinCompleter = Completer<bool>();
    _socket.emitWithAck(eventJoinRoomKey, roomName, ack: (dynamic result) {
      final bool status = result['status'];
      if (status) {
        joinCompleter.complete(status);
      }
    });

    return joinCompleter.future;
  }

  @override
  Future<bool> leaveRoom(String roomName) {
    final Completer<bool> leaveCompleter = Completer<bool>();
    _socket.emitWithAck(eventLeaveRoomKey, roomName, ack: (dynamic result) {
      final bool status = result['status'];
      if (status) {
        leaveCompleter.complete(status);
      }
    });

    return leaveCompleter.future;
  }

  @override
  void sendMessage(String message) {
    _socket.emitWithAck(eventMessageKey, message, ack: (dynamic result) {});
  }

  @override
  void setUsername(String username) {
    _username = username;
  }

  @override
  bool get isConnected => _socket.connected;

  @override
  void createRoom(String roomName) {
    _socket.emit(eventCreateRoomKey, roomName);
  }
}

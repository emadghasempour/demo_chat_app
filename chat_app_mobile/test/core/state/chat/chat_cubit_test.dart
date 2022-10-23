import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_chat_app/core/services/chat_service/mock_chat_service.dart';
import 'package:sample_chat_app/core/states/chat/chat_cubit.dart';

void main() {
  bool messageSent = false;
  group('Chat Cubit tests', () {
    blocTest<ChatCubit, ChatState>(
        'by call a function from cubit the right event should be called',
        build: () => ChatCubit(
            chatService: MockChatService(
                onMessageEvent: (dynamic a) => messageSent = true)),
        act: (ChatCubit cubit) => cubit.sendMessage('message'),
        verify: (ChatCubit cubit) {
          expect(messageSent, isTrue);
        });

    blocTest<ChatCubit, ChatState>(
        'Initialize should emit the right states',
        build: () => ChatCubit(chatService: MockChatService()),
        act: (ChatCubit cubit) => cubit.initializeChatSocket(),
        expect: () =>
            <Matcher>[isA<ChatLoadingState>(), isA<ChatConnectedState>()]);
  });
}

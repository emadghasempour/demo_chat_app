// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  static String m0(user, room) => "${user} joined ${room}";

  static String m1(user, room) => "${user} left ${room}";

  static String m2(room) => "you joined ${room}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "labelAppName": MessageLookupByLibrary.simpleMessage("Demo Chat"),
        "labelNoRoomAvailable":
            MessageLookupByLibrary.simpleMessage("There is no room available"),
        "labelOK": MessageLookupByLibrary.simpleMessage("OK"),
        "labelRoomName": MessageLookupByLibrary.simpleMessage("Room Name"),
        "labelRooms": MessageLookupByLibrary.simpleMessage("Rooms"),
        "labelSend": MessageLookupByLibrary.simpleMessage("Send"),
        "labelUsername": MessageLookupByLibrary.simpleMessage("Username"),
        "msgNewUserJoined": m0,
        "msgUserLeft": m1,
        "msgYou": MessageLookupByLibrary.simpleMessage("You"),
        "msgYouJoined": m2
      };
}

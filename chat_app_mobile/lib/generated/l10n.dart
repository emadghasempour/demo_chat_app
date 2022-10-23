// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get labelUsername {
    return Intl.message(
      'Username',
      name: 'labelUsername',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get labelOK {
    return Intl.message(
      'OK',
      name: 'labelOK',
      desc: '',
      args: [],
    );
  }

  /// `Rooms`
  String get labelRooms {
    return Intl.message(
      'Rooms',
      name: 'labelRooms',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get labelSend {
    return Intl.message(
      'Send',
      name: 'labelSend',
      desc: '',
      args: [],
    );
  }

  /// `Room Name`
  String get labelRoomName {
    return Intl.message(
      'Room Name',
      name: 'labelRoomName',
      desc: '',
      args: [],
    );
  }

  /// `Demo Chat`
  String get labelAppName {
    return Intl.message(
      'Demo Chat',
      name: 'labelAppName',
      desc: '',
      args: [],
    );
  }

  /// `There is no room available`
  String get labelNoRoomAvailable {
    return Intl.message(
      'There is no room available',
      name: 'labelNoRoomAvailable',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get msgYou {
    return Intl.message(
      'You',
      name: 'msgYou',
      desc: '',
      args: [],
    );
  }

  /// `{user} joined {room}`
  String msgNewUserJoined(Object user, Object room) {
    return Intl.message(
      '$user joined $room',
      name: 'msgNewUserJoined',
      desc: '',
      args: [user, room],
    );
  }

  /// `{user} left {room}`
  String msgUserLeft(Object user, Object room) {
    return Intl.message(
      '$user left $room',
      name: 'msgUserLeft',
      desc: '',
      args: [user, room],
    );
  }

  /// `you joined {room}`
  String msgYouJoined(Object room) {
    return Intl.message(
      'you joined $room',
      name: 'msgYouJoined',
      desc: '',
      args: [room],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

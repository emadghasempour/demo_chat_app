import 'package:flutter/material.dart';
import 'package:sample_chat_app/generated/l10n.dart';

/// Extensions that needs context
extension ContextExtensions on BuildContext{

  /// Create an instance of localization.
  S get localization => S.of(this);
}
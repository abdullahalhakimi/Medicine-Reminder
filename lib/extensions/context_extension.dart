import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

extension BuiledContextExtension on BuildContext{
  AppLocalizations? get localizations => AppLocalizations.of(this);
}
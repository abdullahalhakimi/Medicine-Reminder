import 'dart:async';
import 'package:flutter/material.dart';

// class GeneralStreams {
//   const GeneralStreams._():
//
//   static StreamController<Locale> languageStream = StreamController.broadcast();
// }

class GeneralStreams {
  // Private constructor to prevent instantiation
  const GeneralStreams._();

  // Static StreamController for broadcasting Locale changes
  static final StreamController<Locale> languageStream = StreamController<Locale>.broadcast();

  // Dispose the StreamController
  static void dispose() {
    languageStream.close();
  }
}
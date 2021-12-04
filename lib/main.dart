import 'package:flutter/material.dart';
import 'package:flutter_agenda/ui/app.dart';
import 'package:loggy/loggy.dart';

void main() {
  // this is the key
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(App());
}
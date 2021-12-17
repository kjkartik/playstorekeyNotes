import 'package:flutter/material.dart';
import 'package:keynotes/ui/ui_worker_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkerListPage(),
    );
  }
}

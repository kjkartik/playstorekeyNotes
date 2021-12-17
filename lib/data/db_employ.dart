import 'dart:core';

import '../data_base_employ.dart';

class Employ {
  String id;
  String notes;
  String date;

  Employ({
    required this.date,
    required this.id,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': notes,
      "date": date,
    };
    return map;
  }

  factory Employ.fromMap(Map<String, dynamic> map) {
    return Employ(
      date: map[DBHelper.Date],
      notes: map[DBHelper.NAME],
      id: map[DBHelper.ID],
    );
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

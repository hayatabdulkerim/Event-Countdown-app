import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl =
      'https://6a033cd10d92f63dd2553467.mockapi.io/api/v1';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const List<String> categories = [
    'Exam',
    'Birthday',
    'Trip',
    'Meeting',
    'Deadline',
    'Other',
  ];

  static const Map<String, IconData> categoryIcons = {
    'Exam': Icons.school,
    'Birthday': Icons.cake,
    'Trip': Icons.flight_takeoff,
    'Meeting': Icons.meeting_room,
    'Deadline': Icons.alarm,
    'Other': Icons.event,
  };

  // Add category colors
  static const Map<String, Color> categoryColors = {
    'Exam': Color.fromARGB(255, 27, 151, 33),
    'Birthday': Color.fromARGB(255, 224, 197, 156),
    'Trip': Color.fromARGB(255, 125, 182, 228),
    'Meeting': Color.fromARGB(255, 209, 119, 225),
    'Deadline': Color.fromARGB(255, 234, 126, 118),
    'Other': Color(0xFF607D8B),
  };
}

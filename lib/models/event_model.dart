import 'package:intl/intl.dart';

class Event {
  final dynamic id;
  final String title;
  final String description;
  final String details; 
  final DateTime eventDate;
  final String category;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.details, 
    required this.eventDate,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'details': details, 
      'eventDate': DateFormat('yyyy-MM-dd').format(eventDate),
      'category': category,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(json['eventDate']);
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      details: json['details'] ?? '', 
      eventDate: parsedDate,
      category: json['category'] ?? 'Other',
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../utils/constants.dart';

class ApiService {
  final http.Client client;

  ApiService({required this.client});

  
  Future<List<Event>> getEvents() async {
    try {
      final response = await client.get(
        Uri.parse('${Constants.baseUrl}/events'),
        headers: Constants.headers,
      );

      print('GET Events Response Status: ${response.statusCode}');
      print('GET Events Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((json) => Event.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error in getEvents: $e');
      throw Exception('Network error: $e');
    }
  }

 
  Future<Event> createEvent(Event event) async {
    try {
      final response = await client.post(
        Uri.parse('${Constants.baseUrl}/events'),
        headers: Constants.headers,
        body: json.encode(event.toJson()),
      );

      print('POST Event Response Status: ${response.statusCode}');
      print('POST Event Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return Event.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create event: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating event: $e');
      throw Exception('Network error: $e');
    }
  }

 
  Future<Event> updateEvent(Event event) async {
    try {
      final response = await client.put(
        Uri.parse('${Constants.baseUrl}/events/${event.id}'),
        headers: Constants.headers,
        body: json.encode(event.toJson()),
      );

      print('PUT Event Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return Event.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update event: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating event: $e');
      throw Exception('Network error: $e');
    }
  }


Future<void> deleteEvent(dynamic id) async {
  try {

    final String idString = id.toString();
    final url = '${Constants.baseUrl}/events/$idString';
    print('Delete URL: $url');
    
    final response = await client.delete(
      Uri.parse(url),
      headers: Constants.headers,
    );

    print('Delete response status: ${response.statusCode}');
    

    if (response.statusCode == 200 || 
        response.statusCode == 204 || 
        response.statusCode == 404) {

      return;
    } else {
      throw Exception('Failed to delete. Status: ${response.statusCode}');
    }
  } catch (e) {
    print('Delete error: $e');
    throw Exception('Failed to delete event: $e');
  }
}
}

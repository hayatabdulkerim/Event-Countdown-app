import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/api_service.dart';

class EventProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Event> _events = [];
  bool _isLoading = false;
  String? _errorMessage;

  EventProvider({required this.apiService});

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchEvents() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _events = await apiService.getEvents();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addEvent(Event event) async {
    _setLoading(true);

    try {
      final newEvent = await apiService.createEvent(event);
      _events.add(newEvent);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateEvent(Event event) async {
    _setLoading(true);

    try {
      final updatedEvent = await apiService.updateEvent(event);
      final index = _events.indexWhere((e) => e.id == event.id);
      if (index != -1) {
        _events[index] = updatedEvent;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteEvent(dynamic id) async {
    _setLoading(true);

    try {
      await apiService.deleteEvent(id);
      _events.removeWhere((event) => event.id.toString() == id.toString());
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

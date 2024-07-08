import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  static const String _listKey = 'storedList';
  static const String _loggedInKey = 'loggedIn';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';

  // Load the list from SharedPreferences
  Future<List<String>> loadList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_listKey);
    if (jsonString != null) {
      return List<String>.from(jsonDecode(jsonString));
    } else {
      return [];
    }
  }

  // Save the list to SharedPreferences
  Future<void> saveList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(list);
    await prefs.setString(_listKey, jsonString);
  }

  // Add an item to the list
  Future<void> addItem(String item) async {
    List<String> list = await loadList();
    list.add(item);
    await saveList(list);
  }

  // Remove an item from the list
  Future<void> removeItem(String item) async {
    List<String> list = await loadList();
    list.remove(item);
    await saveList(list);
  }


  // Load the login state
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  // Save the login state
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

  // Save user information
  Future<void> saveUserInfo(String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
  }

  // Load user information
  Future<Map<String, String?>> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final email = prefs.getString(_emailKey);
    return {
      'username': username,
      'email': email,
    };
  }

  // Clear user information
  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_emailKey);
  }
}

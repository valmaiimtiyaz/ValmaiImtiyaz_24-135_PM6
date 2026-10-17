import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'user';
  String _username = '@user';
  String? _profileImagePath;
  int _totalScore = 0;

  String get name => _name;
  String get username => _username;
  String? get profileImagePath => _profileImagePath;
  int get totalScore => _totalScore;

  void updateProfile(String newName, String newUsername) {
    if (newName.isNotEmpty) _name = newName;
    if (newUsername.isNotEmpty) _username = newUsername;
    notifyListeners();
  }

  void updateProfileImage(String newPath) {
    _profileImagePath = newPath;
    notifyListeners();
  }

  void addScore(int score) {
    _totalScore += score;
    notifyListeners();
  }
}

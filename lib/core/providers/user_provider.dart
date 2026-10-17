import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _username = '';
  String _password = '';
  bool _hasAccount = false;
  String? _profileImagePath;
  int _completedQuizzes = 0;

  final Map<String, int> _bestScores = {};

  String get name => _name;
  String get displayName => _name.trim().isEmpty ? 'Teman' : _name.trim();
  String get username => _username;
  String get handle => _username.isEmpty ? '@pengguna' : '@$_username';
  String? get profileImagePath => _profileImagePath;
  int get completedQuizzes => _completedQuizzes;
  int get totalScore => _bestScores.values.fold(0, (sum, s) => sum + s);

  void register({
    required String name,
    required String username,
    required String password,
  }) {
    _name = name.trim();
    _username = username.trim();
    _password = password;
    _hasAccount = true;
    notifyListeners();
  }

  bool signIn(String username, String password) {
    if (_hasAccount) {
      return username.trim() == _username && password == _password;
    }
    _username = username.trim();
    notifyListeners();
    return true;
  }

  void updateName(String newName) {
    if (newName.trim().isEmpty) return;
    _name = newName.trim();
    notifyListeners();
  }

  void updateProfile(String newName, String newUsername) {
    if (newName.trim().isNotEmpty) _name = newName.trim();
    if (newUsername.trim().isNotEmpty) _username = newUsername.trim();
    notifyListeners();
  }

  void updateProfileImage(String newPath) {
    _profileImagePath = newPath;
    notifyListeners();
  }

  void recordResult(String category, int score) {
    final previousBest = _bestScores[category] ?? 0;
    if (score > previousBest) _bestScores[category] = score;
    _completedQuizzes++;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';

class ProfileViewModel extends ChangeNotifier {
  final TokenSharedPrefs _tokenSharedPrefs;
  
  ProfileViewModel({required TokenSharedPrefs tokenSharedPrefs})
      : _tokenSharedPrefs = tokenSharedPrefs;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  Future<void> logout(BuildContext context) async {
    try {
      _isLoggingOut = true;
      notifyListeners();

      // Clear the token from shared preferences
      await _tokenSharedPrefs.deleteToken();
      
      // Add a small delay to show the loading state
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isLoggingOut = false;
      notifyListeners();
      
      // Navigate to login screen and clear the navigation stack
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login', // Replace with your login route
          (route) => false,
        );
      }
    } catch (error) {
      _isLoggingOut = false;
      notifyListeners();
      
      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Add method to get user info if needed
  Future<Map<String, dynamic>?> getUserInfo() async {
    // TODO: Implement getting user info from local storage or API
    // For now, return dummy data
    return {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'role': 'Consumer',
    };
  }
}
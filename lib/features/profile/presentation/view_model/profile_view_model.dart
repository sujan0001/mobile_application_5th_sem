import 'package:batch34_b/features/auth/presentation/view/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';

class ProfileViewModel extends ChangeNotifier {
  final TokenSharedPrefs _tokenSharedPrefs;

  ProfileViewModel({required TokenSharedPrefs tokenSharedPrefs})
      : _tokenSharedPrefs = tokenSharedPrefs;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  Future<void> logout(BuildContext context) async {
    debugPrint('🔴 Logout started');
    
    if (!context.mounted) {
      debugPrint('🔴 Context not mounted, returning');
      return;
    }
    
    try {
      _isLoggingOut = true;
      notifyListeners();
      debugPrint('🔴 Setting isLoggingOut to true');

      final result = await _tokenSharedPrefs.deleteToken();

      result.fold(
        (failure) {
          debugPrint('🔴 Token deletion failed: ${failure.message}');
          _isLoggingOut = false;
          notifyListeners();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logout failed: ${failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        },
        (success) {
          debugPrint('🔴 Token cleared successfully');
        },
      );

      _isLoggingOut = false;
      notifyListeners();
      debugPrint('🔴 Setting isLoggingOut to false');

      // Use WidgetsBinding to ensure navigation happens after current frame
      if (context.mounted) {
        debugPrint('🔴 About to schedule navigation');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          debugPrint('🔴 PostFrameCallback executing');
          if (context.mounted) {
            debugPrint('🔴 Context mounted, navigating to LoginScreen');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) {
                  debugPrint('🔴 Building LoginScreen');
                  return const LoginScreen();
                },
              ),
              (route) {
                debugPrint('🔴 Removing route: ${route.settings.name}');
                return false;
              },
            );
            debugPrint('🔴 Navigation completed');
          } else {
            debugPrint('🔴 Context not mounted in PostFrameCallback');
          }
        });
      } else {
        debugPrint('🔴 Context not mounted before scheduling navigation');
      }
      
    } catch (error) {
      debugPrint('🔴 Logout error: $error');
      _isLoggingOut = false;
      notifyListeners();

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
}
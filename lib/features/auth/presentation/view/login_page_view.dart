// import 'package:batch34_b/features/auth/presentation/view/signup_page_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   static const Color warmOrange = Color(0xFFFF7043);

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFFFF8A65), // warm orange
//                   Color(0xFF4DD0E1), // light teal
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           // Login form
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   constraints: const BoxConstraints(maxWidth: 500),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(color: Colors.white30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Welcome Back',
//                           style: TextStyle(
//                             fontSize: 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Sign in to own authenticated\nSTAMPS',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 30),

//                         // Email field
//                         TextFormField(
//                           controller: _emailController,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             hintText: 'Email address',
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             prefixIcon: const Icon(Icons.email, color: Colors.white),
//                             filled: true,
//                             fillColor: Colors.white.withOpacity(0.1),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) return 'Enter email';
//                             if (!value.contains('@')) return 'Enter valid email';
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Password field
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             prefixIcon: const Icon(Icons.lock, color: Colors.white),
//                             filled: true,
//                             fillColor: Colors.white.withOpacity(0.1),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           validator: (value) =>
//                               value == null || value.isEmpty ? 'Enter password' : null,
//                         ),
//                         const SizedBox(height: 10),

//                         // Forgot password
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               'Forgot Password?',
//                               style: TextStyle(color: warmOrange),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Login button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: warmOrange,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<LoginViewModel>().add(
//                                       LoginWithEmailAndPasswordEvent(
//                                         context: context,
//                                         email: _emailController.text.trim(),
//                                         password: _passwordController.text.trim(),
//                                       ),
//                                     );
//                               }
//                             },
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),

//                         // Sign up link
//                         RichText(
//                           text: TextSpan(
//                             text: "Don't have an account? ",
//                             style: const TextStyle(color: Colors.white70),
//                             children: [
//                               TextSpan(
//                                 text: 'Sign Up',
//                                 style: const TextStyle(
//                                   color: warmOrange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => const SignUpScreen(),
//                                       ),
//                                     );
//                                   },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:batch34_b/features/auth/presentation/view/signup_page_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color warmOrange = Color(0xFFFF7043);
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  bool _isBiometricAvailable = false;
  bool _hasStoredCredentials = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
    _checkStoredCredentials();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final List<BiometricType> availableBiometrics = 
          await _localAuth.getAvailableBiometrics();
      
      if (mounted) {
        setState(() {
          _isBiometricAvailable = isAvailable && availableBiometrics.isNotEmpty;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isBiometricAvailable = false;
        });
      }
    }
  }

  Future<void> _checkStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCredentials = prefs.containsKey('stored_username') && 
                          prefs.containsKey('stored_password');
    final biometricEnabled = prefs.getBool('biometric_enabled') ?? false;
    
    if (mounted) {
      setState(() {
        _hasStoredCredentials = hasCredentials && biometricEnabled;
      });
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to login to your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated) {
        await _loginWithStoredCredentials();
      }
    } catch (e) {
      _showSnackBar(context, 'Biometric authentication failed: ${e.toString()}', isError: true);
    }
  }

  Future<void> _loginWithStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('stored_username');
    final password = prefs.getString('stored_password');

    if (username != null && password != null) {
      context.read<LoginViewModel>().add(
        LoginWithEmailAndPasswordEvent(
          context: context,
          email: username,
          password: password,
        ),
      );
    } else {
      _showSnackBar(context, 'No stored credentials found', isError: true);
    }
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : warmOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFF8A65), // warm orange
                  Color(0xFF4DD0E1), // light teal
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Login form
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sign in to own authenticated\nSTAMPS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Biometric Login Button
                        if (_isBiometricAvailable && _hasStoredCredentials) ...[
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: const BorderSide(color: Colors.white70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _authenticateWithBiometrics,
                              icon: const Icon(Icons.fingerprint, size: 24),
                              label: const Text(
                                'Login with Fingerprint',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Email field
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.email, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Enter email';
                            if (!value.contains('@')) return 'Enter valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter password' : null,
                        ),
                        const SizedBox(height: 10),

                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: warmOrange),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: warmOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginViewModel>().add(
                                      LoginWithEmailAndPasswordEvent(
                                        context: context,
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Sign up link
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(color: Colors.white70),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: warmOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
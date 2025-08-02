// import 'package:batch34_b/features/auth/presentation/view/signup_page_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 const Center(
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Center(
//                   child: Text(
//                     'Sign in to explore authentic Nepalese\ncraftsmanship',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white70, fontSize: 14),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Email field
//                 TextFormField(
//                   controller: _emailController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Your email address',
//                     hintStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon: const Icon(Icons.email, color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.grey.shade800,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Enter email';
//                     if (!value.contains('@')) return 'Enter valid email';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Password field
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Enter your password',
//                     hintStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.grey.shade800,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Enter password' : null,
//                 ),
//                 const SizedBox(height: 8),

//                 // Forgot password
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(color: Theme.of(context).primaryColor),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Login button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<LoginViewModel>().add(
//                               LoginWithEmailAndPasswordEvent(
//                                 context: context,
//                                 email: _emailController.text.trim(),
//                                 password: _passwordController.text.trim(),
//                               ),
//                             );
//                       }
//                     },
//                     child: const Text('Login'),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Sign up link
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: "Don't have an account? ",
//                       style: const TextStyle(color: Colors.white70),
//                       children: [
//                         TextSpan(
//                           text: 'Sign Up',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const SignUpScreen(),
//                                 ),
//                               );
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:batch34_b/features/auth/presentation/view/signup_page_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

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
//                           'Sign in to explore authentic\nNepalese craftsmanship',
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
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(color: Theme.of(context).primaryColor),
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
//                               backgroundColor: Theme.of(context).primaryColor,
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
//                               style: TextStyle(fontSize: 16),
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
//                                 style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const Color warmOrange = Color(0xFFFF7043);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

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
                          'Sign in to explore authentic\nNepalese craftsmanship',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

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
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
}

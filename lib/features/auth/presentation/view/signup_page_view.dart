// import 'package:batch34_b/features/auth/presentation/view/login_page_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _selectedRole = 'consumer'; // Default role

//   @override
//   Widget build(BuildContext context) {
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
//                     'Create Account',
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
//                     'Sign up to explore authentic Nepalese\ncraftsmanship',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white70, fontSize: 14),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextFormField(
//                   controller: _firstNameController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'First Name',
//                     hintStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon: const Icon(Icons.person, color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.grey.shade800,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Enter first name' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _lastNameController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Last Name',
//                     hintStyle: const TextStyle(color: Colors.white70),
//                     prefixIcon:
//                         const Icon(Icons.person_outline, color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.grey.shade800,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Enter last name' : null,
//                 ),
//                 const SizedBox(height: 16),
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
//                     if (value!.isEmpty) return 'Enter email';
//                     if (!value.contains('@')) return 'Enter valid email';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Create a password',
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
//                       value!.isEmpty ? 'Enter password' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   value: _selectedRole,
//                   items: ['consumer', 'creator']
//                       .map((role) => DropdownMenuItem(
//                             value: role,
//                             child: Text(
//                               role[0].toUpperCase() + role.substring(1),
//                             ),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       setState(() {
//                         _selectedRole = value;
//                       });
//                     }
//                   },
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.account_circle, color: Colors.white),
//                     filled: true,
//                     fillColor: Colors.grey.shade800,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   dropdownColor: Colors.grey.shade900,
//                    style: const TextStyle(color: Colors.white),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<RegisterViewModel>().add(
//                               RegisterUserEvent(
//                                 context: context,
//                                 fName: _firstNameController.text.trim(),
//                                 lName: _lastNameController.text.trim(),
//                                 email: _emailController.text.trim(),
//                                 password: _passwordController.text.trim(),
//                                 role: _selectedRole,
//                               ),
//                             );
//                       }
//                     },
//                     child: const Text('Sign Up'),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Already registered? ',
//                       style: const TextStyle(color: Colors.white70),
//                       children: [
//                         TextSpan(
//                           text: 'Log In',
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => const LoginScreen(),
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
import 'package:batch34_b/features/auth/presentation/view/login_page_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const Color warmOrange = Color(0xFFFF7043);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'consumer'; // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background same as login screen
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

          // Sign-up form container with translucent white background and rounded corners
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
                          'Create Account',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sign up to explore authentic\nNepalese craftsmanship',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // First Name
                        TextFormField(
                          controller: _firstNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.person, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter first name' : null,
                        ),
                        const SizedBox(height: 16),

                        // Last Name
                        TextFormField(
                          controller: _lastNameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: const TextStyle(color: Colors.white70),
                            prefixIcon:
                                const Icon(Icons.person_outline, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter last name' : null,
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Your email address',
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

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Create a password',
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
                        const SizedBox(height: 16),

                        // Role dropdown
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          items: ['consumer', 'creator']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(
                                      role[0].toUpperCase() + role.substring(1),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedRole = value;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle, color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: Colors.blueGrey.shade700,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 24),

                        // Sign up button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SignUpScreen.warmOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterViewModel>().add(
                                      RegisterUserEvent(
                                        context: context,
                                        fName: _firstNameController.text.trim(),
                                        lName: _lastNameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                        role: _selectedRole,
                                      ),
                                    );
                              }
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login link
                        RichText(
                          text: TextSpan(
                            text: 'Already registered? ',
                            style: const TextStyle(color: Colors.white70),
                            children: [
                              TextSpan(
                                text: 'Log In',
                                style: const TextStyle(
                                  color: Color(0xFFFF7043),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
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

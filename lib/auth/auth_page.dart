import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:overcome_lust/pages/homepage.dart';

import '../custom_theme/color_palette.dart';

class AuthPage extends StatefulWidget {
  final bool isLogIn;

  const AuthPage({super.key, required this.isLogIn});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool isLogIn;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey to manage form state

  Future<void> _pickDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  bool viewPassword = false;
  bool isLoading = false;

  // Email Validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void initState() {
    isLogIn = widget.isLogIn;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 720;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              border: isMobile ? null : Border.all(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Form(
              key: _formKey, // Assign the form key to the Form widget
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'True Purity',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 20),

                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    validator: _validateEmail,
                    obscureText: false,
                    suffixIcon: null,
                  ),

                  SizedBox(height: 20),

                  // Password TextField with a visibility toggle
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: !viewPassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          viewPassword = !viewPassword;
                        });
                      },
                      child: Icon(
                        viewPassword
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                      ),
                    ),
                  ),

                  if (!isLogIn) SizedBox(height: 20),

                  if (!isLogIn)
                    CustomTextField(
                      controller: usernameController,
                      label: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      obscureText: false,
                      suffixIcon: null,
                    ),

                  if (!isLogIn) SizedBox(height: 20),

                  // Date of Birth TextField
                  if (!isLogIn)
                    TextField(
                      controller: dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorPalette.accent,
                              width: 1.5), // Color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2), // Color when focused
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _pickDateOfBirth(context),
                        ),
                      ),
                    ),

                  SizedBox(height: 40),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Only proceed if the form is valid
                              if (isLogIn) {
                                // Handle login logic
                                logIn();
                              } else {
                                // Handle logout logic
                                signUp(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  isLogIn ? 'Sing in' : 'Sing up',
                                  style: TextStyle(
                                    color: ColorPalette.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                        SizedBox(height: 7),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLogIn = !isLogIn;
                            });
                          },
                          child: Text(
                            isLogIn ? 'Sign up instead' : 'Sign in instead',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ColorPalette.accent,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Login Method
  Future<void> logIn() async {
    final auth = FirebaseAuth.instance;
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        setState(() {
          isLoading = true;
        });

        context.go('/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect email or password')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Method to handle Sign Up
  Future<void> signUp(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Get the user ID (UID) for Firestore document
        String userId = userCredential.user!.uid;

        // Save user data to Firestore
        await db.collection('users').doc(userId).set({
          'username': usernameController.text,
          'email': emailController.text,
          'dob': dobController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        setState(() {
          isLoading = false;
        });

        context.go('/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing up!')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorPalette.accent, width: 1.5), // Color when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: 2), // Color when focused
        ),
        labelText: label,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
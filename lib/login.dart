import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  String? emailErrorMessage = '';
  String? passwordErrorMessage = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  Future<void> _signIn(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // User signed in successfully
      print('User signed in: ${userCredential.user!.uid}');
      // Navigate to final page or wherever needed
      Navigator.popAndPushNamed(context, 'finalPage');
    } catch (e) {
      print('Failed to sign in: $e');
      // Handle sign in errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email ID',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              if (!value.contains('@') ||
                                  !value.contains('.')) {
                                emailErrorMessage =
                                    'Please enter a valid email address';
                              } else {
                                emailErrorMessage = '';
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF3F3F3),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF3F3F3),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        if (emailErrorMessage!.isNotEmpty)
                          Text(
                            emailErrorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: passController,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              if (value.length < 6) {
                                passwordErrorMessage =
                                    'Minimum 6 Characters Required';
                              } else {
                                passwordErrorMessage = '';
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF3F3F3),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF3F3F3),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (passwordErrorMessage!.isNotEmpty)
                    Text(
                      passwordErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _signIn(
                          emailController.text.trim(),
                          passController.text.trim(),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFF3F3F3),
                        size: 28,
                      ),
                      label: Text(''),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            color: Color(0xFFF3F3F3),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'forgotPassword');
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: Text(
                      "Don't have an account? Sign-Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 85,
              right: 0,
              child: Image.asset(
                'images/Rectangle.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

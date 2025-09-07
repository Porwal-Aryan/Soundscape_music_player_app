import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  Future<void> _signUp(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // User signed up successfully
      print('User signed up: ${userCredential.user!.uid}');
      // Navigate to final page or wherever needed
      Navigator.popAndPushNamed(context, 'finalPage');
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle sign up errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0), // Adjust this value to move the contents down
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CREATE AN ACCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
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
                            if (!value.contains('@') || !value.contains('.')) {
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
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Password',
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
                      SizedBox(height: 8),
                      if (passwordErrorMessage!.isNotEmpty)
                        Text(
                          passwordErrorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Sign-up button modified
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _signUp(
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
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        'Already have an account? Login.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 85,
              right: 0,
              child: Image.asset(
                'images/Rectangle.png', // Replace with your image path
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

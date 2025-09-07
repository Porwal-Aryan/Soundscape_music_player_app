import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? email;
  String? errorMessage = '';
  String? successMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: email!);
      setState(() {
        successMessage =
            'Password reset link has been sent to your email address.';
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        successMessage = '';
      });
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
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FORGOT PASSWORD',
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              email = value;
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
                  if (errorMessage!.isNotEmpty)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (successMessage!.isNotEmpty)
                    Text(
                      successMessage!,
                      style: TextStyle(color: Colors.green),
                    ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (email!.isEmpty) {
                          setState(() {
                            errorMessage = 'Email cannot be empty';
                          });
                          return;
                        }
                        resetPassword();
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

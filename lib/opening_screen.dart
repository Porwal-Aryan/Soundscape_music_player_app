import 'package:flutter/material.dart';
import 'package:soundscape/auth/wrapper.dart';
// import 'package:soundscape/onbording.dart';

// class OpeningScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//             'assets/logo.png'), // Replace 'assets/logo.png' with your actual logo asset path
//       ),
//     );
//   }
// }

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wait for 2 seconds before navigating to the onboarding screens
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Wrapper(), // Navigate to your onboarding screen
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 0.5,
          child: Image.asset(
              'images/App_icon.png'), // Replace 'assets/logo.png' with your actual logo asset path
        ),
      ),
    );
  }
}

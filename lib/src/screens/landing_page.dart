import 'dart:async';

import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/home_page.dart';
import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:apt3065/src/widgets/scrollingbg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apt3065/src/screens/login.dart';
import 'package:apt3065/src/screens/signup.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LandingServices splashScreen = LandingServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ContinuousScrollingBackground(), // Add this line

            Center(
              child: Container(
                height: 440,
                width: width * 0.9,
                decoration: BoxDecoration(
                  // gradient: RadialGradient(colors: [
                  //   Color.fromRGBO(51, 78, 255, 1),

                  //   Color.fromARGB(255, 49, 249, 179),
                  //   // Color.fromRGBO(0, 34, 255, 1),
                  // ]),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border:
                      Border.all(color: GeneralAppColors.blackColor, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'LabGenie!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          fontFamily: "QuickSand",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Logo
                    Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Application Name
                    const Text(
                      'Discover, Learn, Experiment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "QuickSand",
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Container(
                          width: width * 0.45,
                          height: height * 0.1 < 0.1 ? height * 0.6 : 57,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 47, 47),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Register or Log In',
                            style: TextStyle(
                              color: GeneralAppColors.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Balsamiq Sans",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 1), () {
        Get.offNamed('/AuthPage');
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        // Get.offNamed('/LoginPage');
      });
    }
  }
}

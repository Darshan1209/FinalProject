import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/constants/sizes.dart';
import 'package:apt3065/src/constants/txt.dart';
import 'package:apt3065/src/screens/forgot_password.dart';
import 'package:apt3065/src/screens/signup.dart';
import 'package:apt3065/src/utils/auth_controller.dart';
import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:apt3065/src/widgets/custom_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ValueNotifier userCredential = ValueNotifier('');
    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget(
          mobile: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height,
                  color: GeneralAppColors.whiteColor,
                  padding: const EdgeInsets.only(
                      left: insetSize, right: insetSize, top: insetSize),
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo.png",
                          width: 120, height: 120),
                      // const Text(
                      //   appTitle,
                      //   style: TextStyle(
                      //     fontSize: 40,
                      //     fontWeight: FontWeight.w600,
                      //     fontFamily: "Balsamiq Sans",
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      const Text(
                        welcomeTxtlogin,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: "QuickSand",
                        ),
                      ),
                      // Text(
                      //   signInTxt,
                      //   style: TextStyle(
                      //       fontSize: 40,
                      //       fontFamily: "QuickSand",
                      //       fontWeight: FontWeight.w900),
                      // ),
                      // SizedBox(height: height * 0.0050),
                      // Text(
                      //   signInSubHeading,
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      SizedBox(
                        height: height * 0.050,
                      ),
                      CustomLoginSignupFormField(
                        height: height * 0.08,
                        theme: Theme.of(context),
                        labelText: emailLabel,
                        controller: emailController,
                        icon: Iconsax.sms,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(10),
                        ),
                        hintText: emailPlaceholder,
                        maxWidth: width,
                        isPasswordField: false,
                      ),
                      const SizedBox(height: 5),
                      CustomLoginSignupFormField(
                        height: height * 0.08,
                        theme: Theme.of(context),
                        labelText: passwordLabel,
                        controller: passwordController,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(30),
                        ),
                        hintText: passwordPlaceholder,
                        maxWidth: width,
                        isPasswordField: true,
                        icon: Icons.check_box_outline_blank,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                          },
                          child: const Text(forgotPassword,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Balsamiq Sans",
                                  color: GeneralAppColors.mainColor)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GestureDetector(
                        onTap: login,
                        child: Container(
                            width: width * 0.45,
                            height: height * 0.1 < 0.1 ? height * 0.6 : 57,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 47, 47),
                                borderRadius: BorderRadius.circular(30)),
                            alignment: Alignment.center,
                            child: const Text(
                              signInTxt,
                              style: TextStyle(
                                  color: GeneralAppColors.whiteColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Balsamiq Sans"),
                            )),
                      ),
                      SizedBox(height: height * 0.035),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a Member? ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: GeneralAppColors.blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Balsamiq Sans",
                                    fontWeight: FontWeight.w800,
                                    color: GeneralAppColors.callToActionColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          desktop: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(insetSize),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          appTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        Text(
                          welcomeTxtlogin,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        // Text(
                        //   signInTxt,
                        //   style: Theme.of(context).textTheme.titleMedium,
                        // ),
                        // Text(
                        //   signInSubHeading,
                        //   style: Theme.of(context).textTheme.headlineSmall,
                        // ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          maxWidth: 640,
                          theme: Theme.of(context),
                          labelText: emailLabel,
                          controller: emailController,
                          icon: Icons.email,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                            bottom: Radius.circular(10),
                          ),
                          hintText: emailPlaceholder,
                          isPasswordField: false,
                        ),
                        const SizedBox(height: 5),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          maxWidth: 640,
                          theme: Theme.of(context),
                          labelText: passwordLabel,
                          controller: passwordController,
                          icon: Icons.password,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(30),
                          ),
                          hintText: passwordPlaceholder,
                          isPasswordField: true,
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed('/ForgotPassword');
                              },
                              child: Text(
                                forgotPassword,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: GeneralAppColors.mainColor),
                              ),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                            width: 640,
                            height: height * 0.1 < 0.1 ? height * 0.1 : 50,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(signInTxt.toUpperCase())))
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  void login() async {
    bool isValid = EmailValidator.validate(emailController.text.trim());

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Email is empty", "Please enter your email ID",
          snackPosition: SnackPosition.BOTTOM);
    } else if (!isValid) {
      Get.snackbar("Invalid Email", "Please enter a valid email ID",
          snackPosition: SnackPosition.BOTTOM);
    } else if (password.isEmpty) {
      Get.snackbar("Password is empty", "Please enter your password",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      AuthenticationService authService = AuthenticationService();
      authService.loginUser(email: email, password: password);
    }
  }

  Future<dynamic> signInWithGoogle(ref) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      AuthenticationService authService = AuthenticationService();
      authService.signInWithGoogle(ref);
      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }
}

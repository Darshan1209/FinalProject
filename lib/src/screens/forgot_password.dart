import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/constants/sizes.dart';
import 'package:apt3065/src/constants/txt.dart';
import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:apt3065/src/widgets/custom_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: ResponsiveWidget(
            mobile: Container(
                color: GeneralAppColors.whiteColor,
                padding: const EdgeInsets.all(insetSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png",
                        width: 120, height: 120),
                    // Text(
                    //   appTitle,
                    //   style: TextStyle(
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.w600,
                    //     fontFamily: "Balsamiq Sans",
                    //   ),
                    // ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      forgotPasswordTitle,
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "QuickSand",
                          fontWeight: FontWeight.w900,
                          color: GeneralAppColors.mainColor),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      forgotPasswordText,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Product Sans",
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    CustomLoginSignupFormField(
                      height: height * 0.13,
                      theme: Theme.of(context),
                      labelText: emailLabel,
                      controller: emailController,
                      icon: Iconsax.sms,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                        bottom: Radius.circular(30),
                      ),
                      hintText: emailPlaceholder,
                      maxWidth: width,
                      isPasswordField: false,
                    ),
                    SizedBox(height: height * 0.03),
                    TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            backTxt,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Product Sans",
                                fontWeight: FontWeight.w600,
                                color: GeneralAppColors.mainColor),
                          ),
                        )),
                    SizedBox(height: height * 0.03),
                    GestureDetector(
                      onTap: () {
                        resetPassword();
                      },
                      child: Container(
                          height: height * 0.1 < 0.1 ? height * 0.6 : 57,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 47, 47),
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: const Text(
                            resetPasswordMail,
                            style: TextStyle(
                                color: GeneralAppColors.whiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Balsamiq Sans"),
                          )),
                    ),
                  ],
                )),
            desktop: Container(
                padding: const EdgeInsets.all(insetSize),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Text(
                        appTitle,
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Text(
                        forgotPasswordTitle,
                      ),
                      Text(
                        forgotPasswordText,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      CustomLoginSignupFormField(
                        height: height * 0.13,
                        theme: Theme.of(context),
                        labelText: emailLabel,
                        controller: emailController,
                        icon: Icons.email,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(30),
                        ),
                        hintText: emailPlaceholder,
                        maxWidth: 640,
                        isPasswordField: false,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              backTxt,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: GeneralAppColors.mainColor),
                            ),
                          )),
                      SizedBox(
                        width: 640,
                        height: height * 0.1 < 0.1 ? height * 0.1 : 50,
                        child: ElevatedButton(
                          onPressed: () {
                            resetPassword();
                          },
                          child: const Text(resetPasswordMail),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    String email = emailController.text.trim();
    bool isValid = EmailValidator.validate(emailController.text.trim());

    if (email.isEmpty) {
      Get.snackbar("Email is empty", "Please enter your email ID",
          snackPosition: SnackPosition.BOTTOM);
    } else if (!isValid) {
      Get.snackbar("Invalid Email", "Please enter a valid email ID",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      AuthenticationService authService = AuthenticationService();
      authService.resetPassword(email: email);
    }
  }
}

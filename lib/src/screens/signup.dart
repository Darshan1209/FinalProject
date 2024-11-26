import 'dart:typed_data';
import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/constants/sizes.dart';
import 'package:apt3065/src/constants/txt.dart';
import 'package:apt3065/src/screens/login.dart';
import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:apt3065/src/utils/image_picker.dart';
import 'package:apt3065/src/utils/responsive_helper.dart';
import 'package:apt3065/src/widgets/custom_dropdown_field.dart';
import 'package:apt3065/src/widgets/custom_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Uint8List? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  late String eduLevel;
  String _selectedClass = 'Class 9'; // Variable to store selected class
  List<String> _classList = [
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
    'Diploma',
    'University',
    'Instructor'
  ]; // List of available classes

  bool isLoading = false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    bool isValid = EmailValidator.validate(emailController.text.trim());

    String name = nameController.text.trim();
    String phoneNum = phoneNumController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confPassword = confPasswordController.text.trim();
    String eduLevel1 = eduLevel;
    print(eduLevel);
    try {
      if (_image == null) {
        Get.snackbar("No profile picture selected",
            "Please upload a profile picture to finish signup",
            snackPosition: SnackPosition.BOTTOM);
      } else if (name.isEmpty) {
        Get.snackbar("Name is empty", "Please enter name",
            snackPosition: SnackPosition.BOTTOM);
      } else if (phoneNum.isEmpty) {
        Get.snackbar("Phone Number is empty", "Please enter phone number",
            snackPosition: SnackPosition.BOTTOM);
      } else if (phoneNum.length != 12 && phoneNum.length != 11) {
        Get.snackbar(
            "Invalid Phone Number", "Please check and re-enter phone number",
            snackPosition: SnackPosition.BOTTOM);
      } else if (email.isEmpty) {
        Get.snackbar("Email is empty", "Please enter email ID",
            snackPosition: SnackPosition.BOTTOM);
      } else if (!isValid) {
        Get.snackbar("Invalid Email", "Please enter a valid email ID",
            snackPosition: SnackPosition.BOTTOM);
      } else if (password.isEmpty) {
        Get.snackbar("Password is empty", "Please enter your password",
            snackPosition: SnackPosition.BOTTOM);
      } else if (password.length < 6) {
        Get.snackbar(
            "Password too short", "Please password longer than 6 characters",
            snackPosition: SnackPosition.BOTTOM);
      } else if (confPassword.isEmpty) {
        Get.snackbar(
            "Confirm Password is empty", "Please confirm your password",
            snackPosition: SnackPosition.BOTTOM);
      } else if (confPassword != password) {
        Get.snackbar("Passwords do not match",
            "Your password and confirm password do not match. Please check and re-enter the password.",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        await AuthenticationService().signUpUser(
            name: name,
            phoneNum: phoneNum,
            email: email,
            password: password,
            confPassword: confPassword,
            file: _image!,
            eduLevel: eduLevel1);
      }
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveWidget(
            mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: insetSize, right: insetSize, top: insetSize),
                    child: Column(
                      children: [
                        Image.asset("assets/images/logo.png",
                            width: 120, height: 120),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        const Text(
                          signUpTxt,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: "QuickSand",
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundColor:
                                        LightAppColors.placeholderColor,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundColor:
                                        LightAppColors.placeholderColor,
                                    backgroundImage: AssetImage(
                                        'assets/images/profile_icon.png'),
                                  ),
                            Positioned(
                              bottom: -10,
                              left: 82,
                              child: IconButton(
                                iconSize: 40,
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_a_photo),
                                color: LightAppColors.priFontColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          maxWidth: width,
                          theme: Theme.of(context),
                          labelText: nameLabel,
                          controller: nameController,
                          icon: Iconsax.user,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                            bottom: Radius.circular(10),
                          ),
                          hintText: namePlaceholder,
                          isPasswordField: false, // Provide the hint text here
                        ),
                        SizedBox(height: height * 0.005),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          maxWidth: width,
                          theme: Theme.of(context),
                          labelText: phoneNumberLabel,
                          controller: phoneNumController,
                          icon: Iconsax.call,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10),
                          ),
                          hintText: phoneNumberPlaceholder,
                          isPasswordField: false,
                        ),
                        SizedBox(height: height * 0.005),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          theme: Theme.of(context),
                          labelText: emailLabel,
                          controller: emailController,
                          icon: Iconsax.sms,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10),
                          ),
                          hintText: emailPlaceholder,
                          maxWidth: width,
                          isPasswordField: false,
                        ),
                        SizedBox(height: height * 0.005),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          theme: Theme.of(context),
                          labelText: passwordLabel,
                          controller: passwordController,
                          icon: Icons.password,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10),
                          ),
                          hintText: passwordPlaceholder,
                          maxWidth: width,
                          isPasswordField: true,
                        ),
                        SizedBox(height: height * 0.005),
                        CustomLoginSignupFormField(
                          height: height * 0.13,
                          theme: Theme.of(context),
                          labelText: confPasswordLabel,
                          controller: confPasswordController,
                          icon: Icons.password,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10),
                          ),
                          hintText: confPasswordPlaceholder,
                          maxWidth: width,
                          isPasswordField: true,
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        CustomDropdownFormField(
                          height: height * 0.13,
                          maxWidth: width,
                          labelText: 'Level of Education',
                          value: _selectedClass,
                          items: _classList,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedClass = newValue!;
                              eduLevel = newValue;
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            signUp();
                          },
                          child: Container(
                              width: width * 0.45,
                              height: height * 0.1 < 0.1 ? height * 0.6 : 57,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 47, 47),
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: const Text(
                                signupBtn,
                                style: TextStyle(
                                    color: GeneralAppColors.whiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Balsamiq Sans"),
                              )),
                        ),
                        SizedBox(height: height * 0.035),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already a Member? ",
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
                                            builder: (context) => LoginPage()));
                                  },
                                  child: const Text(
                                    "Log in",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Balsamiq Sans",
                                        fontWeight: FontWeight.w800,
                                        color:
                                            GeneralAppColors.callToActionColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
            desktop: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(insetSize),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            appTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            signUpTxt,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            signUpSubHeading,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundColor:
                                          LightAppColors.placeholderColor,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : const CircleAvatar(
                                      radius: 64,
                                      backgroundColor:
                                          LightAppColors.placeholderColor,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile_icon.png'),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 90,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                  color: LightAppColors.priFontColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          CustomLoginSignupFormField(
                            height: height * 0.13,
                            maxWidth: 640,
                            theme: Theme.of(context),
                            labelText: nameLabel,
                            controller: nameController,
                            icon: Icons.person,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                              bottom: Radius.circular(10),
                            ),
                            hintText: namePlaceholder,
                            isPasswordField:
                                false, // Provide the hint text here
                          ),
                          SizedBox(height: height * 0.005),
                          CustomLoginSignupFormField(
                            height: height * 0.13,
                            maxWidth: 640,
                            theme: Theme.of(context),
                            labelText: phoneNumberLabel,
                            controller: phoneNumController,
                            icon: Icons.phone,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10),
                            ),
                            hintText: phoneNumberPlaceholder,
                            isPasswordField: false,
                          ),
                          SizedBox(height: height * 0.005),
                          CustomLoginSignupFormField(
                            height: height * 0.13,
                            theme: Theme.of(context),
                            labelText: emailLabel,
                            controller: emailController,
                            icon: Icons.email,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10),
                            ),
                            hintText: emailPlaceholder,
                            maxWidth: 640,
                            isPasswordField: false,
                          ),
                          SizedBox(height: height * 0.005),
                          CustomLoginSignupFormField(
                            height: height * 0.13,
                            theme: Theme.of(context),
                            labelText: passwordLabel,
                            controller: passwordController,
                            icon: Icons.password,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10),
                            ),
                            hintText: passwordPlaceholder,
                            maxWidth: 640,
                            isPasswordField: true,
                          ),
                          SizedBox(height: height * 0.005),
                          CustomLoginSignupFormField(
                            height: height * 0.13,
                            theme: Theme.of(context),
                            labelText: confPasswordLabel,
                            controller: confPasswordController,
                            icon: Icons.password,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10),
                            ),
                            hintText: confPasswordPlaceholder,
                            maxWidth: 640,
                            isPasswordField: true,
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          DropdownButtonFormField(
                            itemHeight: height * 0.13,
                            value: _selectedClass,
                            items: _classList.map((String classItem) {
                              return DropdownMenuItem(
                                value: classItem,
                                child: Text(classItem),
                              );
                            }).toList(),
                            onChanged: (newValue) {},
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            width: 640,
                            height: height * 0.1 < 0.1 ? height * 0.1 : 50,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : signUp,
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(signupBtn),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

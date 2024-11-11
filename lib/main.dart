import 'package:apt3065/firebase_options.dart';
import 'package:apt3065/gemini.dart';
import 'package:apt3065/src/screens/auth_page.dart';
import 'package:apt3065/src/screens/forgot_password.dart';
import 'package:apt3065/src/screens/home_page.dart';
import 'package:apt3065/src/screens/login.dart';
import 'package:apt3065/src/screens/physicsexperimentList.dart';
import 'package:apt3065/src/screens/signup.dart';
import 'package:apt3065/src/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

Future<void> main() async {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return GetMaterialApp.router(
    //   routeInformationParser: router.routeInformationParser,
    //   routerDelegate: router.routerDelegate,
    //   routeInformationProvider: router.routeInformationProvider,
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const AuthPage()),
        GetPage(name: '/BottomNavigation', page: () => BottomNavigation()),
        GetPage(name: '/LoginPage', page: () => LoginPage()),
        GetPage(name: '/SignUpPage', page: () => const SignUpPage()),
        GetPage(
            name: '/ForgotPassword', page: () => const ForgotPasswordPage()),
        GetPage(
            name: '/PhysicsExperimentsList()',
            page: () => const PhysicsExperimentsList()),
        GetPage(
            name: '/HomePage',
            page: () => const HomePage(),
            middlewares: [RouteGuard()]),
      ],
    );
  }
}

class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is not authenticated, allow the original route
      return null;
    } else {
      // User is authenticated, redirect to login
      return null;
    }
  }
}

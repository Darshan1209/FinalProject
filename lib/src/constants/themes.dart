import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.light;

//   bool get isDarkMode => themeMode == ThemeMode.dark;

//   void toggleTheme(bool isOn) {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }

final themesProvider = StateNotifierProvider<ThemesProvider, ThemeMode?>((_) {
  return ThemesProvider();
});

class ThemesProvider extends StateNotifier<ThemeMode?> {
  ThemesProvider() : super(ThemeMode.system);
  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Product Sans",
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 255, 0, 0),
      secondary: LightAppColors.priFontColor,
      tertiary: LightAppColors.secFontColor,
      background: LightAppColors.backgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonTheme.lightElevatedButtonTheme,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Oleo',
        fontSize: 30,
        color: LightAppColors.priFontColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: LightAppColors.priFontColor,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: LightAppColors.priFontColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: LightAppColors.secFontColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 12,
        color: LightAppColors.placeholderColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 24,
        color: LightAppColors.priFontColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 32,
        color: LightAppColors.priFontColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 10,
        color: LightAppColors.priFontColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 14,
        color: LightAppColors.priFontColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 24,
        color: LightAppColors.priFontColor,
      ),
    ),
  );

  // static final darkTheme = ThemeData(
  //   useMaterial3: true,
  //   fontFamily: "Product Sans",
  //   brightness: Brightness.dark,
  //   colorScheme: ColorScheme.dark(
  //     primary: GeneralAppColors.mainColor,
  //     secondary: DarkAppColors.priFontColor,
  //     tertiary: DarkAppColors.secFontColor,
  //     background: DarkAppColors.backgroundColor,
  //   ),
  //   elevatedButtonTheme: ElevatedButtonTheme.darkElevatedButtonTheme,
  //   textTheme: TextTheme(
  //     titleLarge: const TextStyle(
  //       fontFamily: 'Oleo',
  //       fontSize: 30,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     titleMedium: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 40,
  //       fontWeight: FontWeight.bold,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     titleSmall: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 20,
  //       fontWeight: FontWeight.bold,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     headlineSmall: TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //       color: DarkAppColors.secFontColor,
  //     ),
  //     displaySmall: TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 12,
  //       color: DarkAppColors.placeholderColor,
  //     ),
  //     headlineMedium: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 24,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     headlineLarge: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 32,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     bodySmall: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 10,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     bodyMedium: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 14,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //     bodyLarge: const TextStyle(
  //       fontFamily: 'Product Sans',
  //       fontSize: 24,
  //       color: DarkAppColors.priFontColor,
  //     ),
  //   ),
  // );
}

class OutlinedButtonTheme {
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );
}

class ElevatedButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )));

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          )));
}

import 'package:apt3065/src/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:apt3065/src/constants/colors.dart';
import 'package:apt3065/src/screens/labs_page.dart';
import 'package:apt3065/src/screens/home_page.dart';
import 'package:apt3065/src/screens/testspage.dart';
import 'package:apt3065/src/screens/profilepage.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigation extends ConsumerWidget {
  final List<Widget> pages = [
    const HomePage(),
    const LabsPage(),
    const TestsPage(),
    ProfilePage(userId: FirebaseAuth.instance.currentUser!.uid),
  ];

  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final ThemeData theme = Theme.of(context);
    final pureoppositetotheme = theme.brightness == Brightness.light
        ? GeneralAppColors.blackColor
        : GeneralAppColors.whiteColor;
    final pureactualtotheme = theme.brightness == Brightness.dark
        ? GeneralAppColors.blackColor
        : GeneralAppColors.whiteColor;
    Color tabbgcolor = GeneralAppColors.whiteColor;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: pages[selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: GeneralAppColors.mainColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: tabbgcolor == GeneralAppColors.callToActionColor
                  ? GeneralAppColors.whiteColor
                  : GeneralAppColors.blackColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: tabbgcolor,
              color: pureactualtotheme,
              tabs: [
                GButton(
                  icon: Iconsax.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Iconsax.rulerpen,
                  text: 'Labs',
                ),
                GButton(
                  icon: Iconsax.note_21,
                  text: 'Quizzes',
                ),
                GButton(
                  icon: Iconsax.user,
                  text: 'Profile',
                ),
              ],
              onTabChange: (newIndex) {
                ref.read(selectedIndexProvider.notifier).state = newIndex;
              },
              selectedIndex: selectedIndex,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatPage()));
        },
        child: Icon(Iconsax.message),
        backgroundColor: GeneralAppColors.whiteColor,
      ),
    );
  }
}

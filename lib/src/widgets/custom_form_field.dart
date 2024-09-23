import 'package:apt3065/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomLoginSignupFormField extends StatefulWidget {
  final double height;
  final double maxWidth;
  final ThemeData theme;
  final String labelText;
  final TextEditingController controller;
  final IconData icon;
  final BorderRadius borderRadius;
  final String hintText;
  final bool isPasswordField;

  const CustomLoginSignupFormField(
      {Key? key,
      required this.height,
      required this.maxWidth,
      required this.theme,
      required this.labelText,
      required this.controller,
      required this.icon,
      required this.borderRadius,
      required this.hintText,
      required this.isPasswordField})
      : super(key: key);

  @override
  State<CustomLoginSignupFormField> createState() =>
      _CustomLoginSignupFormFieldState();
}

class _CustomLoginSignupFormFieldState
    extends State<CustomLoginSignupFormField> {
  bool _isPassObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height < 100 ? 100 : widget.height,
      width: widget.maxWidth,
      decoration: BoxDecoration(
        color: LightAppColors.textBoxColor,
        borderRadius: widget.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 30.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.labelText,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Balsamiq Sans"),
                  ),
                ],
              ),
            ),
            TextField(
              cursorColor: GeneralAppColors.callToActionColor,
              obscureText: widget.isPasswordField ? _isPassObscured : false,
              controller: widget.controller,
              style: TextStyle(
                letterSpacing: widget.isPasswordField
                    ? widget.controller.text.isEmpty
                        ? 5
                        : null
                    : null,
                fontFamily: "Balsamiq Sans",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: widget.isPasswordField
                    ? IconButton(
                        color: GeneralAppColors.blackColor,
                        iconSize: 27,
                        visualDensity: VisualDensity.compact,
                        icon: _isPassObscured
                            ? const Icon(Iconsax.unlock)
                            : const Icon(Iconsax.lock),
                        onPressed: () {
                          setState(() {
                            _isPassObscured = !_isPassObscured;
                          });
                        },
                      )
                    : Icon(
                        widget.icon,
                        color: GeneralAppColors.blackColor,
                        weight: 20,
                        size: 27,
                      ),
                hintText: widget.hintText,
                labelStyle: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Product Sans",
                  fontWeight: FontWeight.w900,
                  color: LightAppColors.priFontColor,
                ),
                hintStyle: widget.isPasswordField
                    ? TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      )
                    : null,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

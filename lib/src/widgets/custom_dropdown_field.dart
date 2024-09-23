import 'package:apt3065/src/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final double height;
  final double maxWidth;
  final String labelText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownFormField({
    Key? key,
    required this.height,
    required this.maxWidth,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height < 100 ? 100 : widget.height,
      width: widget.maxWidth,
      decoration: BoxDecoration(
        color: LightAppColors.textBoxColor,
        borderRadius: BorderRadius.circular(10),
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
                      fontFamily: "Balsamiq Sans",
                    ),
                  ),
                ],
              ),
            ),
            DropdownButtonFormField<String>(
              itemHeight: widget.height,
              hint: Text("Class ..."),
              items: widget.items.map((String classItem) {
                return DropdownMenuItem(
                  value: classItem,
                  child: Text(classItem),
                );
              }).toList(),
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_todo/theme/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          label,
          style: buttonStyle,
        )),
      ),
    );
  }
}

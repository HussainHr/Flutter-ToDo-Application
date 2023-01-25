import 'package:flutter/material.dart';
import 'package:flutter_todo_todo/theme/theme.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  final String title, hinText;
  final TextEditingController? controller;
  final Widget? widget;
  const MyTextField(
      {super.key,
      required this.title,
      required this.hinText,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // const SizedBox(
          //   height: 6,
          // ),
          Container(
            height: 52,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 8, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey,
                    controller: controller,
                    style: textFormnStyle,
                    decoration: InputDecoration(
                      hintStyle: textFormnStyle,
                      hintText: hinText,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: context.theme.backgroundColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

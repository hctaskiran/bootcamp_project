import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const CustomTextBox({super.key, required this.text, required this.sectionName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                    color: customColors().grey600color,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),

              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  color: customColors().grey500color,
                ),
              ),
            ],
          ),
          Text(text)
        ],
      ),
    );
  }
}

class customColors {
  final grey200color = Colors.grey.shade200;
  final grey500color = Colors.grey.shade500;
  final grey600color = Colors.grey.shade600;
}

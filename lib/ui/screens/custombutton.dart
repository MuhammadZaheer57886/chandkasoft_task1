import 'package:cs_task1/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
          color: AppColors.i.primaryColor,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color.fromARGB(223, 242, 248, 247) : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

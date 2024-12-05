import 'package:esight_app/utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final double opacity;
  final double width;
  final double height;
  final List<Color> gradientColors;
  final TextStyle textStyle;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 0.9,
    this.opacity = 1.0,
    this.height = 40,
    this.gradientColors = const [Pallete.buttoncolor1, Pallete.buttoncolor2],
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    CircularProgressIndicator? child,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}

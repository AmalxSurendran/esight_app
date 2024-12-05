import 'package:animate_do/animate_do.dart';
import 'package:esight_app/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> words = [
      'Dedication',
      'Perseverance',
      'Ambition',
      'Passion',
      'Discipline',
      'Achievement',
      'Focus',
      'Resilience',
      'Determination',
      'Motivation',
      'Success',
    ];

    return Scaffold(
      backgroundColor: Pallete.buttoncolor1,
      body: Stack(
        children: [
          // The scrollable content
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display words with animation
                  ...words
                      .asMap()
                      .entries
                      .map(
                        (entry) => BounceInLeft(
                          delay: Duration(milliseconds: entry.key * 200),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              entry.value,
                              style: GoogleFonts.nunitoSans(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32, // Uniform font size
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: FadeInUp(
                        duration: const Duration(seconds: 3),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallete.textcolor),
                            borderRadius:
                                BorderRadius.circular(20), // 20px radius
                          ),
                          child: Center(
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.nunitoSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Font size for "Get Started"
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

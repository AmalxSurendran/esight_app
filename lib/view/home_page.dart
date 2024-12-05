import 'package:esight_app/utilities/colors.dart';
import 'package:esight_app/utilities/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double totalBill = 0.0;
  int selectedPercentage = 0;
  double tips = 0.0;
  double totalAmountToPay = 0.0;

  @override
  void initState() {
    super.initState();

    // Add listener to update the UI dynamically when the bill amount changes
    amountController.addListener(() {
      setState(() {
        totalBill = double.tryParse(amountController.text) ?? 0.0;
        calculateAmounts();
      });
    });
  }

  void calculateAmounts() {
    tips = totalBill * selectedPercentage / 100;
    totalAmountToPay = totalBill + tips;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 23, right: 23),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Image.asset(
                        width: 200,
                        height: 200,
                        'assets/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: GoogleFonts.nunitoSans(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        Text(
                          'Celestia',
                          style: GoogleFonts.nunitoSans(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.tune,
                      size: 26,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.82,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              'Total Bill Amount',
                              style: GoogleFonts.nunitoSans(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixText: '₹ ',
                                prefixStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                hintText: 'Enter the Total bill amount.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        duration: const Duration(milliseconds: 700),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(253, 229, 182, 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  'Your tips can make a big difference in lives',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [15, 20, 25, 50].map((percent) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedPercentage = percent;
                                            calculateAmounts();
                                          });
                                        },
                                        child: _buildTipContainer(
                                          '$percent%',
                                          isSelected:
                                              selectedPercentage == percent,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 50),
                            Text(
                              'Total bill amount: ₹${totalBill.toStringAsFixed(2)}',
                              style: GoogleFonts.nunitoSans(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Text(
                              'Tips you added: ₹${tips.toStringAsFixed(2)}',
                              style: GoogleFonts.nunitoSans(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Text(
                              'Total amount to pay: ₹${totalAmountToPay.toStringAsFixed(2)}',
                              style: GoogleFonts.nunitoSans(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 20),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(253, 229, 182, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Pay your total bill by just one click.',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 150,
                                child: CustomGradientButton(
                                  text: totalAmountToPay == 0.0
                                      ? "Pay"
                                      : "₹${totalAmountToPay.toStringAsFixed(2)}",
                                  onPressed: () {
                                    _showSuccessAnimationDialog(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipContainer(String amount, {bool isSelected = false}) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          amount,
          style: GoogleFonts.nunitoSans(
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
          ),
        ),
      ),
    );
  }

  void _showSuccessAnimationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Pallete.backgroundColor,
          child: SizedBox(
            width: 344, // Width of the dialog
            height: 459, // Height of the dialog
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Lottie animation
                  Lottie.asset(
                    'assets/success_Animation.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Payment Completed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Thanks for using our application',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    width: 153,
                    child: CustomGradientButton(
                      text: 'Done',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/'); // Use regular navigation here
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

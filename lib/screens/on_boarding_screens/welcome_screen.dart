import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyage/providers/auth_provider.dart';
import 'package:voyage/screens/on_boarding_screens/on_boarding_screens.dart';
import 'package:voyage/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {

  static const String routeName = "welcome-screen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    void showBottomSheet(BuildContext context) {

      final TextEditingController phoneNumberController = TextEditingController();
      bool validPhoneNumber = false;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(builder: (
          context,
          StateSetter setSheet,
        ) {
          final authProvider =
              Provider.of<AuthProvider>(context);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authProvider.error != null
                      ? Container(
                          color: Colors.yellow,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    authProvider.error!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context, listen: false).clearError();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    "Enter your phone number to proceed",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  height30,
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(right: 8.0, bottom: 24.0),
                              child: Text(
                                "+91",
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  helperText: '10 digit mobile number',
                                  hintText: 'Enter mobile number',
                                  isDense: true,
                                  counterText: '',
                                ),
                                controller: phoneNumberController,
                                maxLength: 10,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  if (value.isNotEmpty &&
                                      value.trim().length == 10) {
                                    setSheet(() {
                                      validPhoneNumber = true;
                                    });
                                  } else {
                                    setSheet(() {
                                      validPhoneNumber = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        height10,
                        AbsorbPointer(
                          absorbing: validPhoneNumber ? false : true,
                          child: TextButton(
                            onPressed: () {
                              String number =
                                  '+91${phoneNumberController.text}';
                              auth.verifyPhone(context, number).then((value) {
                                setSheet((){
                                  phoneNumberController.clear();
                                  validPhoneNumber = false;
                                });
                                // phoneNumberController.clear();
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: validPhoneNumber
                                  ? AppColors.charcoal
                                  : Colors.grey,
                            ),
                            child: Text(
                              validPhoneNumber
                                  ? "CONTINUE"
                                  : "Enter mobile number",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Expanded(
              child: OnBoardingScreens(),
            ),
            const Text("Ready to order from your nearest shop?"),
            height10,
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppColors.charcoal.withOpacity(0.9),
              ),
              child: const Text('Set Delivery Location'),
            ),
            height20,
            RichText(
              text: TextSpan(
                text: "Already a customer? ",
                style: const TextStyle(color: Colors.blueGrey),
                children: [
                  TextSpan(
                    text: 'Login',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showBottomSheet(context);
                      },
                    style: const TextStyle(
                      color: AppColors.charcoal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

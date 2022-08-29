import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voyage/screens/home_screen.dart';
import 'package:voyage/services/user_services.dart';
import 'package:voyage/utils/constants.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();
  String? smsOTP;
  String? verificationID;

  String? error;

  Future<void> verifyPhone(BuildContext context, String number) async {
    void verificationCompleted(PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    }

    void verificationFailed(FirebaseAuthException e) {
      print(e.code);
    }

    void smsOtpSent(String verID, int? resendToken) {
      verificationID = verID;

      smsOtpDialog(context, number);
    }

    try {
      _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSent,
        codeAutoRetrievalTimeout: (String verId){
          verificationID = verId;
        },
      );
    } catch (e) {}
  }

  Future smsOtpDialog(BuildContext context, String number) async {

    void afterSignIn(){
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: const [
                Text('Verification code'),
                height10,
                Text("Enter 6 digit OTP received as SMS"),
              ],
            ),
            content: SizedBox(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  smsOTP = value;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (verificationID != null &&
                        smsOTP != null &&
                        verificationID!.trim().isNotEmpty &&
                        smsOTP!.trim().isNotEmpty) {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationID!,
                              smsCode: smsOTP!);
                      final User? user = (await _auth
                              .signInWithCredential(phoneAuthCredential))
                          .user;
                      if (user != null) {
                        _createUser(user.uid, user.phoneNumber!);
                        afterSignIn();
                      } else {
                        print("Login Failed");
                      }
                    }
                  } catch (e) {
                    error = 'Invalid OTP';
                    notifyListeners();
                    print(e.toString());
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("DONE"),
              ),
            ],
          );
        });
  }

  void _createUser(String id, String number){
    _userServices.createUser({
      'id': id,
      'number': number
    });
  }

  void clearError(){
    error = null;
    notifyListeners();
  }
}

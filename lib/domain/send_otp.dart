// otp_use_case.dart

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class OTPUseCase {
  final FirebaseAuth _auth;

  OTPUseCase(this._auth);

  // Method to send OTP to phone number
  Future<String?> sendOTP(String phoneNumber) async {
    final completer = Completer<String?>();

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        completer.complete(null); // Complete successfully
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.completeError(e.message ?? "Error occurred");
      },
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(verificationId); // Return verificationId to the UI
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        completer.complete(verificationId);
      },
    );

    return completer.future;
  }

  // Method to verify OTP
  Future<User?> verifyOTP(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception("Invalid OTP");
    }
  }
}

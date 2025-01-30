// firebase_auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_auth_clean_arch/domain/send_otp.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository(this._auth);

  // Method to send OTP
  Future<String?> sendOTP(String phoneNumber) async {
    return await OTPUseCase(_auth).sendOTP(phoneNumber);
  }

  // Method to verify OTP
  Future<User?> verifyOTP(String verificationId, String otp) async {
    return await OTPUseCase(_auth).verifyOTP(verificationId, otp);
  }
}

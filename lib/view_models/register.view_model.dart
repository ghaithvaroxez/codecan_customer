import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/widgets/bottomsheets/account_verification_entry.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/validator.i18n.dart';

class RegisterViewModel extends MyBaseViewModel {
  //
  AuthRequest _authRequest = AuthRequest();
  // FirebaseAuth auth = FirebaseAuth.instance;
  //the textediting controllers
  TextEditingController nameTEC =
      new TextEditingController(text: !kReleaseMode ? "John Doe" : "");
  TextEditingController emailTEC =
      new TextEditingController(text: !kReleaseMode ? "john@mail.com" : "");
  TextEditingController phoneTEC =
      new TextEditingController(text: !kReleaseMode ? "+233557484181" : "");
  TextEditingController passwordTEC =
      new TextEditingController(text: !kReleaseMode ? "password" : "");

  RegisterViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void processRegister() async {
    //
    setBusy(true);
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //
      if (AppStrings.enableOtp) {
        //firebase authentication
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneTEC.text,
          verificationCompleted: (PhoneAuthCredential credential) {
            // firebaseVerificationId = credential.verificationId;
            // verifyFirebaseOTP(credential.smsCode);
            finishAccountRegistration();
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              viewContext.showToast(
                  msg: "Invalid Phone Number".i18n, bgColor: Colors.red);
            } else {
              viewContext.showToast(msg: e.message, bgColor: Colors.red);
            }
            //
            setBusy(false);
          },
          codeSent: (String verificationId, int resendToken) async {
            firebaseVerificationId = verificationId;
            showVerificationEntry();
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print("codeAutoRetrievalTimeout called");
          },
        );
      } else {
        finishAccountRegistration();
      }
    }
  }

  //
  void showVerificationEntry() {
    //
    setBusy(false);
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return AccountVerificationEntry(
          vm: this,
          onSubmit: (smsCode) {
            //
            verifyFirebaseOTP(smsCode);
            viewContext.pop();
          },
        );
      },
    );
  }

  //
  void verifyFirebaseOTP(String smsCode) async {
    //
    setBusyForObject(firebaseVerificationId, true);

    // Sign the user in (or link) with the credential
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      finishAccountRegistration();
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(firebaseVerificationId, false);
  }

  void finishAccountRegistration() async {
    setBusy(true);

    final apiResponse = await _authRequest.registerRequest(
      name: nameTEC.text,
      email: emailTEC.text,
      phone: phoneTEC.text,
      password: passwordTEC.text,
    );

    setBusy(false);

    if (apiResponse.hasError()) {
      //there was an error
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Registration Failed".i18n,
        text: apiResponse.message,
      );
    } else {
      //everything works well
      await AuthServices.saveUser(apiResponse.body["user"]);
      await AuthServices.setAuthBearerToken(apiResponse.body["token"]);
      await AuthServices.isAuthenticated();
      viewContext.navigator.pushNamedAndRemoveUntil(
        AppRoutes.homeRoute,
        (_) => false,
      );
    }
  }

  void openLogin() async {
    viewContext.pop();
  }

  verifyRegistrationOTP(String text) {}
}

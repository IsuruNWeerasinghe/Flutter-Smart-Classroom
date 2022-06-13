import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:littleclassroom/common_data/app_colors.dart';
import 'package:littleclassroom/common_data/app_strings.dart';
import 'package:littleclassroom/common_widgets/loading_widget.dart';
import 'package:littleclassroom/common_widgets/show_otp_dialog.dart';
import 'package:littleclassroom/common_widgets/show_snackbar.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/services/base_model.dart';
import 'package:littleclassroom/services/enum.dart';

class AuthModel extends BaseModel {
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late StreamSubscription<User?> user;

  ///Check user login status
  void userStateCheck(){
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  ///Register new user
  Future<void> createNewUser({required String email, required String password, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try{
      //const LoadingWidget();
      setViewState(ViewState.Busy);
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      setViewState(ViewState.Ideal);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login_page, (Route<dynamic> route) => false);

    }on FirebaseAuthException catch(e){
      print('Error : ' + e.message!);
      showSnackBar(
          context: context,
          text: e.message.toString()
      );
    } catch (e) {
      print('Error : ' + e.toString()); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.toString()
      );
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///log in using email & password
  Future<void> logIn({required String email, required String password, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try{
      setViewState(ViewState.Busy);
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      setViewState(ViewState.Ideal);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home_page, (Route<dynamic> route) => false);

    }on FirebaseAuthException catch(e){
      print('Error : ' + e.message!);
      showSnackBar(
          context: context,
          text: e.message.toString()
      );
    } catch (e) {
      print('Error : ' + e.toString()); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.toString()
      );
    }finally {
      isLoading = false;
      notifyListeners();
    }

  }

  ///log in using google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await firebaseAuth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
          print('userCredential : ' + userCredential.user.toString());
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.home_page, (Route<dynamic> route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Error : ' + e.message!); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.message.toString()
      );
    } catch (e) {
      print('Error : ' + e.toString()); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.toString()
      );
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///log in using facebook
  Future<void> signInWithFacebook({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await firebaseAuth.signInWithCredential(facebookAuthCredential);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home_page, (Route<dynamic> route) => false);

    } on FirebaseAuthException catch (e) {
      print('Error : ' + e.message!); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.message.toString()
      );
    } catch (e) {
      print('Error : ' + e.toString()); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.toString()
      );
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///log in using phone
  Future<void> signInWithPhone({required BuildContext context}) async {
    TextEditingController codeController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController(text: "+94");
    String phoneNumber;

    showOTPDialog(
      codeController: phoneNumberController,
      context: context,
      buttonText: AppStrings.send_otp,
      title: AppStrings.enter_your_phone_number,
      contentText: "",
      maxLength: 12,
      onPressed: () async {
        phoneNumber = phoneNumberController.text;
        Navigator.of(context).pop();

        try{
          if (kIsWeb) {
            // !!! Works only on web !!!
            ConfirmationResult result =
                await firebaseAuth.signInWithPhoneNumber(phoneNumber);
            // Diplay Dialog Box To accept OTP
            showOTPDialog(
              codeController: codeController,
              context: context,
              buttonText: AppStrings.enter_otp,
              title: AppStrings.submit,
              maxLength: 5,
              contentText: AppStrings.please_type_the_6_digit,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: result.verificationId,
                  smsCode: codeController.text.trim(),
                );

                await firebaseAuth.signInWithCredential(credential);
                Navigator.of(context).pop(); // Remove the dialog box
              },
            );
          } else {
            // FOR ANDROID, IOS
            await firebaseAuth.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              //  Automatic handling of the SMS code
              verificationCompleted: (PhoneAuthCredential credential) async {
                // !!! works only on android !!!
                await firebaseAuth.signInWithCredential(credential);
              },
              // Displays a message when verification fails
              verificationFailed: (e) {
                print('Error : ' + e.message!); // Displaying the error message
              },

              /// Displays a dialog box when OTP is sent
              codeSent: ((String verificationId, int? resendToken) async {
                showOTPDialog(
                  codeController: codeController,
                  context: context,
                  buttonText: AppStrings.submit,
                  title: AppStrings.enter_otp,
                  maxLength: 6,
                  contentText: AppStrings.please_type_the_6_digit,
                  onPressed: () async {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: codeController.text.trim(),
                    );

                    // !!! Works only on Android, iOS !!!
                    await firebaseAuth.signInWithCredential(credential);
                    Navigator.of(context).pop(); // Remove the dialog box
                  },
                );
              }),
              codeAutoRetrievalTimeout: (String verificationId) {
                // Auto-resolution timed out...
              },
            );
          }
        } on FirebaseAuthException catch (e) {
          print('Error : ' + e.message!); // Displaying the error message
          showSnackBar(
              context: context,
              text: e.message.toString()
          );
        } catch (e) {
          print('Error : ' + e.toString()); // Displaying the error message
          showSnackBar(
              context: context,
              text: e.toString()
          );
        }finally {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  ///log out
  Future<void> logOut({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      setViewState(ViewState.Busy);
      await firebaseAuth.signOut();
      setViewState(ViewState.Ideal);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login_page, (Route<dynamic> route) => false);

    } on FirebaseAuthException catch (e) {
      print('Error : ' + e.message!);
      showSnackBar(
          context: context,
          text: e.message.toString()
      );
    } catch (e) {
      print('Error : ' + e.toString()); // Displaying the error message
      showSnackBar(
          context: context,
          text: e.toString()
      );
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
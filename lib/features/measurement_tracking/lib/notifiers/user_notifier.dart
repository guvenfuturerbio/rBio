import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../doctor/utils/progress/progress_dialog.dart';
import '../locator.dart';
import '../models/user/usermodel.dart';
import '../services/auth_service/login_view_model.dart';
import 'shared_preferences_handler.dart';

enum ViewState { Idle, Busy }

class UserNotifier with ChangeNotifier {
  ProgressDialog progressDialog;

  static final UserNotifier _instance = UserNotifier._internal();

  factory UserNotifier() {
    return _instance;
  }

  UserNotifier._internal() {
    print("User Notifier is created, current user is: ${auth.currentUser}");
  }

  User _firebaseUser;
  User get firebaseUser => _firebaseUser;
  String errorMessage;

  LoginViewModel model = locator<LoginViewModel>();
  UserModel _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel get user => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future signOut() async {
    await auth.signOut();
    user = null;
    _firebaseUser = null;
    notifyListeners();
  }

  deleteInformationForAutoLogin() async {
    //SharedPreferencesHandler().saveLastLoggedUserUid(null); // Algorithm works by detecting change so never remove uid
    SharedPreferencesHandler().saveLastDisplayName(null);
    SharedPreferencesHandler().saveLastEmail(null);
  }

  bool executingAutoLogin = false;
}

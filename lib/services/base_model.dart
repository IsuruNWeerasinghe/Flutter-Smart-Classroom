import 'package:flutter/material.dart';
import 'package:littleclassroom/services/enum.dart';

class BaseModel extends ChangeNotifier {
  late ViewState _viewState;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  late AuthState _authState;

  AuthState get authState => _authState;

  setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }
}
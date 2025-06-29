import 'package:flutter/foundation.dart';

enum NotifierState {
  initial,
  loading,
  loaded,
  error,
}

class BaseAppNotifier with ChangeNotifier {
  NotifierState _state=NotifierState.initial;
  NotifierState get state=>_state;
  set state(NotifierState state){
    _state=state;
    notifyListeners();
  }
  String? _errorMessage;

  String? get errorMessage => _errorMessage;


  void setState(NotifierState notifierState, {String? errorMessage}) {
    state =notifierState;
    _errorMessage = errorMessage;
    if (kDebugMode) {
      print('[${this.runtimeType}] → State changed to: $state');
      if (errorMessage != null) {
        print('Error Message: $errorMessage');
      }
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

extension MDExtensionState on State {
  void endEditing(){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double dynammicWidth(double val) => MediaQuery.of(this).size.width * val;

  double dynammicHeight(double val) => MediaQuery.of(this).size.height * val;
}

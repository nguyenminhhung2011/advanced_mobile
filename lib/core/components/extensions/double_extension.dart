import 'package:intl/intl.dart';

extension DoubleExtension on double {
  toCurrency() {
    return NumberFormat.simpleCurrency(name: 'VND', decimalDigits: 2).format(this);
  }  
}
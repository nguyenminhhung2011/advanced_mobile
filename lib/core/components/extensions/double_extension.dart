import 'package:intl/intl.dart';

extension DoubleExtenstion on double {
  toCurrency() {
    return NumberFormat.simpleCurrency(name: 'VND', decimalDigits: 2).format(this);
  }  
}
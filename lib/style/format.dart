import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.currency(
    locale: 'lo',
    customPattern: '#,###.# \u00a4 ',
    // decimalDigits: 2,
    symbol: "ກີບ");
final moneyLaoKip = NumberFormat.currency(
    locale: 'lo',
    customPattern: '#,###.# \u00a4 ',
    // decimalDigits: 2,
    symbol: "₭");
final moneyLaoKipNo = NumberFormat.currency(
    locale: 'lo',
    customPattern: '#,###.#',
    // decimalDigits: 2,
    symbol: "Kip");

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter =
    NumberFormat.currency(locale: 'lo', customPattern: '#,###');

    String newText = formatter.format(value / 1);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
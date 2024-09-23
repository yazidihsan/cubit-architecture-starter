import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ValueManager {
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static int secondInMinute = 60;

  static void customToast(String message, {Color? backgroundColor}) =>
      Fluttertoast.cancel().then((value) async => await Fluttertoast.showToast(
          msg: message, toastLength: Toast.LENGTH_LONG));

  static String convertDate(DateTime? date) {
    if (date == null) {
      return '-';
    }

    return DateFormat('dd-MM-y HH:mm:ss').format(date);
  }

  static String convertDateBirth(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('dd-MM-y').format(date);
  }

  static String convertDateBirthUpdate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('y-MM-dd').format(date);
  }

  static LinearGradient loadingGradient() => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.4, 0.5, 0.6],
        colors: [
          Colors.grey.withOpacity(0),
          Colors.grey.withOpacity(0.5),
          Colors.grey.withOpacity(0)
        ],
      );

  static String convertTotal(String price) =>
      NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp')
          .format(double.parse(price));

  static String convertDateGate() =>
      DateFormat('y-MM-d HH:mm:ss.S').format(DateTime.now());
}

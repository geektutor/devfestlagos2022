// import 'dart:io';

// import 'package:intl/intl.dart';
// import 'package:dartx/dartx.dart';

// String get ngn => Platform.isIOS ? '₦' : 'N';
// String get kes => 'KES';

// abstract class Validator {
//   static NumberFormat currency(bool isNigeria) => NumberFormat.currency(
//         decimalDigits: 0,
//         symbol: '${isNigeria ? ngn : kes} ',
//       );

//   static NumberFormat get noSymbolCurrency =>
//       NumberFormat.currency(decimalDigits: 0, symbol: '');

//   static bool isEmail(String em) {
//     const p =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     final regExp = RegExp(p);
//     return regExp.hasMatch(em);
//   }

//   static bool hasMin8chars(String em) {
//     final hasMin8chars = em.length >= 8;
//     return hasMin8chars;
//   }

//   static bool containSpecialChars(String em) {
//     final hasSpecialCharacters = RegExp(r'[!@#$%^&*()?":{}|<>]');
//     return hasSpecialCharacters.hasMatch(em);
//   }

//   static bool containsNumber(String em) {
//     final containsNumber = RegExp(r'[0-9]');
//     return containsNumber.hasMatch(em);
//   }

//   static bool containsUpperCase(String value) {
//     final hasUpperCase = RegExp(r'[A-Z]');
//     return value.contains(hasUpperCase);
//   }

//   static bool containsLowerCase(String value) {
//     final hasLowerCase = RegExp(r'[a-z]');

//     return value.contains(hasLowerCase);
//   }

//   static bool validName(String value) {
//     final lowerCase = value.toLowerCase().split('');
//     final charArr = r"±§@£€#$%^&**!()_+=`~,.<>/?;:'|'][{}1234567890".split("");
//     final filter = ['http', '.co', 'www'];

//     if (lowerCase.containsAny(charArr) || lowerCase.containsAny(filter)) {
//       return false;
//     }

//     return true;
//   }

//   static bool phoneNumberCheck(String value, String location) {
//     if (location.contains('ke')) {
//       if ((value.length == 9 && value[0] == "7") ||
//           (value.length == 10 && value.slice(0, 1) == "07")) {
//         return true;
//       }
//       return false;
//     } else if (location.contains('ng')) {
//       if ((value.length == 10 && value[0] != "0") ||
//           (value.length == 11 && value[0] == "0")) {
//         return true;
//       }
//       return false;
//     } else {
//       return false;
//     }
//   }
// }

class Validator {
  static String? validateRequired(String value) {
    if (value.isEmpty) {
      return 'برجاء ملئ هذه الخانة';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return ' رجاء ادخال البريد الالكتروني';
    } else if (!(regex.hasMatch(value))) {
      return "بريد الكتروني غير صالح";
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    String pattern =
        r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'رجاء ادخال كلمة السر';
    } else if (!regex.hasMatch(value)) {
      return 'رجاء ادخال كلمة سر صالحة';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String value, String password) {
    String pattern =
        r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return "برجاء اعاده ادخال كلمة السر";
    } else if (!regex.hasMatch(value)) {
      return 'برجاء ادخال كلمة سر صالحة';
    } else if (value != password) {
      return "يجب ان تكون كلمة السر كالاعلي";
    } else {
      return null;
    }
  }

  static String? validateName(String value, String string) {
    // String pattern = '[a-zA-Z]';
    String pattern = '[a-zA-Z\u0600-\u06FF]+';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return ' رجاء ادخال $string';
    } else if (!regex.hasMatch(value)) {
      return ' ادخل $string';
    } else {
      return null;
    }
  }

  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    } else if (!regExp.hasMatch(value)) {
      return 'رجاء ادخال رقم هاتف صالح';
    }
    return null;
  }
}

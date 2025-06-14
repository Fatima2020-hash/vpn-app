class AppValidators {
  /// ✅ Checks if a field is empty.
  static String? validateRequired(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required.";
    }
    return null;
  }

  /// ✅ Validates an email address.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required.";
    }
// issue
    // Regular expression for validating email
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address.";
    }

    return null;
  }

  String? validateExpirationDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiration date is required';
    }

    // Ensure the format is MM/YY
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return 'Invalid format (MM/YY)';
    }

    // Split into month and year
    final parts = value.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    // Validate month (01–12)
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }

    // Validate year (current year or later)
    final currentYear = DateTime.now().year % 100; // Get last two digits of the year
    if (year == null || year < currentYear) {
      return 'Card has expired';
    }

    return null; // Valid
  }
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required.";
    }

    String cleanedNumber = value.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleanedNumber.length <= 5) {
      return "Enter a valid phone number.";
    }

    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Otp is required.";
    }

    String cleanedNumber = value.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleanedNumber.length < 6) {
      return "Enter a valid Otp.";
    }

    return null;
  }



  /// ✅ Validates a password with length and complexity requirements.
  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required.";
    }

    if (value.length < minLength) {
      return "Password must be at least $minLength characters long.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password, {String? errorMessage}) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage ?? "Confirm password is required.";
    }

    if (value != password) {
      return errorMessage ?? "Passwords do not match.";
    }

    return null;
  }
  /// ✅ Validates text length (custom min/max).
  static String? validateLength(String? value, {int minLength = 3, int maxLength = 50, String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required.";
    }

    if (value.length < minLength) {
      return "$fieldName must be at least $minLength characters long.";
    }

    if (value.length > maxLength) {
      return "$fieldName cannot be more than $maxLength characters long.";
    }

    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Date is required.";
    }

    // Check format: DD/MM/YYYY
    RegExp datePattern = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!datePattern.hasMatch(value)) {
      return "Invalid format (DD/MM/YYYY).";
    }

    List<String> parts = value.split('/');
    int? day = int.tryParse(parts[0]);
    int? month = int.tryParse(parts[1]);
    int? year = int.tryParse(parts[2]);

    if (month == null || month < 1 || month > 12) {
      return "Invalid month (1-12).";
    }

    int currentYear = DateTime.now().year;
    if (year == null || year < 1900) {
      return "Invalid year.";
    }

    int maxDays = DateTime(year, month + 1, 0).day; // Get last day of month
    if (day == null || day < 1 || day > maxDays) {
      return "Invalid day for this month.";
    }

    return null; // ✅ Valid date
  }



}

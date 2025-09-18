import 'package:flutter/material.dart';
import 'ec_ordinary_text_field.dart';
import 'ec_search_text_field.dart';
import 'ec_big_input_text_field.dart';
import '../../app_colors.dart';

/// Validation errors for form inputs
enum EcValidationError { invalid, empty, tooShort, tooLong, invalidFormat }

/// Email input validation class
class EcEmailInput {
  const EcEmailInput.pure([this.value = '']) : isPure = true;
  const EcEmailInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String value) {
    if (value.isEmpty) return EcValidationError.empty;
    return _emailRegex.hasMatch(value) ? null : EcValidationError.invalidFormat;
  }
}

/// Password input validation class
class EcPasswordInput {
  const EcPasswordInput.pure([this.value = '']) : isPure = true;
  const EcPasswordInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  static final _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~^%+=()\-_])[A-Za-z\d!@#\$&*~^%+=()\-_]{8,}$',
  );

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return EcValidationError.empty;
    if (value.length < 8) return EcValidationError.tooShort;
    return _passwordRegExp.hasMatch(value)
        ? null
        : EcValidationError.invalidFormat;
  }
}

/// Name input validation class
class EcNameInput {
  const EcNameInput.pure([this.value = '']) : isPure = true;
  const EcNameInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return EcValidationError.empty;
    if (value.length < 2) return EcValidationError.tooShort;
    return null;
  }
}

/// Phone number input validation class
class EcPhoneInput {
  const EcPhoneInput.pure([this.value = '']) : isPure = true;
  const EcPhoneInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  static final _phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return EcValidationError.empty;
    return _phoneRegex.hasMatch(value) ? null : EcValidationError.invalidFormat;
  }
}

/// Address input validation class
class EcAddressInput {
  const EcAddressInput.pure([this.value = '']) : isPure = true;
  const EcAddressInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return EcValidationError.empty;
    if (value.length < 5) return EcValidationError.tooShort;
    return null;
  }
}

/// Generic text input validation class
class EcTextInput {
  const EcTextInput.pure([this.value = '']) : isPure = true;
  const EcTextInput.dirty([this.value = '']) : isPure = false;

  final String value;
  final bool isPure;

  EcValidationError? get displayError {
    if (isPure) return null;
    return validator(value);
  }

  EcValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return EcValidationError.empty;
    return null;
  }
}

/// Common email input widget using EcTextField
class EcEmailField extends StatelessWidget {
  const EcEmailField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your email',
    this.labelText = 'Email Address',
    this.helperText,
    this.semanticsLabel = 'Email input field',
    this.errorMessage,
    this.textInputAction = TextInputAction.next,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcOrdinaryTextField(
      semanticsLabel: semanticsLabel,
      keyboardType: TextInputType.emailAddress,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      textInputAction: textInputAction,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common password input widget using EcTextField
class EcPasswordField extends StatelessWidget {
  const EcPasswordField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your password',
    this.labelText = 'Password',
    this.helperText,
    this.semanticsLabel = 'Password input field',
    this.errorMessage,
    this.textInputAction = TextInputAction.done,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcOrdinaryTextField(
      semanticsLabel: semanticsLabel,
      obscureText: true,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      textInputAction: textInputAction,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common name input widget using EcOrdinaryTextField
class EcNameField extends StatelessWidget {
  const EcNameField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your name',
    this.labelText = 'Full Name',
    this.helperText,
    this.semanticsLabel = 'Name input field',
    this.errorMessage,
    this.textInputAction = TextInputAction.next,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcOrdinaryTextField(
      semanticsLabel: semanticsLabel,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      textInputAction: textInputAction,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common phone input widget using EcOrdinaryTextField
class EcPhoneField extends StatelessWidget {
  const EcPhoneField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your phone number',
    this.labelText = 'Phone Number',
    this.helperText,
    this.semanticsLabel = 'Phone input field',
    this.errorMessage,
    this.textInputAction = TextInputAction.next,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcOrdinaryTextField(
      semanticsLabel: semanticsLabel,
      keyboardType: TextInputType.phone,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      textInputAction: textInputAction,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common address input widget using EcOrdinaryTextField
class EcAddressField extends StatelessWidget {
  const EcAddressField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your address',
    this.labelText = 'Address',
    this.helperText,
    this.semanticsLabel = 'Address input field',
    this.errorMessage,
    this.textInputAction = TextInputAction.next,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcOrdinaryTextField(
      semanticsLabel: semanticsLabel,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      textInputAction: textInputAction,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common search field widget using EcSearchTextField
class EcSearchField extends StatelessWidget {
  const EcSearchField({
    super.key,
    required this.focusNode,
    required this.onSearch,
    this.onSearchSubmit,
    this.hintText = 'Search...',
    this.semanticsLabel = 'Search input field',
    this.errorMessage,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onSearch;
  final VoidCallback? onSearchSubmit;
  final String hintText;
  final String semanticsLabel;
  final String? errorMessage;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcSearchTextField(
      semanticsLabel: semanticsLabel,
      focusNode: focusNode,
      onSearch: onSearch,
      onSearchSubmit: onSearchSubmit,
      hintText: hintText,
      errorText: errorMessage,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Common text area widget using EcBigInputTextField for longer text input
class EcTextAreaField extends StatelessWidget {
  const EcTextAreaField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.onValidation,
    this.hintText = 'Enter your text here...',
    this.labelText = 'Description',
    this.helperText,
    this.semanticsLabel = 'Text area input field',
    this.errorMessage,
    this.maxLength = 500,
    this.maxLines = 5,
    this.minLines = 3,
    this.textInputAction = TextInputAction.newline,
    this.themeType = ECThemeType.user,
    this.isDark = false,
  });

  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onValidation;
  final String hintText;
  final String labelText;
  final String? helperText;
  final String semanticsLabel;
  final String? errorMessage;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputAction textInputAction;
  final ECThemeType themeType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return EcBigInputTextField(
      semanticsLabel: semanticsLabel,
      focusNode: focusNode,
      onChanged: onChanged,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorMessage,
      onTapOutside: onValidation,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      themeType: themeType,
      isDark: isDark,
    );
  }
}

/// Extension to get error messages for validation errors
extension EcValidationErrorExtension on EcValidationError {
  String getMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'This field is required';
      case EcValidationError.tooShort:
        return 'This field is too short';
      case EcValidationError.tooLong:
        return 'This field is too long';
      case EcValidationError.invalidFormat:
        return 'Invalid format';
      case EcValidationError.invalid:
        return 'Invalid value';
    }
  }
}

/// Extension to get specific error messages for different input types
extension EcEmailValidationErrorExtension on EcValidationError {
  String getEmailMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'Please enter your email address';
      case EcValidationError.invalidFormat:
        return 'Please enter a valid email address';
      case EcValidationError.invalid:
        return 'Invalid email format';
      default:
        return 'Invalid email';
    }
  }
}

/// Extension to get specific error messages for password validation
extension EcPasswordValidationErrorExtension on EcValidationError {
  String getPasswordMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'Please enter your password';
      case EcValidationError.tooShort:
        return 'Password must be at least 8 characters long';
      case EcValidationError.invalidFormat:
        return 'Password must contain uppercase, lowercase, number, and special character';
      case EcValidationError.invalid:
        return 'Invalid password format';
      default:
        return 'Invalid password';
    }
  }
}

/// Extension to get specific error messages for name validation
extension EcNameValidationErrorExtension on EcValidationError {
  String getNameMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'Please enter your name';
      case EcValidationError.tooShort:
        return 'Name must be at least 2 characters long';
      case EcValidationError.invalid:
        return 'Invalid name format';
      default:
        return 'Invalid name';
    }
  }
}

/// Extension to get specific error messages for phone validation
extension EcPhoneValidationErrorExtension on EcValidationError {
  String getPhoneMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'Please enter your phone number';
      case EcValidationError.invalidFormat:
        return 'Please enter a valid phone number';
      case EcValidationError.invalid:
        return 'Invalid phone number format';
      default:
        return 'Invalid phone number';
    }
  }
}

/// Extension to get specific error messages for address validation
extension EcAddressValidationErrorExtension on EcValidationError {
  String getAddressMessage() {
    switch (this) {
      case EcValidationError.empty:
        return 'Please enter your address';
      case EcValidationError.tooShort:
        return 'Address must be at least 5 characters long';
      case EcValidationError.invalid:
        return 'Invalid address format';
      default:
        return 'Invalid address';
    }
  }
}

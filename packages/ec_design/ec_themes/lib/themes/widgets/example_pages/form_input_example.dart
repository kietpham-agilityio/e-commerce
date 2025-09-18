import 'package:flutter/material.dart';
import '../textfield/form_input.dart';
import '../textfield/ec_small_text_field.dart';
import '../text.dart';

/// Example usage of form input widgets with validation
/// This demonstrates how to use the EcEmailField similar to the attached example

/// Example email input widget similar to the attached example
class _EmailInput extends StatefulWidget {
  const _EmailInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  EcEmailInput _emailInput = const EcEmailInput.pure();

  void _onEmailChanged(String value) {
    setState(() {
      _emailInput = EcEmailInput.dirty(value);
    });
  }

  void _onEmailValidation() {
    setState(() {
      _emailInput = EcEmailInput.dirty(_emailInput.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcEmailField(
      key: const Key('loginForm_emailInput_textField'),
      semanticsLabel: 'Email input field for login form',
      focusNode: widget.focusNode,
      onChanged: _onEmailChanged,
      hintText: 'Enter your email address',
      labelText: 'Email Address',
      helperText: 'We will never share your email',
      errorMessage: _emailInput.displayError?.getEmailMessage(),
      onValidation: _onEmailValidation,
      textInputAction: TextInputAction.next,
    );
  }
}

/// Example password input widget
class _PasswordInput extends StatefulWidget {
  const _PasswordInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  EcPasswordInput _passwordInput = const EcPasswordInput.pure();

  void _onPasswordChanged(String value) {
    setState(() {
      _passwordInput = EcPasswordInput.dirty(value);
    });
  }

  void _onPasswordValidation() {
    setState(() {
      _passwordInput = EcPasswordInput.dirty(_passwordInput.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcPasswordField(
      key: const Key('loginForm_passwordInput_textField'),
      semanticsLabel: 'Password input field for login form',
      focusNode: widget.focusNode,
      onChanged: _onPasswordChanged,
      hintText: 'Enter your password',
      labelText: 'Password',
      helperText: 'Must be at least 8 characters with special characters',
      errorMessage: _passwordInput.displayError?.getPasswordMessage(),
      onValidation: _onPasswordValidation,
      textInputAction: TextInputAction.done,
    );
  }
}

/// Example login form using the form input widgets
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _unfocusAllFields() {
    // Unfocus all form fields when tapping outside
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form Example')),
      body: GestureDetector(
        onTap: _unfocusAllFields,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Form Input Widgets Example',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _EmailInput(_emailFocusNode),
              const SizedBox(height: 16),
              _PasswordInput(_passwordFocusNode),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle login
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login button pressed')),
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example name input widget
class _NameInput extends StatefulWidget {
  const _NameInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  EcNameInput _nameInput = const EcNameInput.pure();

  void _onNameChanged(String value) {
    setState(() {
      _nameInput = EcNameInput.dirty(value);
    });
  }

  void _onNameValidation() {
    setState(() {
      _nameInput = EcNameInput.dirty(_nameInput.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcNameField(
      key: const Key('formInput_nameInput_textField'),
      semanticsLabel: 'Name input field',
      focusNode: widget.focusNode,
      onChanged: _onNameChanged,
      hintText: 'Enter your full name',
      labelText: 'Full Name',
      errorMessage: _nameInput.displayError?.getNameMessage(),
      onValidation: _onNameValidation,
      textInputAction: TextInputAction.next,
    );
  }
}

/// Example phone input widget
class _PhoneInput extends StatefulWidget {
  const _PhoneInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<_PhoneInput> {
  EcPhoneInput _phoneInput = const EcPhoneInput.pure();

  void _onPhoneChanged(String value) {
    setState(() {
      _phoneInput = EcPhoneInput.dirty(value);
    });
  }

  void _onPhoneValidation() {
    setState(() {
      _phoneInput = EcPhoneInput.dirty(_phoneInput.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcPhoneField(
      key: const Key('formInput_phoneInput_textField'),
      semanticsLabel: 'Phone input field',
      focusNode: widget.focusNode,
      onChanged: _onPhoneChanged,
      hintText: 'Enter your phone number',
      labelText: 'Phone Number',
      errorMessage: _phoneInput.displayError?.getPhoneMessage(),
      onValidation: _onPhoneValidation,
      textInputAction: TextInputAction.next,
    );
  }
}

/// Example search input widget
class _SearchInput extends StatefulWidget {
  const _SearchInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  String _searchValue = '';

  void _onSearchChanged(String value) {
    setState(() {
      _searchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcSearchField(
      key: const Key('formInput_searchInput_textField'),
      semanticsLabel: 'Search input field',
      focusNode: widget.focusNode,
      onSearch: _onSearchChanged,
      onSearchSubmit: () {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Searching for: $_searchValue')));
      },
      hintText: 'Search products...',
    );
  }
}

/// Example text area input widget
class _TextAreaInput extends StatefulWidget {
  const _TextAreaInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_TextAreaInput> createState() => _TextAreaInputState();
}

class _TextAreaInputState extends State<_TextAreaInput> {
  EcTextInput _textAreaInput = const EcTextInput.pure();

  void _onTextAreaChanged(String value) {
    setState(() {
      _textAreaInput = EcTextInput.dirty(value);
    });
  }

  void _onTextAreaValidation() {
    setState(() {
      _textAreaInput = EcTextInput.dirty(_textAreaInput.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcTextAreaField(
      key: const Key('formInput_textAreaInput_textField'),
      semanticsLabel: 'Text area input field',
      focusNode: widget.focusNode,
      onChanged: _onTextAreaChanged,
      hintText: 'Enter your description here...',
      labelText: 'Description',
      helperText: 'Maximum 500 characters',
      maxLength: 500,
      errorMessage: _textAreaInput.displayError?.getMessage(),
      onValidation: _onTextAreaValidation,
    );
  }
}

/// Example small text field input widget
class _SmallTextFieldInput extends StatefulWidget {
  const _SmallTextFieldInput(this.focusNode);

  final FocusNode focusNode;

  @override
  State<_SmallTextFieldInput> createState() => _SmallTextFieldInputState();
}

class _SmallTextFieldInputState extends State<_SmallTextFieldInput> {
  final TextEditingController _controller = TextEditingController();
  EcNameInput _usernameInput = const EcNameInput.pure();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String value) {
    setState(() {
      _usernameInput = EcNameInput.dirty(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EcSmallTextField(
      key: const Key('formInput_smallTextField_textField'),
      semanticsLabel: 'Small text field input',
      controller: _controller,
      focusNode: widget.focusNode,
      onChanged: _onUsernameChanged,
      hintText: 'Enter username',
      labelText: 'Username',
      helperText: 'Must be unique',
      errorText: _usernameInput.displayError?.getMessage(),
      hasValidation: true,
      validator:
          (value) => EcNameInput.dirty(value ?? '').displayError?.getMessage(),
      textInputAction: TextInputAction.done,
      onTrailingIconTap: () {
        _controller.clear();
        widget.focusNode.requestFocus();
        if (_usernameInput.displayError == null &&
            _controller.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username submitted: ${_controller.text}')),
          );
        }
      },
    );
  }
}

/// Example showing different form input types
class FormInputExamples extends StatefulWidget {
  const FormInputExamples({super.key});

  @override
  State<FormInputExamples> createState() => _FormInputExamplesState();
}

class _FormInputExamplesState extends State<FormInputExamples> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _nameFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _searchFocusNode;
  late final FocusNode _textAreaFocusNode;
  late final FocusNode _smallTextFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _searchFocusNode = FocusNode();
    _textAreaFocusNode = FocusNode();
    _smallTextFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _searchFocusNode.dispose();
    _textAreaFocusNode.dispose();
    _smallTextFieldFocusNode.dispose();
    super.dispose();
  }

  void _unfocusAllFields() {
    // Unfocus all form fields when tapping outside
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _nameFocusNode.unfocus();
    _phoneFocusNode.unfocus();
    _searchFocusNode.unfocus();
    _textAreaFocusNode.unfocus();
    _smallTextFieldFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: AppBar(
        title: EcTitleLargeText('Form Input Examples'),
        backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      ),
      body: GestureDetector(
        onTap: _unfocusAllFields,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EcTitleLargeText('Form Input Widgets with Validation'),
              EcBodySmallText(
                'Tap any field and then tap outside to see validation errors',
                color: Colors.grey,
              ),
              const SizedBox(height: 24),

              EcTitleMediumText('Email Field'),
              const SizedBox(height: 8),
              _EmailInput(_emailFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Password Field'),
              const SizedBox(height: 8),
              _PasswordInput(_passwordFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Name Field'),
              const SizedBox(height: 8),
              _NameInput(_nameFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Phone Field'),
              const SizedBox(height: 8),
              _PhoneInput(_phoneFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Search Field'),
              const SizedBox(height: 8),
              _SearchInput(_searchFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Text Area Field'),
              const SizedBox(height: 8),
              _TextAreaInput(_textAreaFocusNode),

              const SizedBox(height: 4),

              EcTitleMediumText('Small Text Field'),
              const SizedBox(height: 8),
              _SmallTextFieldInput(_smallTextFieldFocusNode),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted!')),
                    );
                  },
                  child: EcLabelLargeText('Submit Form'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SignUpScreen5 extends StatefulWidget {
  @override
  _SignUpScreen5State createState() => _SignUpScreen5State();
}

class _SignUpScreen5State extends State<SignUpScreen5> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();

  FocusNode? _currentFocus;
  Color _backgroundColor = Colors.blue.shade50;
  bool _isOtpSent = false;
  bool _isLoading = false;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _otpFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    _currentFocus = FocusNode();
    _currentFocus?.addListener(() {
      setState(() {
        _backgroundColor = _getBackgroundColor();
      });
    });
  }

  Color _getBackgroundColor() {
    if (_currentFocus?.hasFocus ?? false) {
      if (_nameFocus.hasFocus) return Colors.purple.shade50;
      if (_phoneFocus.hasFocus) return Colors.blue.shade50;
      if (_otpFocus.hasFocus) return Colors.green.shade50;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _backgroundColor,
              _backgroundColor.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  _buildNameField(),
                  SizedBox(height: 20),
                  _buildPhoneField(),
                  if (_isOtpSent) ...[
                    SizedBox(height: 20),
                    _buildOtpField(),
                  ],
                  SizedBox(height: 32),
                  _buildActionButton(),
                  if (!_isOtpSent) ...[
                    SizedBox(height: 24),
                    _buildDivider(),
                    SizedBox(height: 24),
                    _buildEmailSignupButton(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      focusNode: _nameFocus,
      decoration: InputDecoration(
        labelText: 'Full Name',
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: Icon(Icons.phone_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        helperText: 'We\'ll send you a verification code',
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }

  Widget _buildOtpField() {
    return TextFormField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        labelText: 'Verification Code',
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Please enter the verification code';
        }
        if (value!.length < 6) {
          return 'Please enter a valid code';
        }
        return null;
      },
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleAction,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              _isOtpSent ? 'Verify & Continue' : 'Send Verification Code',
              style: TextStyle(fontSize: 16),
            ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR'),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildEmailSignupButton() {
    return OutlinedButton(
      onPressed: () {
        // Handle email signup
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text('Sign Up with Email'),
    );
  }

  Future<void> _handleAction() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        if (!_isOtpSent) {
          _isOtpSent = true;
        } else {
          // Handle verification completion
        }
      });
    }
  }

  @override
  void dispose() {
    _currentFocus?.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _otpFocus.dispose();
    super.dispose();
  }
}

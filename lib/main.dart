import 'package:flutter/material.dart';
import 'api_service.dart';
import 'navbar.dart';
import 'forgotpass.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'config.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restease',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// SplashScreen widget
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeImageScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF94B2CC), // 20%
              Color(0xFF617E96), // 96%
              Color(0xFF506C84), // 100%
            ],
            stops: [0.2, 0.96, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 90,
                height: 90,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

// WelcomeImageScreen widget
class WelcomeImageScreen extends StatefulWidget {
  const WelcomeImageScreen({super.key});

  @override
  State<WelcomeImageScreen> createState() => _WelcomeImageScreenState();
}

class _WelcomeImageScreenState extends State<WelcomeImageScreen> {
  String? _apiBaseUrl;

  @override
  void initState() {
    super.initState();
    _loadApiBaseUrl();
  }

  Future<void> _loadApiBaseUrl() async {
    final url = await ApiConfig.getApiBaseUrl();
    setState(() {
      _apiBaseUrl = url;
    });
  }

  Future<void> _showChangeApiDialog() async {
    final controller = TextEditingController(text: _apiBaseUrl ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set API Base URL'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'API Base URL',
            hintText: 'http://192.168.x.x/RestEase',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      await ApiConfig.setApiBaseUrl(result);
      await _loadApiBaseUrl();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API Base URL updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Change API Base URL button (left side)
                  SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      onPressed: _showChangeApiDialog,
                      icon: const Icon(Icons.settings_ethernet, color: Color(0xFF20435C)),
                      label: const Text(
                        'Set IP',
                        style: TextStyle(color: Color(0xFF20435C)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF20435C)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  // Get Started button (right side)
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF20435C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Get Started', style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  // Add field error states
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateLoginFields() {
    bool valid = true;
    setState(() {
      _emailError = null;
      _passwordError = null;
      _errorMessage = null;
      if (_emailController.text.trim().isEmpty) {
        _emailError = 'Email is required';
        valid = false;
      } else if (!_emailController.text.trim().contains('@')) {
        _emailError = 'Enter a valid email';
        valid = false;
      }
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password is required';
        valid = false;
      }
    });
    return valid;
  }

  Future<void> _login() async {
    if (!_validateLoginFields()) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    try {
      final result = await loginUser(email, password);
      if (result['success'] == true) {
        // Save user_id and user_email to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', result['user_id']);
        await prefs.setString('user_email', email); // <-- Save email
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MapHomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/loginbg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Centered login form in the white area
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56), // Space above logo
                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 120,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Email field
                    TextField(
                      controller: _emailController,
                      onChanged: (_) {
                        if (_emailError != null) _validateLoginFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF20435C),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _emailError,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onChanged: (_) {
                        if (_passwordError != null) _validateLoginFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF20435C),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _passwordError,
                        errorStyle: const TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8CAFC9),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Remember Me and Forgot Password
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (val) {
                            setState(() {
                              _rememberMe = val ?? false;
                            });
                          },
                          activeColor: const Color(0xFF8CAFC9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        const Text('Remember Me', style: TextStyle(fontSize: 14)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF8CAFC9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold, shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.redAccent,
                              offset: Offset(0, 0),
                            )
                          ]),
                        ),
                      ),
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF94B2CC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Divider with or
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('or'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Google sign in button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD1D5DB)),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32), // Space at the bottom
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _agreeTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;
  String? _successMessage;

  // Add field error states
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _contactError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateRegisterFields() {
    bool valid = true;
    setState(() {
      _firstNameError = null;
      _lastNameError = null;
      _emailError = null;
      _contactError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _errorMessage = null;

      // First Name validation: required, no symbols/numbers
      if (_firstNameController.text.trim().isEmpty) {
        _firstNameError = 'First name required';
        valid = false;
      } else if (!RegExp(r"^[a-zA-Z\s\-]+$").hasMatch(_firstNameController.text.trim())) {
        _firstNameError = 'First name can only contain letters and spaces';
        valid = false;
      }

      // Last Name validation: required, no symbols/numbers
      if (_lastNameController.text.trim().isEmpty) {
        _lastNameError = 'Last name required';
        valid = false;
      } else if (!RegExp(r"^[a-zA-Z\s\-]+$").hasMatch(_lastNameController.text.trim())) {
        _lastNameError = 'Last name can only contain letters and spaces';
        valid = false;
      }

      if (_emailController.text.trim().isEmpty) {
        _emailError = 'Email required';
        valid = false;
      } else if (!_emailController.text.trim().contains('@')) {
        _emailError = 'Enter a valid email';
        valid = false;
      }

      // Contact: required, must be exactly 11 digits and start with 09
      if (_contactController.text.trim().isEmpty) {
        _contactError = 'Contact required';
        valid = false;
      } else if (!RegExp(r'^09[0-9]{9}$').hasMatch(_contactController.text.trim())) {
        _contactError = 'Contact must start with 09 and be 11 digits';
        valid = false;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password required';
        valid = false;
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
        valid = false;
      }
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Confirm your password';
        valid = false;
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        valid = false;
      }
      if (!_agreeTerms) {
        _errorMessage = 'You must agree to the Terms & Condition';
        valid = false;
      }
    });
    return valid;
  }

  Future<void> _signUp() async {
    if (!_validateRegisterFields()) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
      _successMessage = null;
    });
    try {
      final result = await registerUser(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        contactNo: _contactController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        terms: _agreeTerms,
      );
      if (result['success'] == true) {
        setState(() {
          _successMessage = "Registration successful! Please login.";
        });
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Registration failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Terms & Condition'),
        content: const SingleChildScrollView(
          child: Text(
            'To proceed with managing cemetery records or requesting certificates through RestEase, you must first agree to our User Terms. By tapping "I AGREE", you confirm that you have read and accepted the responsibilities outlined below.\n\n'
            'As a User, you agree and confirm that:\n\n'
            '• All information you provide (such as deceased details, applicant name, and contact information) is accurate and complete;\n'
            '• You are authorized to request records or certificates for the deceased individuals listed;\n'
            '• Your use of the system is solely for legitimate and respectful purposes;\n'
            '• You acknowledge that issuance of certificates (e.g., interment, renewal) is subject to review and validation by the Municipal Planning and Development Office (MPDO);\n'
            '• You are responsible for complying with all applicable local regulations and requirements related to cemetery management;\n'
            '• Any false or misleading information may result in rejection of your request and possible account suspension.\n\n'
            'Before submitting any application or update, you must ensure that all required documents are uploaded and legible, and that you have reviewed your entries for accuracy.'
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/loginbg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56), // Space above title
                    // Title instead of logo
                    const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF20435C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            onChanged: (_) {
                              if (_firstNameError != null) _validateRegisterFields();
                            },
                            decoration: InputDecoration(
                              labelText: 'First name',
                              labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8CAFC9),
                                  width: 1.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8CAFC9),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              filled: true,
                              fillColor: Colors.white,
                              errorText: _firstNameError,
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            onChanged: (_) {
                              if (_lastNameError != null) _validateRegisterFields();
                            },
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8CAFC9),
                                  width: 1.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8CAFC9),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.2,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              filled: true,
                              fillColor: Colors.white,
                              errorText: _lastNameError,
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      onChanged: (_) {
                        if (_emailError != null) _validateRegisterFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _emailError,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contactController,
                      onChanged: (_) {
                        if (_contactError != null) _validateRegisterFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _contactError,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onChanged: (_) {
                        if (_passwordError != null) _validateRegisterFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _passwordError,
                        errorStyle: const TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8CAFC9),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      onChanged: (_) {
                        if (_confirmPasswordError != null) _validateRegisterFields();
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(color: Color(0xFF8CAFC9)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF8CAFC9),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _confirmPasswordError,
                        errorStyle: const TextStyle(color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8CAFC9),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                            });
                          },
                          activeColor: const Color(0xFF8CAFC9),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        const Text('I agree the '),
                        GestureDetector(
                          onTap: _showTermsDialog,
                          child: const Text(
                            'Terms & Condition',
                            style: TextStyle(
                              color: Color(0xFF20435C),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold, shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.redAccent,
                              offset: Offset(0, 0),
                            )
                          ]),
                        ),
                      ),
                    if (_successMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _successMessage!,
                          style: const TextStyle(color: Colors.green, fontSize: 14),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: (_agreeTerms && !_loading) ? _signUp : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF94B2CC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have account? ", style: TextStyle(fontSize: 14)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFF8CAFC9),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32), // Space at the bottom
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});
  @override
  State<MapHomeScreen> createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  late final WebViewController _controller;
  bool _webViewLoaded = false;
  List<Map<String, dynamic>> _niches = [];
  List<Map<String, dynamic>> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchBar = false;
  bool _searching = false;
  String? _apiBaseUrl;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            _webViewLoaded = true;
          });
        },
      ));
    _loadApiBaseUrl();
  }

  Future<void> _loadApiBaseUrl() async {
    final url = await ApiConfig.getApiBaseUrl();
    setState(() {
      _apiBaseUrl = url;
    });
    // Reload niches and webview with new base URL
    _controller.loadRequest(Uri.parse('$_apiBaseUrl/ClientSide/ClientMap.php?embed=1'));
    _loadNiches();
  }

  Future<void> _loadNiches() async {
    if (_apiBaseUrl == null) return;
    final response = await http.get(Uri.parse('$_apiBaseUrl/ClientSide/get_niches.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _niches = (jsonData['niches'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      });
    } else {
      // Handle error
      setState(() {
        _niches = [];
      });
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchResults = _niches
          .where((niche) => (niche['Name'] ?? '').toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onResultTap(Map<String, dynamic> niche) async {
    setState(() {
      _showSearchBar = false;
      _searchController.clear();
      _searchResults = [];
    });
    if (_webViewLoaded) {
      await _controller.runJavaScript("window.focusNiche && window.focusNiche('${niche['nicheID']}')");
    }
  }

  Future<void> _showChangeApiDialog() async {
    final controller = TextEditingController(text: _apiBaseUrl ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set API Base URL'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'API Base URL',
            hintText: 'http://192.168.x.x/RestEase',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      await ApiConfig.setApiBaseUrl(result);
      await _loadApiBaseUrl();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API Base URL updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 36,
        ),
        backgroundColor: const Color.fromARGB(255, 167, 194, 213),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF20435C)),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                _searchResults = [];
                _searchController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_ethernet, color: Color(0xFF20435C)),
            tooltip: 'Change API Base URL',
            onPressed: _showChangeApiDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_apiBaseUrl != null)
            WebViewWidget(controller: _controller),
          if (_showSearchBar)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Color(0xFF20435C)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                  hintText: 'Search by name...',
                                  border: InputBorder.none,
                                ),
                                onChanged: _onSearchChanged,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _showSearchBar = false;
                                  _searchController.clear();
                                  _searchResults = [];
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_searchController.text.isNotEmpty && _searchResults.isNotEmpty)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 250),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final result = _searchResults[index];
                              return ListTile(
                                title: Text(result['Name'] ?? ''),
                                subtitle: Text(result['nicheID'] ?? ''),
                                onTap: () => _onResultTap(result),
                              );
                            },
                          ),
                        ),
                      if (_searchController.text.isNotEmpty && _searchResults.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No results found.'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}


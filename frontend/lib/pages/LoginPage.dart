import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1E1E2C),
      body: Stack(
        children: [
          // Animated background elements
          ...List.generate(
            12,
            (index) => Positioned(
              right: index * 40.0,
              top: index * 50.0,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.05),
                      Colors.purple.withOpacity(0.05),
                    ],
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: Duration(seconds: 3 + index),
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                )
                .then()
                .scale(
                  duration: Duration(seconds: 3 + index),
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1, 1),
                ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildLoginForm(),
                      const SizedBox(height: 20),
                      _buildLoginButton(),
                      const SizedBox(height: 20),
                      _buildForgotPassword(),
                      const SizedBox(height: 30),
                      _buildSocialLogin(),
                      const SizedBox(height: 20),
                      _buildRegisterLink(),
                    ].animate(interval: const Duration(milliseconds: 100))
                        .fadeIn(duration: const Duration(milliseconds: 500))
                        .slideY(begin: 50, end: 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.local_drink_outlined,
            size: 48,
            color: Colors.blue,
          ),
        ).animate()
          .scale(duration: const Duration(milliseconds: 500))
          .then()
          .shake(duration: const Duration(milliseconds: 300)),
        const SizedBox(height: 24),
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).animate().fadeIn().slideX(),
        const SizedBox(height: 8),
        Text(
          "Please login to your account",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _emailController,
          hintText: "Enter your email",
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          hintText: "Enter your password",
          prefixIcon: Icons.lock_outline,
          obscureText: !_isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildRememberMeSection(),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(prefixIcon, color: Colors.grey[400]),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    ).animate()
        .fadeIn()
        .slideX();
  }

  Widget _buildRememberMeSection() {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.blue;
                  }
                  return Colors.grey;
                },
              ),
            ),
          ),
          child: Checkbox(
            value: _rememberMe,
            onChanged: (bool? value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
          ),
        ),
        Text(
          'Remember me',
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Text(
              "Login",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    ).animate()
        .fadeIn()
        .scale();
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        // Navigate to forgot password page
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[600])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Or continue with",
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[600])),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: FontAwesomeIcons.google,
              label: "Google",
              color: Colors.red,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: FontAwesomeIcons.facebook,
              label: "Facebook",
              color: Colors.blue[800]!,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: FaIcon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(150, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
      ),
      onPressed: onPressed,
    ).animate()
        .fadeIn()
        .scale();
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey[400]),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }
}
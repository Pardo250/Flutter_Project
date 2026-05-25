import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isSignInEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isSignInEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildLogo(),
              const SizedBox(height: 48),
              _buildTitle(),
              const SizedBox(height: 48),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 12),
              _buildForgotPassword(),
              const SizedBox(height: 32),
              _buildSignInButton(),
              const SizedBox(height: 32),
              _buildDivider(),
              const SizedBox(height: 32),
              _buildGoogleButton(),
              const SizedBox(height: 16),
              _buildRegisterButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/logos/logo.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 16),
        Text(
          'Viaja con confianza',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CondorAppTheme.textTertiary,
                letterSpacing: 0.3,
              ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Descubre la magia de los\nAndes y más allá',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: CondorAppTheme.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 22,
            height: 1.5,
          ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: CondorAppTheme.textPrimary),
      cursorColor: CondorAppTheme.primaryGreen,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'nombre@ejemplo.com',
        prefixIcon: const Icon(Icons.email_outlined),
        prefixIconColor: CondorAppTheme.primaryGreen,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      style: const TextStyle(color: CondorAppTheme.textPrimary),
      cursorColor: CondorAppTheme.primaryGreen,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline),
        prefixIconColor: CondorAppTheme.primaryGreen,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: CondorAppTheme.primaryGreen,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implementar olvide contraseña
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          '¿Olvidaste la contraseña?',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CondorAppTheme.primaryGreen,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isSignInEnabled
            ? () {
                Navigator.pushReplacementNamed(context, '/main');
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: CondorAppTheme.primaryGreen,
          disabledBackgroundColor: CondorAppTheme.primaryGreen.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Iniciar Sesión',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CondorAppTheme.darkGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: CondorAppTheme.textTertiary)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o continúa con',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: CondorAppTheme.textTertiary,
                ),
          ),
        ),
        Expanded(child: Container(height: 1, color: CondorAppTheme.textTertiary)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implementar Google login
        },
        icon: const Text('🔍'),
        label: Text(
          'Google',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CondorAppTheme.textPrimary,
              ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF404040)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: CondorAppTheme.primaryGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Crear Cuenta',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CondorAppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

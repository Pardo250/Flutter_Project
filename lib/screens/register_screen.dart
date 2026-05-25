import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _usernameController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isRegisterEnabled = false;

  @override
  void initState() {
    super.initState();
    _nombreController.addListener(_validateForm);
    _apellidoController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
    _correoController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isRegisterEnabled = _nombreController.text.isNotEmpty &&
          _apellidoController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _correoController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          (_passwordController.text == _confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _usernameController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Crear Cuenta'),
        backgroundColor: CondorAppTheme.darkBg,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildLogo(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 32),
              _buildNameFields(),
              const SizedBox(height: 16),
              _buildUsernameField(),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildConfirmPasswordField(),
              const SizedBox(height: 8),
              _buildPasswordMatchIndicator(),
              const SizedBox(height: 32),
              _buildRegisterButton(),
              const SizedBox(height: 16),
              _buildLoginLink(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/logos/logo.png',
      width: 100,
      height: 100,
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Bienvenido a condorapp',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: CondorAppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Crea tu cuenta para comenzar',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CondorAppTheme.textTertiary,
              ),
        ),
      ],
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _nombreController,
            style: const TextStyle(color: CondorAppTheme.textPrimary),
            cursorColor: CondorAppTheme.primaryGreen,
            decoration: InputDecoration(
              labelText: 'Nombre',
              hintText: 'Juan',
              prefixIcon: const Icon(Icons.person_outline),
              prefixIconColor: CondorAppTheme.primaryGreen,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _apellidoController,
            style: const TextStyle(color: CondorAppTheme.textPrimary),
            cursorColor: CondorAppTheme.primaryGreen,
            decoration: InputDecoration(
              labelText: 'Apellido',
              hintText: 'Pérez',
              prefixIcon: const Icon(Icons.person_outline),
              prefixIconColor: CondorAppTheme.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      style: const TextStyle(color: CondorAppTheme.textPrimary),
      cursorColor: CondorAppTheme.primaryGreen,
      decoration: InputDecoration(
        labelText: 'Usuario',
        hintText: '@juanperez',
        prefixIcon: const Icon(Icons.alternate_email),
        prefixIconColor: CondorAppTheme.primaryGreen,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _correoController,
      style: const TextStyle(color: CondorAppTheme.textPrimary),
      cursorColor: CondorAppTheme.primaryGreen,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'correo@ejemplo.com',
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
      onChanged: (_) => _validateForm(),
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

  Widget _buildConfirmPasswordField() {
    return TextField(
      controller: _confirmPasswordController,
      style: const TextStyle(color: CondorAppTheme.textPrimary),
      cursorColor: CondorAppTheme.primaryGreen,
      obscureText: !_isConfirmPasswordVisible,
      onChanged: (_) => _validateForm(),
      decoration: InputDecoration(
        labelText: 'Confirmar Contraseña',
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline),
        prefixIconColor: CondorAppTheme.primaryGreen,
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: CondorAppTheme.primaryGreen,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPasswordMatchIndicator() {
    final passwordsMatch = _passwordController.text == _confirmPasswordController.text &&
        _passwordController.text.isNotEmpty;
    
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, top: 4),
        child: Text(
          passwordsMatch ? '✓ Las contraseñas coinciden' : '✗ Las contraseñas no coinciden',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: passwordsMatch ? CondorAppTheme.primaryGreen : Color(0xFFFF6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isRegisterEnabled
            ? () {
                // TODO: Implementar registro
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
          'Registrarse',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CondorAppTheme.darkGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes cuenta? ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CondorAppTheme.textSecondary,
              ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Inicia sesión',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: CondorAppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }
}

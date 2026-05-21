import 'package:flutter/material.dart';
import 'register_screen.dart';

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
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo
              _buildLogo(),
              const SizedBox(height: 40),
              // Título
              Text(
                'Descubre la magia de los\nAndes y más allá',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFFB0B0B0),
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 40),
              // Email Field
              _buildEmailField(),
              const SizedBox(height: 24),
              // Password Field
              _buildPasswordField(),
              const SizedBox(height: 12),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implementar olvide contraseña
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF90C965),
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Sign In Button
              _buildSignInButton(),
              const SizedBox(height: 32),
              // Divider
              _buildDivider(),
              const SizedBox(height: 32),
              // Google Button
              _buildGoogleButton(),
              const SizedBox(height: 16),
              // Register Button
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
        SizedBox(
          width: 120,
          height: 120,
          child: CustomPaint(
            painter: CondorappLogoPainter(),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'condorapp',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF1B5E20),
                fontWeight: FontWeight.bold,
                fontSize: 26,
                letterSpacing: 0.5,
              ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFF90C965),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(
          color: Color(0xFF90C965),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: 'name@example.com',
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFF90C965),
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Color(0xFF90C965),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: 'Value',
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        filled: false,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF90C965),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF90C965),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSignInEnabled
            ? () {
                // Navegar a pantalla principal
                Navigator.pushReplacementNamed(context, '/main');
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isSignInEnabled
              ? const Color(0xFF90C965)
              : const Color(0xFF555555),
          disabledBackgroundColor: const Color(0xFF555555),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Sign In',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: _isSignInEnabled
                    ? const Color(0xFF1a1a1a)
                    : const Color(0xFF999999),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF90C965),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '0',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF90C965),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFF90C965),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implementar inicio de sesión con Google
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B4B88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: Color(0xFF5B4B88),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Continua con Google',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/register');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFF666666),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Registrarse',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class CondorappLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final darkGreen = Paint()..color = const Color(0xFF1B5E20);
    final lightGreen = Paint()..color = const Color(0xFF7CB342);
    final brownDark = Paint()..color = const Color(0xFF8B6F47);
    final brownLight = Paint()..color = const Color(0xFFC8A882);
    final whitePaint = Paint()..color = Colors.white;
    final darkPaint = Paint()..color = const Color(0xFF1a1a1a);

    // Ala izquierda oscura (V invertida)
    final leftWingDarkPath = Path();
    leftWingDarkPath.moveTo(center.dx - 35, center.dy - 15);
    leftWingDarkPath.lineTo(center.dx - 55, center.dy + 5);
    leftWingDarkPath.lineTo(center.dx - 25, center.dy + 15);
    leftWingDarkPath.lineTo(center.dx - 15, center.dy - 5);
    leftWingDarkPath.close();
    canvas.drawPath(leftWingDarkPath, darkGreen);

    // Ala izquierda clara (superpuesta)
    final leftWingLightPath = Path();
    leftWingLightPath.moveTo(center.dx - 30, center.dy - 10);
    leftWingLightPath.lineTo(center.dx - 48, center.dy + 8);
    leftWingLightPath.lineTo(center.dx - 20, center.dy + 18);
    leftWingLightPath.lineTo(center.dx - 10, center.dy + 2);
    leftWingLightPath.close();
    canvas.drawPath(leftWingLightPath, lightGreen);

    // Ala derecha oscura (V invertida)
    final rightWingDarkPath = Path();
    rightWingDarkPath.moveTo(center.dx + 35, center.dy - 15);
    rightWingDarkPath.lineTo(center.dx + 55, center.dy + 5);
    rightWingDarkPath.lineTo(center.dx + 25, center.dy + 15);
    rightWingDarkPath.lineTo(center.dx + 15, center.dy - 5);
    rightWingDarkPath.close();
    canvas.drawPath(rightWingDarkPath, darkGreen);

    // Ala derecha clara (superpuesta)
    final rightWingLightPath = Path();
    rightWingLightPath.moveTo(center.dx + 30, center.dy - 10);
    rightWingLightPath.lineTo(center.dx + 48, center.dy + 8);
    rightWingLightPath.lineTo(center.dx + 20, center.dy + 18);
    rightWingLightPath.lineTo(center.dx + 10, center.dy + 2);
    rightWingLightPath.close();
    canvas.drawPath(rightWingLightPath, lightGreen);

    // Pin exterior (marrón oscuro)
    final pinOuterPath = Path();
    pinOuterPath.moveTo(center.dx, center.dy - 18);
    pinOuterPath.cubicTo(
      center.dx - 12,
      center.dy - 12,
      center.dx - 14,
      center.dy + 8,
      center.dx,
      center.dy + 20,
    );
    pinOuterPath.cubicTo(
      center.dx + 14,
      center.dy + 8,
      center.dx + 12,
      center.dy - 12,
      center.dx,
      center.dy - 18,
    );
    pinOuterPath.close();
    canvas.drawPath(pinOuterPath, brownDark);

    // Pin intermedio (marrón claro)
    final pinMiddlePath = Path();
    pinMiddlePath.moveTo(center.dx, center.dy - 14);
    pinMiddlePath.cubicTo(
      center.dx - 9,
      center.dy - 10,
      center.dx - 10,
      center.dy + 4,
      center.dx,
      center.dy + 14,
    );
    pinMiddlePath.cubicTo(
      center.dx + 10,
      center.dy + 4,
      center.dx + 9,
      center.dy - 10,
      center.dx,
      center.dy - 14,
    );
    pinMiddlePath.close();
    canvas.drawPath(pinMiddlePath, brownLight);

    // Círculo interior blanco (marcador)
    canvas.drawCircle(center + const Offset(0, 2), 5, whitePaint);

    // Pequeño círculo en el interior blanco
    canvas.drawCircle(center + const Offset(0, 2), 2, darkPaint);

    // Cabecita del pin (redonded top)
    final topCircle = Paint()..color = const Color(0xFF8B6F47);
    canvas.drawCircle(Offset(center.dx, center.dy - 22), 6, topCircle);
  }

  @override
  bool shouldRepaint(CondorappLogoPainter oldDelegate) => false;
}

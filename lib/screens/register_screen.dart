import 'package:flutter/material.dart';

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
          _confirmPasswordController.text.isNotEmpty;
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
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              // Nombre y Apellido en fila
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _nombreController,
                      label: 'Nombre',
                      hint: 'Juan',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _apellidoController,
                      label: 'Apellido',
                      hint: 'Camilo',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Username
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                hint: 'camilo',
              ),
              const SizedBox(height: 20),
              // Correo
              _buildTextField(
                controller: _correoController,
                label: 'Correo',
                hint: 'camilo@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // Contraseña
              _buildPasswordField(
                controller: _passwordController,
                label: 'Contraseña',
                hint: 'Contraseña',
                isVisible: _isPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Confirmar Contraseña
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirmar Contraseña',
                hint: 'Contraseña',
                isVisible: _isConfirmPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 30),
              // Botón Registrarse
              _buildRegisterButton(),
              const SizedBox(height: 12),
              // Botón Cancelar
              _buildCancelButton(),
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
          width: 100,
          height: 100,
          child: CustomPaint(
            painter: CondorappLogoPainter(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'condorapp',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF1B5E20),
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 0.5,
              ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFF90C965),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF90C965),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
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
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFF90C965),
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF90C965),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF666666)),
        filled: false,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF90C965),
          ),
          onPressed: onVisibilityToggle,
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

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isRegisterEnabled
            ? () {
                // Validar que las contraseñas coincidan
                if (_passwordController.text != _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Las contraseñas no coinciden'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                // Navegar a pantalla principal
                Navigator.pushReplacementNamed(context, '/main');
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isRegisterEnabled
              ? const Color(0xFF90C965)
              : const Color(0xFF555555),
          disabledBackgroundColor: const Color(0xFF555555),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Registrarse',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: _isRegisterEnabled
                    ? const Color(0xFF1a1a1a)
                    : const Color(0xFF999999),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xFF666666),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Cancelar',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
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

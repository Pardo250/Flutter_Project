# Guía de Navegación - Pantallas

## Pantallas Disponibles

Tu app Flutter ahora tiene 3 pantallas principales:

1. **LoginScreen** - Pantalla de login (existente)
2. **HomeScreen** - Feed personalizado (nueva)
3. **FeedScreen** - Exploración de artículos (nueva)

## Cambiar Pantalla Principal

Abre `lib/main.dart` y cambia `home:` en el `MaterialApp`:

### Opción 1: HomeScreen (Feed Personalizado)
```dart
home: const HomeScreen(),
```

### Opción 2: FeedScreen (Exploración)
```dart
home: const FeedScreen(),
```

### Opción 3: LoginScreen
```dart
home: const LoginScreen(),
```

## Ejemplo Completo

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/feed_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Condor App',
      theme: CondorAppTheme.lightTheme(),
      darkTheme: CondorAppTheme.darkTheme(),
      themeMode: ThemeMode.light,
      // 👇 CAMBIAR AQUÍ LA PANTALLA INICIAL
      home: const HomeScreen(), // Puedes cambiar a FeedScreen o LoginScreen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/feed': (context) => const FeedScreen(),
      },
    );
  }
}
```

## Navegar Entre Pantallas

### Con Rutas Nombradas

```dart
// Navegar a HomeScreen
Navigator.pushNamed(context, '/home');

// Navegar a FeedScreen
Navigator.pushNamed(context, '/feed');

// Navegar a LoginScreen
Navigator.pushNamed(context, '/login');

// Reemplazar la pantalla actual (volver atrás)
Navigator.pushReplacementNamed(context, '/home');

// Volver a la pantalla anterior
Navigator.pop(context);
```

### Con Clases Directas

```dart
// Navegar a HomeScreen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const HomeScreen()),
);

// Navegar a FeedScreen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const FeedScreen()),
);

// Reemplazar pantalla (logout)
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const LoginScreen()),
);
```

## Ejemplo: Agregar Botón de Navegación

### En HomeScreen
```dart
FloatingActionButton(
  onPressed: () => Navigator.pushNamed(context, '/feed'),
  child: const Icon(Icons.explore),
)
```

### En FeedScreen
```dart
FloatingActionButton(
  onPressed: () => Navigator.pushNamed(context, '/home'),
  child: const Icon(Icons.home),
)
```

## Flujo de Navegación Recomendado

```
LoginScreen
    ↓
    ├→ HomeScreen (Feed Personal)
    │   └→ FeedScreen (Exploración)
    │       └→ Detalles del Artículo (TODO)
    │
    └→ Volver a Login
```

## Agregar BottomNavigationBar

Para navegar entre HomeScreen y FeedScreen con `BottomNavigationBar`:

```dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FeedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorar',
          ),
        ],
      ),
    );
  }
}
```

Luego en `main.dart`:
```dart
home: const MainScreen(),
```

## Pasar Datos Entre Pantallas

### HomeScreen → FeedScreen

```dart
// En HomeScreen
Navigator.pushNamed(
  context,
  '/feed',
  arguments: {'categoria': 'paisaje'},
);

// En FeedScreen, recibir datos
@override
void initState() {
  super.initState();
  final args = ModalRoute.of(context)?.settings.arguments as Map?;
  if (args != null) {
    selectedCategoryIndex = _categoryNames.indexOf(args['categoria']);
  }
}
```

## Testing de Navegación

```dart
// Test simple de navegación
testWidgets('Navigate to FeedScreen', (WidgetTester tester) async {
  await tester.pumpWidget(const MainApp());
  
  // Navegar
  await tester.tap(find.byIcon(Icons.explore));
  await tester.pumpAndSettle();
  
  // Verificar
  expect(find.byType(FeedScreen), findsOneWidget);
});
```

## Estado de Navegación

Para mantener el estado de las pantallas cuando navegas entre ellas:

```dart
// En lugar de MaterialPageRoute
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const FeedScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // Sin animación para mantener estado
    },
  ),
);
```

O usa un índice en un `StatefulWidget` padre (ver ejemplo de `BottomNavigationBar`).

---

**¡Ahora puedes navegar fácilmente entre pantallas!** 🚀

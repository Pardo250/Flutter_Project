# 🏠 vs 🔍 HomeScreen vs FeedScreen

## Comparativa Visual

### HomeScreen - Feed Personalizado
**Propósito**: Ver artículos personalizados según lo que sigues

```
┌─────────────────────────────────┐
│ ← Avatar 👤          🔔          │  ← Header
├─────────────────────────────────┤
│ [Todos]  [Siguiendo]            │  ← Toggle
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐│
│  │  [Imagen del Artículo]      ││
│  ├─────────────────────────────┤│  ← Tarjeta de Artículo
│  │ 📚 Título Artículo          ││
│  │ [tipo]                      ││
│  │ Descripción del artículo... ││
│  └─────────────────────────────┘│
│                                 │
│  ┌─────────────────────────────┐│
│  │  ⭐⭐⭐⭐⭐ Review          ││
│  │  Usuario: "Excelente!"      ││  ← Tarjeta de Reseña
│  └─────────────────────────────┘│
│                                 │
└─────────────────────────────────┘
```

### FeedScreen - Exploración
**Propósito**: Explorar todos los artículos disponibles

```
┌─────────────────────────────────┐
│ 🔍 Buscar artículos             │  ← Barra de Búsqueda
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────────┐│
│  │    [🗺 Ver reviews en mapa]  ││  ← Tarjeta de Mapa
│  └─────────────────────────────┘│
│                                 │
│ [Paisajes] [Playas] [Cultural]  │  ← Categorías
│                                 │
│ Recomendado para ti             │
│                                 │
│  ┌─────────────┐ ┌─────────────┐│
│  │  Imagen     │ │  Imagen     ││
│  │  Título     │ │  Título     ││  ← Grid 2 Columnas
│  │  [tipo]     │ │  [tipo]     ││
│  └─────────────┘ └─────────────┘│
│  ┌─────────────┐ ┌─────────────┐│
│  │  Imagen     │ │  Imagen     ││
│  │  Título     │ │  Título     ││
│  │  [tipo]     │ │  [tipo]     ││
│  └─────────────┘ └─────────────┘│
│                                 │
└─────────────────────────────────┘
```

---

## Tabla Comparativa

| Aspecto | HomeScreen | FeedScreen |
|---|---|---|
| **Propósito** | Feed personalizado | Exploración |
| **Tipo de lista** | Vertical (scroll) | Grid 2 columnas |
| **Filtro principal** | Todos / Siguiendo | Categoría |
| **Búsqueda** | No | Sí |
| **Mapa** | No | Sí |
| **Información** | Mucha (descripción) | Poca (solo título) |
| **Reseñas** | Mostradas | No mostradas |
| **Avatar** | Sí | No |
| **Notificaciones** | Sí | No |
| **Tarjeta altura** | Variable | Fija |

---

## Flujo de Usuario Recomendado

```
1. Usuario abre la app
   ↓
2. Login → HomeScreen (Feed personalizado)
   ↓
3. Navega a FeedScreen (Exploración)
   ↓
4. Busca por categoría o texto
   ↓
5. Hace click en un artículo
   ↓
6. Ver detalles (próxima pantalla a implementar)
```

---

## Cuándo Usar Cada Una

### Usa HomeScreen cuando:
- ✅ Quieres ver artículos personalizados
- ✅ Necesitas ver reseñas de usuarios
- ✅ Quieres ver más detalles de cada artículo
- ✅ Prefieres una lista vertical

### Usa FeedScreen cuando:
- ✅ Quieres explorar todos los artículos
- ✅ Necesitas buscar por texto
- ✅ Quieres filtrar por categoría
- ✅ Prefieres una vista compacta en grid

---

## Datos de Ejemplo

### HomeScreen (3 artículos + 2 reseñas)
```dart
Articulos:
1. "Artículo de prueba 1" (cultura)
2. "Artículo de prueba 2" (tecnología)
3. "Artículo de prueba 3" (deportes)

Reviews:
1. Juan - ⭐⭐⭐⭐⭐ - "Excelente artículo"
2. María - ⭐⭐⭐⭐ - "Muy bueno"
```

### FeedScreen (6 artículos)
```dart
Paisajes:
1. "Valle del Cocora"
2. "Montañas Nevadas"

Playas:
1. "Playa Blanca"

Cultural:
1. "Centro Histórico"
2. "Catedral Metropolitana"

Hoteles:
1. "Resort de Lujo"
```

---

## Componentes Compartidos

| Componente | HomeScreen | FeedScreen |
|---|---|---|
| `Articulo` model | ✅ | ✅ |
| `Review` model | ✅ | ✅ |
| Color scheme | ✅ | ✅ |
| Material 3 | ✅ | ✅ |

---

## Componentes Únicos

### HomeScreen
- `HomeHeader` - Header con avatar
- `ProfileAvatar` - Avatar circular
- `FilterBar` - Barra de filtros
- `ArticuloCard` - Tarjeta en lista
- `HomeToggle` - Toggle Todos/Siguiendo
- `ReviewCardHome` - Tarjeta de reseña

### FeedScreen
- `FeedSearchBar` - Barra de búsqueda
- `MapCard` - Tarjeta de mapa
- `CategoryChips` - Chips de categoría
- `FilterChipItem` - Chip individual
- `ArticuloGrid` - Grid de 2 columnas
- `ArticuloGridCard` - Tarjeta en grid

---

## Métricas

| Métrica | HomeScreen | FeedScreen |
|---|---|---|
| Líneas de código | 450+ | 400+ |
| Componentes | 7 | 7 |
| Modelos usados | 2 | 2 |
| Estados | 4 | 4 |
| Datos de ejemplo | 5 | 6 |

---

## Rendimiento

| Aspecto | HomeScreen | FeedScreen |
|---|---|---|
| Scroll performance | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Filtrado | ⚡ Instant | ⚡ Instant |
| Grid rendering | N/A | ⭐⭐⭐⭐ |
| Búsqueda | N/A | ⚡ Instant |

---

## Personalización

### HomeScreen
- Cambiar toggle (Todos/Siguiendo)
- Agregar más artículos
- Modificar tarjetas de artículo
- Cambiar avatar

### FeedScreen
- Agregar categorías
- Cambiar número de columnas
- Ajustar tamaño de grid
- Personalizar chips

---

## Integración con API

### HomeScreen
```dart
// GET /api/articulos
// GET /api/reviews
```

### FeedScreen
```dart
// GET /api/articulos?categoria=xxx
// GET /api/articulos?search=xxx
```

---

## Navegación Entre Ellas

```dart
// Desde HomeScreen a FeedScreen
Navigator.pushNamed(context, '/feed');

// Desde FeedScreen a HomeScreen
Navigator.pushNamed(context, '/home');

// Con BottomNavigationBar (recomendado)
// Ver NAVIGATION_GUIDE.md
```

---

## Recomendación para Producción

Para una app profesional, implementa:

1. ✅ HomeScreen + FeedScreen (ya hecho)
2. ⏳ MainScreen con BottomNavigationBar
3. ⏳ Pantalla de detalles de artículo
4. ⏳ State management (Provider/Riverpod)
5. ⏳ Conectar con API real
6. ⏳ Caché local (Hive)
7. ⏳ Pantalla de perfil
8. ⏳ Sistema de favoritos

---

**¿Cuál es tu caso de uso?**

- 🏠 Si quieres feed personalizado → HomeScreen
- 🔍 Si quieres explorar → FeedScreen
- 🎯 Si quieres ambas → Implementa BottomNavigationBar

Ver [NAVIGATION_GUIDE.md](NAVIGATION_GUIDE.md) para detalles.

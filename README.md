# 🎵 Beatzy - Aplicación de Música con Diseño Liquid Glass

Beatzy es una aplicación de música moderna inspirada en Apple Music, construida con Flutter y diseñada con el nuevo estilo "Liquid Glass" de iOS 26. La aplicación combina una interfaz elegante con efectos de glassmorphism y animaciones fluidas para crear una experiencia de usuario excepcional.

## ✨ Características

### 🎨 Diseño Liquid Glass
- **Efectos Glassmorphism**: Tarjetas con efecto de cristal translúcido
- **Gradientes Dinámicos**: Colores líquidos que cambian suavemente
- **Animaciones Fluidas**: Transiciones suaves y efectos de hover
- **Tema Oscuro**: Diseño optimizado para modo oscuro

### 🎵 Funcionalidades de Música
- **Reproductor de Audio**: Control completo de reproducción
- **Playlists**: Creación y gestión de listas de reproducción
- **Biblioteca de Música**: Organización de canciones y álbumes
- **Búsqueda**: Encuentra tu música favorita rápidamente
- **Controles de Reproducción**: Play, pause, siguiente, anterior, shuffle, repeat

### 📱 Interfaz de Usuario
- **Navegación Intuitiva**: Barra de navegación inferior moderna
- **Tarjetas Interactivas**: Elementos táctiles con feedback visual
- **Reproductor Flotante**: Control de música siempre accesible
- **Pantalla Completa**: Modo de reproducción inmersivo

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo multiplataforma
- **Provider**: Gestión de estado de la aplicación
- **Just Audio**: Reproducción de audio
- **Cached Network Image**: Carga y cacheo de imágenes
- **Flutter Animate**: Animaciones fluidas
- **Glassmorphism**: Efectos de cristal

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  just_audio: ^0.9.38
  audio_session: ^0.1.18
  cached_network_image: ^3.3.1
  flutter_animate: ^4.5.0
  glassmorphism: ^3.0.0
  blur: ^3.1.0
  flutter_staggered_grid_view: ^0.7.0
  shimmer: ^3.0.0
  intl: ^0.19.0
  shared_preferences: ^2.2.3
```

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK (versión 3.8.1 o superior)
- Dart SDK
- Android Studio / VS Code
- Dispositivo iOS/Android o emulador

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd beatzy
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

### Configuración de Plataforma

#### iOS
```bash
cd ios
pod install
cd ..
flutter run
```

#### Android
```bash
flutter run
```

## 📁 Estructura del Proyecto

```
lib/
├── constants/
│   ├── app_colors.dart      # Paleta de colores Liquid Glass
│   └── app_theme.dart       # Configuración del tema
├── models/
│   ├── song.dart           # Modelo de datos para canciones
│   └── playlist.dart       # Modelo de datos para playlists
├── providers/
│   └── audio_provider.dart # Gestión del reproductor de audio
├── screens/
│   └── home_screen.dart    # Pantalla principal
├── widgets/
│   ├── glass_card.dart     # Widgets con efecto glassmorphism
│   ├── song_card.dart      # Tarjetas de canciones
│   └── music_player.dart   # Reproductor de música
└── main.dart              # Punto de entrada de la aplicación
```

## 🎨 Paleta de Colores Liquid Glass

```dart
// Colores principales
primary: #007AFF      // Azul iOS
secondary: #5856D6    // Púrpura
accent: #FF2D92       // Rosa vibrante

// Fondos con efecto glass
background: #000000   // Negro puro
surface: #1C1C1E      // Gris oscuro
glassBackground: #1AFFFFFF  // Blanco translúcido

// Gradientes líquidos
liquidGradient: [
  #007AFF,  // Azul
  #5856D6,  // Púrpura
  #FF2D92,  // Rosa
  #FF9500,  // Naranja
]
```

## 🎵 Funcionalidades del Reproductor

### Controles Básicos
- **Play/Pause**: Reproducir o pausar música
- **Siguiente/Anterior**: Navegar entre canciones
- **Shuffle**: Reproducción aleatoria
- **Repeat**: Repetición de canciones

### Características Avanzadas
- **Control de Volumen**: Ajuste dinámico del volumen
- **Seek**: Navegación por la línea de tiempo
- **Playlist Management**: Gestión de listas de reproducción
- **Background Playback**: Reproducción en segundo plano

## 🔧 Personalización

### Modificar Colores
Edita `lib/constants/app_colors.dart` para cambiar la paleta de colores:

```dart
class AppColors {
  static const Color primary = Color(0xFF007AFF);
  static const Color secondary = Color(0xFF5856D6);
  // ... más colores
}
```

### Ajustar Efectos Glass
Modifica `lib/widgets/glass_card.dart` para personalizar los efectos:

```dart
GlassCard(
  blur: 15,           // Intensidad del desenfoque
  opacity: 0.15,      // Opacidad del fondo
  borderRadius: BorderRadius.circular(20),
  // ... más opciones
)
```

## 📱 Capturas de Pantalla

[Incluir capturas de pantalla de la aplicación aquí]

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🙏 Agradecimientos

- **Apple**: Inspiración del diseño iOS 26 Liquid Glass
- **Flutter Team**: Framework de desarrollo
- **Comunidad Flutter**: Librerías y recursos

## 📞 Contacto

- **Desarrollador**: [Tu Nombre]
- **Email**: [tu-email@ejemplo.com]
- **GitHub**: [@tu-usuario]

---

**Beatzy** - Donde la música cobra vida con el diseño del futuro 🎵✨

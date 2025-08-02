import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userProfile = {
    'name': 'Raúl Peredo',
    'email': 'raul@beatzy.com',
    'subscription': 'Premium',
    'joinDate': 'Enero 2024',
    'totalSongs': 1247,
    'totalPlaylists': 23,
    'favoriteGenres': ['Pop', 'Rock', 'Hip Hop'],
  };

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Canciones Escuchadas',
      'value': '1,247',
      'icon': Icons.music_note,
      'color': AppColors.primary,
    },
    {
      'title': 'Horas de Música',
      'value': '342',
      'icon': Icons.timer,
      'color': AppColors.secondary,
    },
    {
      'title': 'Playlists Creadas',
      'value': '23',
      'icon': Icons.playlist_play,
      'color': AppColors.accent,
    },
    {
      'title': 'Artistas Seguidos',
      'value': '156',
      'icon': Icons.person,
      'color': AppColors.warning,
    },
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Configuración',
      'icon': Icons.settings,
      'color': AppColors.primary,
    },
    {
      'title': 'Suscripción',
      'icon': Icons.star,
      'color': AppColors.warning,
    },
    {
      'title': 'Descargas',
      'icon': Icons.download,
      'color': AppColors.success,
    },
    {
      'title': 'Historial',
      'icon': Icons.history,
      'color': AppColors.secondary,
    },
    {
      'title': 'Ayuda',
      'icon': Icons.help,
      'color': AppColors.accent,
    },
    {
      'title': 'Acerca de',
      'icon': Icons.info,
      'color': AppColors.error,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 48,
                      ),
                    ).animate().scale(duration: 600.ms),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      _userProfile['name'],
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      _userProfile['email'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                    
                    const SizedBox(height: 8),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.warning,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _userProfile['subscription'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Géneros Favoritos',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
                    
                    const SizedBox(height: 12),
                    
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _userProfile['favoriteGenres'].map<Widget>((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.glassBorder,
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            genre,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
                  ],
                ),
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estadísticas',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 1200.ms),
                    
                    const SizedBox(height: 12),
                    
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3.0,
                      ),
                      itemCount: _stats.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.glassBorder,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _stats[index]['icon'],
                                color: _stats[index]['color'],
                                size: 28,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _stats[index]['value'],
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _stats[index]['title'],
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 600.ms, delay: (1400 + index * 100).ms);
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Configuración',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 1600.ms),
                    
                    const SizedBox(height: 16),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.glassBorder,
                              width: 0.5,
                            ),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _menuItems[index]['color'].withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _menuItems[index]['icon'],
                                color: _menuItems[index]['color'],
                                size: 20,
                              ),
                            ),
                            title: Text(
                              _menuItems[index]['title'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                            onTap: () {},
                          ),
                        ).animate().fadeIn(duration: 600.ms, delay: (1800 + index * 50).ms);
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      foregroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: AppColors.error,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Cerrar Sesión',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 2200.ms),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
} 
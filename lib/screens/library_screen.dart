import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _playlists = [
    {
      'name': 'Mis Favoritas',
      'songCount': 24,
      'color': AppColors.primary,
      'songs': ['Blinding Lights', 'Levitating', 'Watermelon Sugar'],
    },
    {
      'name': 'Para Correr',
      'songCount': 18,
      'color': AppColors.secondary,
      'songs': ['Dance Monkey', 'Bad Guy', 'Shape of You'],
    },
    {
      'name': 'Relax',
      'songCount': 32,
      'color': AppColors.accent,
      'songs': ['Someone Like You', 'All of Me', 'Say You Won\'t Let Go'],
    },
    {
      'name': 'Party Mix',
      'songCount': 15,
      'color': AppColors.warning,
      'songs': ['Uptown Funk', 'Shake It Off', 'Can\'t Stop the Feeling!'],
    },
    {
      'name': 'Clásicos',
      'songCount': 45,
      'color': AppColors.success,
      'songs': ['Bohemian Rhapsody', 'Hotel California', 'Stairway to Heaven'],
    },
  ];

  final List<Map<String, dynamic>> _albums = [
    {
      'name': 'After Hours',
      'artist': 'The Weeknd',
      'songCount': 14,
      'color': AppColors.primary,
    },
    {
      'name': 'Future Nostalgia',
      'artist': 'Dua Lipa',
      'songCount': 11,
      'color': AppColors.secondary,
    },
    {
      'name': 'Fine Line',
      'artist': 'Harry Styles',
      'songCount': 12,
      'color': AppColors.accent,
    },
    {
      'name': 'When We All Fall Asleep',
      'artist': 'Billie Eilish',
      'songCount': 14,
      'color': AppColors.warning,
    },
    {
      'name': '÷ (Divide)',
      'artist': 'Ed Sheeran',
      'songCount': 16,
      'color': AppColors.success,
    },
  ];

  final List<Map<String, dynamic>> _artists = [
    {
      'name': 'The Weeknd',
      'songCount': 45,
      'color': AppColors.primary,
    },
    {
      'name': 'Dua Lipa',
      'songCount': 32,
      'color': AppColors.secondary,
    },
    {
      'name': 'Harry Styles',
      'songCount': 28,
      'color': AppColors.accent,
    },
    {
      'name': 'Billie Eilish',
      'songCount': 23,
      'color': AppColors.warning,
    },
    {
      'name': 'Ed Sheeran',
      'songCount': 67,
      'color': AppColors.success,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Biblioteca',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ).animate().fadeIn(duration: 600.ms),
                  
                  const SizedBox(height: 20),
                  
                  Container(
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 0.5,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textSecondary,
                      tabs: const [
                        Tab(text: 'Playlists'),
                        Tab(text: 'Álbumes'),
                        Tab(text: 'Artistas'),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                ],
              ),
            ),
            
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPlaylistsTab(),
                  _buildAlbumsTab(),
                  _buildArtistsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _playlists.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.glassBorder,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _playlists[index]['color'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.playlist_play,
                      color: _playlists[index]['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _playlists[index]['name'],
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_playlists[index]['songCount']} canciones',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow,
                      color: _playlists[index]['color'],
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _playlists[index]['songs'].map<Widget>((song) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      song,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: (index * 100).ms);
      },
    );
  }

  Widget _buildAlbumsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _albums.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.glassBorder,
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _albums[index]['color'].withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Icon(
                    Icons.album,
                    color: _albums[index]['color'],
                    size: 48,
                  ),
                ),
              ),
              Padding(
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _albums[index]['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _albums[index]['artist'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_albums[index]['songCount']} canciones',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: (index * 100).ms);
      },
    );
  }

  Widget _buildArtistsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _artists.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.glassBorder,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _artists[index]['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.person,
                  color: _artists[index]['color'],
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _artists[index]['name'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_artists[index]['songCount']} canciones',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow,
                  color: _artists[index]['color'],
                  size: 24,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: (index * 100).ms);
      },
    );
  }
} 
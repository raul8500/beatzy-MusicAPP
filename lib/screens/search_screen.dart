import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _trendingSongs = [
    {
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'album': 'After Hours',
      'color': AppColors.primary,
    },
    {
      'title': 'Levitating',
      'artist': 'Dua Lipa',
      'album': 'Future Nostalgia',
      'color': AppColors.secondary,
    },
    {
      'title': 'Watermelon Sugar',
      'artist': 'Harry Styles',
      'album': 'Fine Line',
      'color': AppColors.accent,
    },
    {
      'title': 'Dance Monkey',
      'artist': 'Tones and I',
      'album': 'The Kids Are Coming',
      'color': AppColors.warning,
    },
    {
      'title': 'Bad Guy',
      'artist': 'Billie Eilish',
      'album': 'When We All Fall Asleep',
      'color': AppColors.success,
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'album': '÷ (Divide)',
      'color': AppColors.error,
    },
  ];

  final List<Map<String, dynamic>> _genres = [
    {'name': 'Pop', 'icon': Icons.music_note, 'color': AppColors.primary},
    {'name': 'Rock', 'icon': Icons.music_note, 'color': AppColors.secondary},
    {'name': 'Hip Hop', 'icon': Icons.headphones, 'color': AppColors.accent},
    {'name': 'Jazz', 'icon': Icons.piano, 'color': AppColors.warning},
    {'name': 'Classical', 'icon': Icons.music_note, 'color': AppColors.success},
    {'name': 'Electronic', 'icon': Icons.speaker, 'color': AppColors.error},
    {'name': 'Country', 'icon': Icons.music_note, 'color': AppColors.primary},
    {'name': 'R&B', 'icon': Icons.music_note, 'color': AppColors.secondary},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Buscar',
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
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.glassBorder,
                          width: 0.5,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _isSearching = value.isNotEmpty;
                          });
                        },
                        style: const TextStyle(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Buscar canciones, artistas, álbumes...',
                          hintStyle: TextStyle(color: AppColors.textSecondary),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  ],
                ),
              ),
              
                          Expanded(
              child: _isSearching ? _buildSearchResults() : _buildBrowseContent(),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Géneros',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          
          const SizedBox(height: 16),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: _genres.length,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _genres[index]['icon'],
                        color: _genres[index]['color'],
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _genres[index]['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: (600 + index * 50).ms);
            },
          ),
          
          const SizedBox(height: 32),
          
          Text(
            'Tendencias',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
          
          const SizedBox(height: 16),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _trendingSongs.length,
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _trendingSongs[index]['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _trendingSongs[index]['color'],
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _trendingSongs[index]['title'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _trendingSongs[index]['artist'],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _trendingSongs[index]['album'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_arrow,
                        color: _trendingSongs[index]['color'],
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms, delay: (1000 + index * 50).ms);
            },
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final filteredSongs = _trendingSongs.where((song) {
      final query = _searchController.text.toLowerCase();
      return song['title'].toLowerCase().contains(query) ||
             song['artist'].toLowerCase().contains(query) ||
             song['album'].toLowerCase().contains(query);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredSongs.length,
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: filteredSongs[index]['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.music_note,
                  color: filteredSongs[index]['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filteredSongs[index]['title'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      filteredSongs[index]['artist'],
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
                  color: filteredSongs[index]['color'],
                  size: 24,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms);
      },
    );
  }
} 
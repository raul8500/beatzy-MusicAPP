import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/audio_provider.dart';
import '../constants/app_colors.dart';
import 'glass_card.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final currentSong = audioProvider.currentSong;
        
        if (currentSong == null) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 80,
          margin: const EdgeInsets.all(16),
          child: LiquidGlassCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.glassShadow,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: currentSong.albumArt,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.music_note,
                          color: AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surface,
                        child: const Icon(
                          Icons.music_note,
                          color: AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentSong.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      Text(
                        currentSong.artist,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: audioProvider.previous,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: AppColors.textSecondary,
                        size: 28,
                      ),
                    ),
                    
                    Container(
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: AppColors.liquidGradient,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (audioProvider.isPlaying) {
                            audioProvider.pause();
                          } else {
                            audioProvider.play();
                          }
                        },
                        icon: Icon(
                          audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.textPrimary,
                          size: 24,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    
                    IconButton(
                      onPressed: audioProvider.next,
                      icon: const Icon(
                        Icons.skip_next,
                        color: AppColors.textSecondary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().slideY(
          begin: 1.0,
          duration: 300.ms,
          curve: Curves.easeOutCubic,
        );
      },
    );
  }
}

class FullScreenMusicPlayer extends StatefulWidget {
  const FullScreenMusicPlayer({super.key});

  @override
  State<FullScreenMusicPlayer> createState() => _FullScreenMusicPlayerState();
}

class _FullScreenMusicPlayerState extends State<FullScreenMusicPlayer>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final currentSong = audioProvider.currentSong;
        
        if (currentSong == null) {
          return const SizedBox.shrink();
        }

            if (audioProvider.isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
    }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textPrimary,
                          size: 32,
                        ),
                      ),
                      
                      Column(
                        children: [
                          Text(
                            'Reproduciendo',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'desde Beatzy',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Expanded(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _rotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value * 2 * 3.14159,
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: currentSong.albumArt,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: AppColors.surface,
                                    child: const Icon(
                                      Icons.music_note,
                                      color: AppColors.textSecondary,
                                      size: 64,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: AppColors.surface,
                                    child: const Icon(
                                      Icons.music_note,
                                      color: AppColors.textSecondary,
                                      size: 64,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  Column(
                    children: [
                      Text(
                        currentSong.title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        currentSong.artist,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                                        const SizedBox(height: 32),
                  
                  Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primary,
                              inactiveTrackColor: AppColors.surface,
                              thumbColor: AppColors.primary,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12,
                              ),
                            ),
                            child: Slider(
                              value: audioProvider.position.inSeconds.toDouble(),
                              max: audioProvider.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                audioProvider.seekTo(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(audioProvider.position),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  _formatDuration(audioProvider.duration),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                  const SizedBox(height: 32),
                  
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: audioProvider.toggleShuffle,
                            icon: Icon(
                              Icons.shuffle,
                              color: audioProvider.isShuffled 
                                ? AppColors.primary 
                                : AppColors.textSecondary,
                              size: 28,
                            ),
                          ),
                          
                          IconButton(
                            onPressed: audioProvider.previous,
                            icon: const Icon(
                              Icons.skip_previous,
                              color: AppColors.textPrimary,
                              size: 32,
                            ),
                          ),
                          
                          GestureDetector(
                          GestureDetector(
                            onTapDown: (_) => _scaleController.forward(),
                            onTapUp: (_) => _scaleController.reverse(),
                            onTapCancel: () => _scaleController.reverse(),
                            onTap: () {
                              if (audioProvider.isPlaying) {
                                audioProvider.pause();
                              } else {
                                audioProvider.play();
                              }
                            },
                            child: AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: AppColors.liquidGradient,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                                      color: AppColors.textPrimary,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          IconButton(
                            onPressed: audioProvider.next,
                            icon: const Icon(
                              Icons.skip_next,
                              color: AppColors.textPrimary,
                              size: 32,
                            ),
                          ),
                          
                          IconButton(
                            onPressed: audioProvider.toggleRepeat,
                            icon: Icon(
                              Icons.repeat,
                              color: audioProvider.isRepeating 
                                ? AppColors.primary 
                                : AppColors.textSecondary,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
} 
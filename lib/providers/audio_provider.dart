import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../models/song.dart';

enum PlaybackState { stopped, playing, paused, loading, error }

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  Song? _currentSong;
  PlaybackState _playbackState = PlaybackState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isShuffled = false;
  bool _isRepeating = false;
  List<Song> _playlist = [];
  int _currentIndex = 0;
  double _volume = 1.0;

  Song? get currentSong => _currentSong;
  PlaybackState get playbackState => _playbackState;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isShuffled => _isShuffled;
  bool get isRepeating => _isRepeating;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  double get volume => _volume;
  bool get isPlaying => _playbackState == PlaybackState.playing;
  bool get isPaused => _playbackState == PlaybackState.paused;
  bool get isLoading => _playbackState == PlaybackState.loading;

  AudioProvider() {
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.music,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      )      );

      _audioPlayer.playerStateStream.listen((state) {
        _updatePlaybackState(state);
      });

      _audioPlayer.positionStream.listen((position) {
        _position = position;
        notifyListeners();
      });

      _audioPlayer.durationStream.listen((duration) {
        _duration = duration ?? Duration.zero;
        notifyListeners();
      });

      _audioPlayer.volumeStream.listen((volume) {
        _volume = volume;
        notifyListeners();
      });

    } catch (e) {
      _playbackState = PlaybackState.error;
      notifyListeners();
    }
  }

  void _updatePlaybackState(PlayerState state) {
    switch (state.processingState) {
      case ProcessingState.idle:
        _playbackState = PlaybackState.stopped;
        break;
      case ProcessingState.loading:
        _playbackState = PlaybackState.loading;
        break;
      case ProcessingState.buffering:
        _playbackState = PlaybackState.loading;
        break;
      case ProcessingState.ready:
        _playbackState = state.playing ? PlaybackState.playing : PlaybackState.paused;
        break;
      case ProcessingState.completed:
        _playbackState = PlaybackState.stopped;
        _handlePlaybackCompleted();
        break;
    }
    notifyListeners();
  }

  void _handlePlaybackCompleted() {
    if (_isRepeating) {
      seekTo(Duration.zero);
      play();
    } else {
      next();
    }
  }
  Future<void> play() async {
    if (_currentSong == null) return;
    
    try {
      await _audioPlayer.play();
    } catch (e) {
      _playbackState = PlaybackState.error;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      _playbackState = PlaybackState.error;
      notifyListeners();
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _position = Duration.zero;
    } catch (e) {
      _playbackState = PlaybackState.error;
      notifyListeners();
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
      _volume = volume.clamp(0.0, 1.0);
      notifyListeners();
    } catch (e) {
    }
  }

  Future<void> loadPlaylist(List<Song> songs, {int startIndex = 0}) async {
    _playlist = songs;
    _currentIndex = startIndex.clamp(0, songs.length - 1);
    
    if (songs.isNotEmpty) {
      await loadSong(_playlist[_currentIndex]);
    }
  }

  Future<void> loadSong(Song song) async {
    try {
      _playbackState = PlaybackState.loading;
      _currentSong = song;
      notifyListeners();

      await _audioPlayer.setUrl(song.audioUrl);
      await play();
    } catch (e) {
      _playbackState = PlaybackState.error;
      notifyListeners();
    }
  }

  Future<void> next() async {
    if (_playlist.isEmpty) return;
    
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await loadSong(_playlist[_currentIndex]);
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;
    
    _currentIndex = (_currentIndex - 1) % _playlist.length;
    if (_currentIndex < 0) _currentIndex = _playlist.length - 1;
    await loadSong(_playlist[_currentIndex]);
  }

  void toggleShuffle() {
    _isShuffled = !_isShuffled;
    if (_isShuffled) {
    }
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeating = !_isRepeating;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
} 
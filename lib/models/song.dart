class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumArt;
  final Duration duration;
  final String audioUrl;
  final List<String> genres;
  final int year;
  final bool isExplicit;
  final double rating;
  final int playCount;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumArt,
    required this.duration,
    required this.audioUrl,
    this.genres = const [],
    this.year = 0,
    this.isExplicit = false,
    this.rating = 0.0,
    this.playCount = 0,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      album: json['album'] ?? '',
      albumArt: json['albumArt'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
      audioUrl: json['audioUrl'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      year: json['year'] ?? 0,
      isExplicit: json['isExplicit'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      playCount: json['playCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'albumArt': albumArt,
      'duration': duration.inSeconds,
      'audioUrl': audioUrl,
      'genres': genres,
      'year': year,
      'isExplicit': isExplicit,
      'rating': rating,
      'playCount': playCount,
    };
  }

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? albumArt,
    Duration? duration,
    String? audioUrl,
    List<String>? genres,
    int? year,
    bool? isExplicit,
    double? rating,
    int? playCount,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArt: albumArt ?? this.albumArt,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      genres: genres ?? this.genres,
      year: year ?? this.year,
      isExplicit: isExplicit ?? this.isExplicit,
      rating: rating ?? this.rating,
      playCount: playCount ?? this.playCount,
    );
  }
} 
import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final AudioPlayer _player = AudioPlayer();

  static bool _initialized = false;
  static bool _isPlaying = false;
  static double _volume = 0.5;

  /// 🔰 INIT (alias of start) – call once on app start
  static Future<void> init() async {
    await start();
  }

  /// ▶️ Start background music (loop, safe once only)
  static Future<void> start() async {
    if (_initialized) return;

    _initialized = true;
    _isPlaying = true;

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(_volume);
    await _player.play(
      AssetSource('audio/bg_music.mp3'),
    );
  }

  /// 🔊 Toggle play / pause
  static Future<void> toggleMusic() async {
    if (!_initialized) return;

    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    _isPlaying = !_isPlaying;
  }

  /// ⏸ Pause music
  static Future<void> pause() async {
    if (!_isPlaying) return;
    await _player.pause();
    _isPlaying = false;
  }

  /// ▶ Resume music
  static Future<void> resume() async {
    if (_isPlaying) return;
    await _player.resume();
    _isPlaying = true;
  }

  /// 🎚️ Set volume (0.0 – 1.0)
  static Future<void> setVolume(double value) async {
    _volume = value.clamp(0.0, 1.0);
    await _player.setVolume(_volume);
  }

  /// ⏹ Stop music completely (reset)
  static Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
    _initialized = false;
  }

  /// 🔍 Getters
  static bool get isPlaying => _isPlaying;
  static double get volume => _volume;
}

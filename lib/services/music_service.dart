import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final AudioPlayer _player = AudioPlayer();

  static bool _isPlaying = false;
  static bool _initialized = false;
  static double _volume = 0.5;

  /// ▶️ Start background music (LOOP, once only)
  static Future<void> start() async {
    if (_initialized) return; // ❗ prevent double start

    _initialized = true;
    _isPlaying = true;

    await _player.setReleaseMode(ReleaseMode.loop); // 🔁 LOOP FOREVER
    await _player.setVolume(_volume);
    await _player.play(
      AssetSource('audio/bg_music.mp3'),
    );
  }

  /// 🔊 Toggle play / pause
  static Future<void> toggleMusic() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    _isPlaying = !_isPlaying;
  }

  /// 🎚️ Set volume (0.0 – 1.0)
  static Future<void> setVolume(double value) async {
    _volume = value;
    await _player.setVolume(_volume);
  }

  /// ⏹️ Stop music completely (optional)
  static Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
    _initialized = false;
  }

  /// 🔍 Getters
  static bool get isPlaying => _isPlaying;
  static double get volume => _volume;
}

import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = true;
  static double _volume = 0.5;

  static Future<void> start() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(_volume);
    await _player.play(AssetSource('audio/bg_music.mp3'));
  }

  static void toggleMusic() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.resume();
    }
    _isPlaying = !_isPlaying;
  }

  static void setVolume(double value) {
    _volume = value;
    _player.setVolume(_volume);
  }

  static bool get isPlaying => _isPlaying;
  static double get volume => _volume;
}

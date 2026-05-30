import 'package:just_audio/just_audio.dart';
import 'package:teneffus/constants.dart';

class SoundManager {
  SoundManager._();

  static final SoundManager instance = SoundManager._();

  final AudioPlayer _player = AudioPlayer();

  bool _initialized = false;
  bool _isPlaying = false;

  Future<void> init() async {
    if (_initialized) return;

    await _player.setAsset(clickSoundPath);
    await _player.setLoopMode(LoopMode.off);

    _initialized = true;
  }

  Future<void> playClick() async {
    if (!_initialized) await init();

    try {
      // 🔥 CRITICAL FIX
      if (_isPlaying) {
        await _player.stop();
      }

      _isPlaying = true;

      await _player.seek(Duration.zero);
      await _player.play();

      // reset flag after short delay
      Future.delayed(const Duration(milliseconds: 120), () {
        _isPlaying = false;
      });
    } catch (_) {
      _isPlaying = false;
    }
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
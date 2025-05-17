import 'package:just_audio/just_audio.dart';
import 'package:teneffus/constants.dart';

Future<void> playAudio(String audioUrl, AudioPlayer player) async {
  await player.stop();
  Future.delayed(const Duration(milliseconds: 400), () async {
    await player.setAudioSource(AudioSource.asset(audioUrl));
    await player.play();
  });
}

Future<Null> playCorrectSound(AudioPlayer sfxPlayer) {
  return Future.microtask(() async {
    await sfxPlayer.stop();
    sfxPlayer.setAudioSource(AudioSource.asset(correctSoundPath));
    sfxPlayer.play();
  });
}

Future<Null> playWrongSound(AudioPlayer sfxPlayer) {
  return Future.microtask(() async {
    await sfxPlayer.stop();
    sfxPlayer.setAudioSource(AudioSource.asset(wrongSoundPath));
    sfxPlayer.play();
  });
}

import 'package:just_audio/just_audio.dart';

Future<void> playAudio(String audioUrl, AudioPlayer player) async {
  await player.stop();
  Future.delayed(const Duration(milliseconds: 400), () async {
    await player.setAudioSource(AudioSource.asset(audioUrl));
    await player.play();
  });
}

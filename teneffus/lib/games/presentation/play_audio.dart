import 'package:audio_session/audio_session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teneffus/constants.dart';

final sfxPlayerProvider = Provider<AudioPlayer>((ref) {
  final sfxPlayer = AudioPlayer();
  sfxPlayer.setAndroidAudioAttributes(const AndroidAudioAttributes(
    contentType: AndroidAudioContentType.sonification,
    usage: AndroidAudioUsage.notification,
  ));
  return sfxPlayer;
});

final listeningPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();

  player.setAndroidAudioAttributes(const AndroidAudioAttributes(
    contentType: AndroidAudioContentType.music,
    usage: AndroidAudioUsage.notification,
  ));

  return player;
});

Future<void> playAudio(String audioUrl, AudioPlayer player) async {
  await player.stop();
  Future.delayed(const Duration(milliseconds: 400), () async {
    await player.setAsset(audioUrl);
    await player.play();
  });
}

Future<Null> playCorrectSound(AudioPlayer player) {
  return Future.microtask(() async {
    await player.stop();
    await player.setAsset(correctSoundPath);
    await player.play();
  });
}

Future<Null> playWrongSound(AudioPlayer player) {
  return Future.microtask(() async {
    await player.stop();
    await player.setAsset(wrongSoundPath);
    await player.play();
  });
}

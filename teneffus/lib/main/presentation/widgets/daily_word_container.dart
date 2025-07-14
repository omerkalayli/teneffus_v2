import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teneffus/games/presentation/play_audio.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_entities/word.dart';
import 'package:teneffus/global_widgets/custom_button.dart';

/// This widget is used to display the daily word container.

class DailyWordContainer extends HookConsumerWidget {
  const DailyWordContainer({
    required this.word,
    super.key,
  });

  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = useState(false);
    final player = useMemoized(() => AudioPlayer(), []);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Günün Kelimesi",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(word.imagePath,
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      word.ar,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      word.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  borderColor: Colors.blue,
                  disableOnPressedForegroundColor: true,
                  buttonPalette: ButtonPalette.white(),
                  onPressed: () async {
                    if (isPlaying.value) {
                      return;
                    }
                    isPlaying.value = true;
                    await playAudio(word.audioUrl, player);
                  },
                  child: Assets.images.listening2.image(
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      color: Colors.blue),
                ),
              ],
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}

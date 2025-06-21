import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/auth/presentation/auth_notifier.dart';
import 'package:teneffus/avatars.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/global_widgets/custom_scaffold.dart';

class AvatarSelectionPage extends HookConsumerWidget {
  const AvatarSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAvatarIndex = useState<int>(
      ref.watch(studentInformationProvider)?.avatarId ?? 0,
    );

    return CustomScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26,
          ),
          onPressed: () async {
            await ref
                .read(authNotifierProvider.notifier)
                .updateAvatar(avatarId: selectedAvatarIndex.value);

            Navigator.pop(context);
          },
          color: textColor,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Avatar Seçimi",
          style: GoogleFonts.montserrat(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    switchInCurve: Curves.easeInOutExpo,
                    switchOutCurve: Curves.easeInOutExpo,
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: SizedBox(
                      key: ValueKey<int>(selectedAvatarIndex.value),
                      width: 120,
                      height: 120,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(
                            shuffledAvatars[selectedAvatarIndex.value]!.isBig
                                ? 20
                                : 8.0,
                          ),
                          child: shuffledAvatars[selectedAvatarIndex.value]!
                              .image
                              .image(
                                width: 96,
                                height: 96,
                                fit: BoxFit.contain,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: AutoSizeText(
                      maxLines: 2,
                      shuffledAvatars[selectedAvatarIndex.value]!.description,
                      style: GoogleFonts.montserrat(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(shuffledAvatars.length, (index) {
                        bool isBig = shuffledAvatars[index]!.isBig;
                        return GestureDetector(
                          onTap: () => selectedAvatarIndex.value = index,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedAvatarIndex.value == index
                                    ? textColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: EdgeInsets.all(isBig ? 20 : 8.0),
                                child: shuffledAvatars[index]!.image.image(
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.contain,
                                    ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

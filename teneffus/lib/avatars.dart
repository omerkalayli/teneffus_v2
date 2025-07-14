import 'package:teneffus/avatar_info.dart';
import 'package:teneffus/gen/assets.gen.dart';

Map<int, AvatarInfo> avatars = {
  0: AvatarInfo(
    id: 0,
    image: Assets.avatars.king,
    description: "Krallar için.",
  ),
  1: AvatarInfo(
    id: 1,
    image: Assets.avatars.weightlifting,
    description: "Halter kaldıran adam.",
  ),
  2: AvatarInfo(
    id: 2,
    image: Assets.avatars.ghost,
    description: "Bu bir hayalet.",
  ),
  3: AvatarInfo(
    id: 3,
    image: Assets.avatars.jinn,
    description: "Hayır, daha fazla dilek hakkı dileyemezsin.",
  ),
  4: AvatarInfo(
    id: 4,
    image: Assets.avatars.corvette,
    description: "Corvette.",
  ),
  5: AvatarInfo(
    id: 5,
    image: Assets.avatars.wizard,
    description: "You shall pass.",
  ),
  6: AvatarInfo(
    id: 6,
    image: Assets.avatars.robot,
    description: "Robot olmadığını onayla lütfen.",
  ),
  7: AvatarInfo(
    id: 7,
    image: Assets.avatars.frog,
    description: "Bu bir kurbağa.",
  ),
  8: AvatarInfo(
    id: 8,
    image: Assets.avatars.owl,
    description: "Bunun bir baykuş çizimi olduğu söyleniyor.",
  ),
  9: AvatarInfo(
    id: 9,
    image: Assets.avatars.winner,
    description: "Zafer!",
  ),
  10: AvatarInfo(
    id: 10,
    image: Assets.avatars.nerd,
    description: "Dört-göz.",
  ),
  11: AvatarInfo(
    id: 11,
    image: Assets.avatars.butterfly,
    description: "Kebelek.",
  ),
  12: AvatarInfo(
    id: 12,
    image: Assets.avatars.dinosaur,
    description: "Dino.",
  ),
  13: AvatarInfo(
    id: 13,
    image: Assets.avatars.mindblown,
    description: "Aydınlanma yaşadım resmen.",
  ),
  14: AvatarInfo(
    id: 14,
    image: Assets.avatars.kiss,
    description: "Muah!",
  ),
  15: AvatarInfo(
    id: 15,
    image: Assets.avatars.lotus,
    description: "Lotus çiçeği.",
  ),
  16: AvatarInfo(
    id: 16,
    image: Assets.avatars.cartwheel,
    description: "Takla.",
  ),
  17: AvatarInfo(
    id: 17,
    image: Assets.avatars.smile,
    description: "Gülümseme.",
  ),
  18: AvatarInfo(
    id: 18,
    image: Assets.avatars.approval,
    description: "Tm.",
  ),
  19: AvatarInfo(
    id: 19,
    image: Assets.avatars.cat,
    description: "Bi' kedi gördüm sanki!",
  ),
  20: AvatarInfo(
    id: 20,
    image: Assets.avatars.heart,
    description: "Kalp kalp kalp.",
    isBig: true,
  ),
  21: AvatarInfo(
    id: 21,
    image: Assets.avatars.superhero,
    description: "Baydırman. O bir süper kahraman.",
  ),
  22: AvatarInfo(
    id: 22,
    image: Assets.avatars.hiking,
    description: "Sonunda!",
  ),
  23: AvatarInfo(
    id: 23,
    image: Assets.avatars.dance,
    description: "Bir dansa ne dersin?",
  ),
  24: AvatarInfo(
    id: 24,
    image: Assets.avatars.rocket,
    description: "Orada görüşürüz.",
    isBig: true,
  ),
  25: AvatarInfo(
    id: 25,
    image: Assets.avatars.ship,
    description: "Kara göründü!",
    isBig: true,
  ),
  26: AvatarInfo(
      id: 26,
      image: Assets.avatars.sofa,
      description: "Sadece bir koltuk.",
      isBig: true),
  27: AvatarInfo(
      id: 27,
      image: Assets.avatars.bug,
      description: "Oyunun \"bug\"'ını buldun.",
      isBig: true),
  28: AvatarInfo(
      id: 28, image: Assets.avatars.bot, description: ":/", isBig: true),
  29: AvatarInfo(
      id: 29,
      image: Assets.avatars.snowman,
      description: "Kardan bir adam.",
      isBig: true),
  30: AvatarInfo(
      id: 30,
      image: Assets.avatars.perfect,
      description: "Mükemmel.",
      isBig: true),
  31: AvatarInfo(
      id: 31, image: Assets.avatars.tv, description: "TV.", isBig: true),
  32: AvatarInfo(
      id: 32,
      image: Assets.avatars.camera,
      description: "Fotoğraf makinesi.",
      isBig: true),
  33: AvatarInfo(
    id: 33,
    image: Assets.avatars.profile,
    description: "Klasik ve sıkıcı.",
    isBig: true,
  ),
};

Map<int, AvatarInfo> shuffledAvatars = {
  0: avatars[33]!,
  1: avatars[10]!,
  2: avatars[6]!,
  3: avatars[15]!,
  4: avatars[14]!,
  5: avatars[30]!,
  6: avatars[4]!,
  7: avatars[5]!,
  8: avatars[3]!,
  9: avatars[27]!,
  10: avatars[8]!,
  11: avatars[17]!,
  12: avatars[2]!,
  13: avatars[19]!,
  14: avatars[0]!,
  15: avatars[7]!,
  16: avatars[24]!,
  17: avatars[23]!,
  18: avatars[28]!,
  19: avatars[12]!,
  20: avatars[20]!,
  21: avatars[13]!,
  22: avatars[9]!,
  23: avatars[16]!,
  24: avatars[26]!,
  25: avatars[11]!,
  26: avatars[18]!,
  27: avatars[31]!,
  28: avatars[29]!,
  29: avatars[25]!,
  30: avatars[21]!,
  31: avatars[32]!,
  32: avatars[1]!,
  33: avatars[22]!,
};

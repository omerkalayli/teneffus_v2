import 'package:teneffus/gen/assets.gen.dart';

class AvatarInfo {
  final int id;
  final AssetGenImage image;
  final String description;
  final bool isBig;

  const AvatarInfo({
    required this.id,
    required this.image,
    required this.description,
    this.isBig = false,
  });
}

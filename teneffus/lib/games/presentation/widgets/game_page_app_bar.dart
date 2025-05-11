import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePageAppBar extends StatelessWidget {
  const GamePageAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: GoogleFonts.montserrat(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left_rounded,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
    );
  }
}

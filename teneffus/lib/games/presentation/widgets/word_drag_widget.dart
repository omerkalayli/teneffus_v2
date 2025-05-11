import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordDragWidget extends StatelessWidget {
  const WordDragWidget({
    super.key,
    this.isDropped = false,
    this.isTransparent = false,
    required this.text,
  });

  final bool isDropped;
  final bool isTransparent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isTransparent
            ? Colors.transparent
            : isDropped
                ? const Color.fromARGB(121, 255, 255, 255)
                : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            color: isTransparent ? Colors.transparent : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}

// Bu kod, orijinal kodun daha iyi hizalanmış ve stilize edilmiş halidir.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teneffus/quiz/domain/quiz_progress.dart';

class ContinueQuizCard extends StatelessWidget {
 final QuizProgress progress;
 final int totalQuestions;
 final VoidCallback onTap;

 const ContinueQuizCard({
  super.key,
  required this.progress,
  required this.totalQuestions,
  required this.onTap,
 });

 @override
 Widget build(BuildContext context) {
  final progressValue = (progress.questionIndex) / totalQuestions;

  return GestureDetector(
   onTap: onTap,
   child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
     // Ekranın üstündeki kartlara daha yakın köşeler
     borderRadius: BorderRadius.circular(20),
     gradient: const LinearGradient(
      colors: [
       Color(0xff2ec4b6), // Biraz daha parlak bir başlangıç
       Color(0xff18b5b5),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
     ),
     boxShadow: [
      BoxShadow(
       color: const Color(0xff2ec4b6).withOpacity(.3),
       blurRadius: 18,
       offset: const Offset(0, 8),
      ),
     ],
    ),
    child: Row(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [

      Container(
       padding: const EdgeInsets.all(12),
       decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(16),
       ),
       child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 32, // Biraz daha büyük
       ),
      ),

      const SizedBox(width: 16),

      Expanded(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           
         Text(
          "Kaldığın Yerden Devam Et",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
           color: Colors.white,
           fontSize: 16,
           fontWeight: FontWeight.w800,
          ),
         ),

             Text(
          getQuizTypeText(progress.progressType),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
           color: Colors.white,
           fontSize: 14,
           fontWeight: FontWeight.w600,
          ),
         ),
         Text(
          "Ünite ${progress.unitNumber} • ${progress.questionIndex}. Soru • ${progress.lessonNumber == -1 ? "Tüm Konular" : "${progress.lessonNumber}"}",
          style: GoogleFonts.montserrat(
           color: Colors.white.withOpacity(.85),
           fontSize: 12,
           fontWeight: FontWeight.w500,
          ),
         ),

         const Gap(12),

         SizedBox(
          width: double.infinity,
          height: 2,
          child: ClipRRect(
           borderRadius: BorderRadius.circular(99),
           child: LinearProgressIndicator(
            value: progressValue.clamp(0.0, 1.0),
            backgroundColor: Colors.white.withOpacity(.25),
            valueColor: const AlwaysStoppedAnimation(Colors.white),
           ),
          ),
         ),
        ],
       ),
      ),

     ],
    ),
   ),
  );
 }
}


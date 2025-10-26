import 'package:flutter/material.dart';

class LessonView extends StatelessWidget {

 final String title;
  final String duration;
  final bool isLocked;
  final bool isPreview;
  final bool isQuiz;
  const LessonView({
    super.key,
    required this.title,
    required this.duration,
    this.isLocked = false,
    this.isPreview = false,
    this.isQuiz = false,
  });
  
 @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isQuiz ? Icons.quiz_outlined : Icons.play_circle_fill,
              color: isLocked
                  ? Colors.grey
                  : isQuiz
                      ? Colors.purple
                      : Colors.blueAccent,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: TextStyle(
                      color: isQuiz ? Colors.redAccent : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (isPreview)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "PREVIEW",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            if (isLocked) const Icon(Icons.lock_outline, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
   

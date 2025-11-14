import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/presentation/widgets/lesson_unit_card.dart';
import 'package:sunnova_app/features/course/presentation/pages/lesson_content_page.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // Import LessonUnitEntity

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: ListView.builder(
        itemCount: 5, // Placeholder for number of lessons
        itemBuilder: (context, index) {
          // Create a placeholder LessonUnitEntity
          final placeholderLesson = LessonUnitEntity(
            id: 'lesson_${index + 1}',
            title: 'Lesson ${index + 1} Title',
            description: 'This is a placeholder description for lesson ${index + 1}.',
            content: 'Placeholder content.',
            durationMinutes: 30,
          );

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LessonContentPage(lessonId: placeholderLesson.id),
                ),
              );
            },
            child: LessonUnitCard(
              lessonUnit: placeholderLesson,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LessonContentPage(lessonId: placeholderLesson.id),
                  ),
                );
              },
            ), // Placeholder for actual lesson data
          );
        },
      ),
    );
  }
}

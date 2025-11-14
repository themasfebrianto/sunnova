import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/presentation/widgets/lesson_unit_card.dart';
import 'package:sunnova_app/features/course/presentation/pages/lesson_content_page.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder for number of lessons
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LessonContentPage()),
              );
            },
            child: LessonUnitCard(), // Placeholder for actual lesson data
          );
        },
      ),
    );
  }
}

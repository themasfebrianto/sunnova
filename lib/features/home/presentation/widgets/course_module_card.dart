import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart'; // Import CourseModuleEntity

class CourseModuleCard extends StatelessWidget {
  final CourseModuleEntity courseModule; // Accept CourseModuleEntity as parameter

  const CourseModuleCard({super.key, required this.courseModule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      // Card theme is applied globally in main.dart
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Use spacing constants if defined globally
        child: Row(
          children: [
            Icon(
              Icons.book, // Placeholder icon, could be dynamic based on module type
              size: 50, // Use icon size constants if defined globally
              color: Theme.of(context).colorScheme.primary, // Use theme color
            ),
            const SizedBox(width: 15), // Use spacing constants
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseModule.title, // Display actual module name
                    style: Theme.of(context).textTheme.titleMedium, // Use theme typography
                  ),
                  const SizedBox(height: 5), // Use spacing constants
                  Text(
                    '${courseModule.completedLessons}/${courseModule.totalLessons} Lessons Completed', // Display actual progress
                    style: Theme.of(context).textTheme.bodySmall, // Use theme typography
                  ),
                ],
              ),
            ),
            if (courseModule.isLocked)
              Chip(
                label: Text(
                  'LOCKED',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).colorScheme.error, // Use theme color for error
              ),
          ],
        ),
      ),
    );
  }
}
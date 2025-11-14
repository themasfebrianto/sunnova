import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/domain/entities/lesson_unit_entity.dart'; // Import LessonUnitEntity

class LessonUnitCard extends StatelessWidget {
  final LessonUnitEntity lessonUnit;
  final bool isCompleted;
  final VoidCallback onTap;

  const LessonUnitCard({
    super.key,
    required this.lessonUnit,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Use radiusMedium from theme
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: isCompleted ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                size: 24, // Use iconLarge from theme
              ),
              const SizedBox(width: 16), // Use space16 from theme
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lessonUnit.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4), // Use space4 from theme
                    Text(
                      lessonUnit.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), // Use iconSmall from theme
            ],
          ),
        ),
      ),
    );
  }
}
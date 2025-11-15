import 'package:flutter/material.dart';
import 'package:sunnova_app/features/home/domain/entities/course_module_entity.dart';

class CourseModuleCard extends StatelessWidget {
  final CourseModuleEntity module;

  const CourseModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to CourseDetailPage
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => CourseDetailPage(moduleId: module.id),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Module Icon/Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha((255 * 0.2).round()),
                  borderRadius: BorderRadius.circular(8),
                  image: module.imageUrl.isNotEmpty // Check if imageUrl is not empty
                      ? DecorationImage(
                          image: AssetImage(module.imageUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: module.imageUrl.isEmpty // Check if imageUrl is empty
                    ? const Icon(Icons.book, size: 30, color: Colors.blue)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: module.totalLessons > 0
                          ? module.completedLessons / module.totalLessons
                          : 0,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 5,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${module.completedLessons}/${module.totalLessons} Lessons Completed',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (module.isLocked)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Chip(
                    label: Text('LOCKED'),
                    backgroundColor: Colors.redAccent,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
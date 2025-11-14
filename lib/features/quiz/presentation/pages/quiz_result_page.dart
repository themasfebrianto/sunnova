import 'package:flutter/material.dart';
import 'package:sunnova_app/features/course/presentation/pages/course_detail_page.dart';

class QuizResultPage extends StatefulWidget {
  const QuizResultPage({super.key});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 50).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              'Quiz Selesai!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Skor Anda: 3/5 Benar', // Placeholder
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              '+${_animation.value.toInt()} XP',
              style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Implement "Lihat Pembahasan" logic
              },
              child: const Text('Lihat Pembahasan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst); // Pop to the first route (HomePage)
                // Or navigate specifically to CourseDetailPage if needed
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => const CourseDetailPage()),
                // );
              },
              child: const Text('Kembali ke Kursus'),
            ),
          ],
        ),
      ),
    );
  }
}

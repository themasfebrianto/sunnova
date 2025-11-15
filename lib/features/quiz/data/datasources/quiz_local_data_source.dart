import 'package:sunnova_app/core/error/exceptions.dart';
import 'package:sunnova_app/features/quiz/data/models/assessment_question_model.dart';
import 'package:sunnova_app/features/quiz/data/models/user_answer_log_model.dart';
import 'package:sunnova_app/core/db/database_helper.dart'; // Import DatabaseHelper

abstract class QuizLocalDataSource {
  Future<List<AssessmentQuestionModel>> getQuizQuestions(String lessonId);
  Future<void> submitQuizAnswers(String userId, String lessonId, List<UserAnswerLogModel> answers);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  final DatabaseHelper databaseHelper;

  QuizLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<AssessmentQuestionModel>> getQuizQuestions(String lessonId) async {
    try {
      final questionMaps = await databaseHelper.getAssessmentQuestionsByLessonId(lessonId);
      return questionMaps.map((map) => AssessmentQuestionModel.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> submitQuizAnswers(String userId, String lessonId, List<UserAnswerLogModel> answers) async {
    try {
      for (final answer in answers) {
        await databaseHelper.insertUserAnswerLog(answer.toMap());
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

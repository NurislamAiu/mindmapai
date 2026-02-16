import 'package:mindmapai/features/report_problem/domain/entities/problem_report.dart';
import 'package:mindmapai/features/report_problem/domain/repositories/report_problem_repository.dart';

class ReportProblemRepositoryImpl implements ReportProblemRepository {
  @override
  Future<void> submitReport(ProblemReport report) async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would send the report to your backend here.
    print('Submitting report: ${report.category}, ${report.description}, hasScreenshot: ${report.screenshot != null}');
  }
}

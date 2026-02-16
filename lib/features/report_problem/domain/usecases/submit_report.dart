import 'package:mindmapai/features/report_problem/domain/entities/problem_report.dart';
import 'package:mindmapai/features/report_problem/domain/repositories/report_problem_repository.dart';

class SubmitReport {
  final ReportProblemRepository repository;

  SubmitReport(this.repository);

  Future<void> call(ProblemReport report) async {
    return await repository.submitReport(report);
  }
}

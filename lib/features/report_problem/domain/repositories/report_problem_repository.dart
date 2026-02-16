import 'package:mindmapai/features/report_problem/domain/entities/problem_report.dart';

abstract class ReportProblemRepository {
  Future<void> submitReport(ProblemReport report);
}

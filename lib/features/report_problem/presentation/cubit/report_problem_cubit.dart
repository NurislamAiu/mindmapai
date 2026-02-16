import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmapai/features/report_problem/domain/entities/problem_report.dart';
import 'package:mindmapai/features/report_problem/domain/usecases/submit_report.dart';
import 'package:mindmapai/features/report_problem/presentation/cubit/report_problem_state.dart';

class ReportProblemCubit extends Cubit<ReportProblemState> {
  final SubmitReport submitReportUseCase;
  final ImagePicker _picker = ImagePicker();
  File? screenshot;

  ReportProblemCubit({required this.submitReportUseCase}) : super(ReportProblemInitial());

  Future<void> submitReport({
    required String category,
    required String description,
  }) async {
    emit(ReportProblemLoading());
    try {
      final report = ProblemReport(
        category: category,
        description: description,
        screenshot: screenshot,
      );
      await submitReportUseCase(report);
      emit(ReportProblemSuccess());
    } catch (e) {
      emit(ReportProblemError('Failed to submit report: ${e.toString()}'));
    }
  }

  Future<void> pickScreenshot() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        screenshot = File(image.path);
        emit(ScreenshotPicked(screenshot!));
      }
    } catch (e) {
      emit(const ReportProblemError('Failed to pick image'));
    }
  }
}

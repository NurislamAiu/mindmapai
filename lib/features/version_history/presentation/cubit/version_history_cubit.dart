import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_version_history.dart';
import 'version_history_state.dart';

class VersionHistoryCubit extends Cubit<VersionHistoryState> {
  final GetVersionHistory _getVersionHistory;

  VersionHistoryCubit({required GetVersionHistory getVersionHistory})
      : _getVersionHistory = getVersionHistory,
        super(const VersionHistoryState());

  Future<void> fetchHistory(String ideaId) async {
    emit(state.copyWith(status: VersionHistoryStatus.loading));
    try {
      final versions = await _getVersionHistory(ideaId);
      emit(state.copyWith(
        status: VersionHistoryStatus.success,
        versions: versions,
      ));
    } catch (e) {
      emit(state.copyWith(status: VersionHistoryStatus.failure, error: e.toString()));
    }
  }

  void toggleVersionSelection(String versionId) {
    if (state.selectedVersionId == versionId) {
      // Если нажимаем на уже выбранный, закрываем его
      emit(state.copyWith(clearSelectedVersion: true));
    } else {
      emit(state.copyWith(selectedVersionId: versionId));
    }
  }
}

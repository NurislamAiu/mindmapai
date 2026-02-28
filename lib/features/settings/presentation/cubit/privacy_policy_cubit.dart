import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_privacy_policy_usecase.dart';
import 'package:mindmapai/features/settings/presentation/cubit/privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final GetPrivacyPolicyUseCase getPrivacyPolicyUseCase;

  PrivacyPolicyCubit({required this.getPrivacyPolicyUseCase}) : super(PrivacyPolicyInitial());

  Future<void> fetchPrivacyPolicy() async {
    try {
      emit(PrivacyPolicyLoading());
      final policy = await getPrivacyPolicyUseCase();
      emit(PrivacyPolicyLoaded(policy));
    } catch (e) {
      emit(const PrivacyPolicyError('Could not load the privacy policy. Please check your internet connection.'));
    }
  }
}

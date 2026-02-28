import 'package:mindmapai/features/settings/domain/repositories/privacy_policy_repository.dart';

class GetPrivacyPolicyUseCase {
  final PrivacyPolicyRepository repository;

  GetPrivacyPolicyUseCase(this.repository);

  Future<String> call() async {
    return await repository.getPrivacyPolicy();
  }
}

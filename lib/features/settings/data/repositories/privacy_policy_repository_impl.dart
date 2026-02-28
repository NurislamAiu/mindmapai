import 'package:http/http.dart' as http;
import 'package:mindmapai/features/settings/domain/repositories/privacy_policy_repository.dart';

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  // TODO: Замените этот URL на ваш собственный URL с текстом политики конфиденциальности
  final String _privacyPolicyUrl =
      'https://raw.githubusercontent.com/your-username/your-repo/main/privacy_policy.md';

  @override
  Future<String> getPrivacyPolicy() async {
    try {
      final response = await http.get(Uri.parse(_privacyPolicyUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load privacy policy: Status code ${response.statusCode}');
      }
    } catch (e) {
      // Возвращаем текст ошибки для отображения пользователю
      return '### Could Not Load Policy\n\nPlease check your internet connection and try again. If the problem persists, please contact support.';
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plantcare_id/providers/auth_provider.dart';

void main() {
  test('guestModeProvider toggles without touching Supabase', () {
    final container = ProviderContainer();
    try {
      // default should be false
      expect(container.read(guestModeProvider), isFalse);
      // toggle to true
      container.read(guestModeProvider.notifier).state = true;
      expect(container.read(guestModeProvider), isTrue);
    } finally {
      container.dispose();
    }
  });
}

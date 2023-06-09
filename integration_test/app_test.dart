import 'package:flutter_test/flutter_test.dart';
import 'package:foul_and_tamia/pages/article_page.dart';
import 'package:foul_and_tamia/pages/news_page.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the card action button, verify navigation',
        (tester) async {
      main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final Finder fab = find.text('title 1 ');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(find.byType(NewsPage), findsNothing);
      expect(find.byType(ArticlePage), findsOneWidget);
    });
  });
}

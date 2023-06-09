import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foul_and_tamia/article.dart';
import 'package:foul_and_tamia/news_change_notifier.dart';
import 'package:foul_and_tamia/news_services.dart';
import 'package:foul_and_tamia/pages/news_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../news_change_notifier_test.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  setUp(() => mockNewsService = MockNewsService());

  final List<Article> articles = [
    Article(title: "title 1 ", content: bigLorem()),
    const Article(title: "title 2 ", content: "content"),
    Article(title: lorem(paragraphs: 1, words: 150), content: bigLorem()),
  ];
  void arrangeMockNewsServiceGet3Articles() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      return Future.value(articles);
    });
  }

  void get3ArticlesDelayedArrange() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      return Future.value(articles);
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  /// the screen currently testing
  testWidgets("Check if news appears", (widgetTester) async {
    arrangeMockNewsServiceGet3Articles();

    /// create and build the in widget this invisible ui
    await widgetTester.pumpWidget(createWidgetUnderTest());
    expect(find.text("News"), findsOneWidget);
  });

  testWidgets("Check if CircularProgressIndicator appears",
      (widgetTester) async {
    arrangeMockNewsServiceGet3Articles();

    /// create and build the in widget this invisible ui
    await widgetTester.pumpWidget(createWidgetUnderTest());
    await widgetTester.pump(const Duration(milliseconds: 250));

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );

    await widgetTester.pumpAndSettle();
  });

  testWidgets("Check if List of Articles appears", (widgetTester) async {
    arrangeMockNewsServiceGet3Articles();

    /// create and build the in widget this invisible ui
    await widgetTester.pumpWidget(createWidgetUnderTest());

    /// create virtual async
    await widgetTester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(3));
    for (final article in articles) {
      expect(find.text(article.title), findsAtLeastNWidgets(1));
    }
  });
}

import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foul_and_tamia/article.dart';
import 'package:foul_and_tamia/news_change_notifier.dart';
import 'package:foul_and_tamia/news_services.dart';
import 'package:mocktail/mocktail.dart';

String bigLorem() => lorem(paragraphs: 6);

// class BadMockNewsService implements NewsService {
//   bool isGetArticles = false;
//   @override
//   Future<List<Article>> getArticles() {
//     isGetArticles = true;
//     return Future.value([
//       Article(title: "title 1 ", content: bigLorem()),
//       const Article(title: "title 2 ", content: "content"),
//       Article(title: lorem(paragraphs: 1, words: 150), content: bigLorem()),
//     ]);
//   }
// }

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier newsChangeNotifier;
  late MockNewsService mockNewsService;

  setUp(
    () {
      mockNewsService = MockNewsService();
      newsChangeNotifier = NewsChangeNotifier(mockNewsService);
    },
  );

  test('initial NewsChangeNotifier values are correct', () {
    expect(newsChangeNotifier.articles, <Article>[]);
    expect(newsChangeNotifier.isLoading, false);
  });

  group('getArticles():', () {
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

    test("get articles called one time", () async {
      arrangeMockNewsServiceGet3Articles();
      await newsChangeNotifier.getArticles();
      verify(() => mockNewsService.getArticles()).called(1);
    });

    test("when get articles called, isLoading behave successfully ", () async {
      arrangeMockNewsServiceGet3Articles();
      final future = newsChangeNotifier.getArticles();
      expect(newsChangeNotifier.isLoading, true);
      await future;
      expect(newsChangeNotifier.isLoading, false);
    });

    test("get articles Successfully", () async {
      arrangeMockNewsServiceGet3Articles();
      final future = newsChangeNotifier.getArticles;
      await future();
      expect(newsChangeNotifier.articles, articles);
    });
  });
}

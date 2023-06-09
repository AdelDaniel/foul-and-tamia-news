import 'package:flutter/material.dart';
import 'package:foul_and_tamia/article.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mq.padding.top,
          bottom: mq.padding.bottom,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(article.content),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foul_and_tamia/news_change_notifier.dart';
import 'package:foul_and_tamia/news_services.dart';
import 'package:foul_and_tamia/pages/news_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}

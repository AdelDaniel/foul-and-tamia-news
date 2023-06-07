import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foul_and_tamia/firebase_options.dart';
import 'package:foul_and_tamia/news_change_notifier.dart';
import 'package:foul_and_tamia/news_services.dart';
import 'package:foul_and_tamia/pages/news_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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

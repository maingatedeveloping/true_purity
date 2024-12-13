import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'routing/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAhASD5vySVN8ww-Htv9rKdhY1sU48QxRc",
      appId: "1:249656381180:web:cecc56b678ebe279d55179",
      messagingSenderId: "249656381180",
      projectId: "true-purity",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'True Purity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (context) => GlobalState()),
      //   ],
      //   child: const HomePage(),
      // ),
      routerConfig: router,
    );
  }
}

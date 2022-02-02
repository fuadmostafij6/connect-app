import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'Screen/Deshboard/deshboard.dart';
import 'Screen/Form/registation.dart';
import 'Screen/Linkscreen/linkscreen.dart';
import 'Screen/splash/splash.dart';
import 'homepage.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final dir = await getApplicationDocumentsDirectory();
  // await Hive.initFlutter();
  // await Hive.openBox("login");
  // Hive.init(dir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

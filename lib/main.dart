import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Provider/Categorybyjob/categoryjob.dart';
import 'Provider/Form/form.dart';
import 'package:path_provider/path_provider.dart';
import 'Provider/Job_Apply/job_apply.dart';
import 'Provider/Jobdetails/jobdetails.dart';
import 'Provider/Profile/profile.dart';
import 'Provider/Search/search.dart';
import 'Provider/Userjob/userjob.dart';
import 'Provider/home.dart';
import 'Screen/splash/splash.dart';
import 'homepage.dart';
 List<CameraDescription>? cameras;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  cameras = await availableCameras();
  await Hive.initFlutter();
  await Hive.openBox("login");
  Hive.init(dir.path);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Fromprovider()),
    ChangeNotifierProvider(create: (context) => HomeProvider()),
    ChangeNotifierProvider(create: (context) => Searchprovider()),
    ChangeNotifierProvider(create: (context) => ProfileProvider()),
    ChangeNotifierProvider(create: (context) => Userjobpage()),
    ChangeNotifierProvider(create: (context) => JobDetailsProvider()),
    ChangeNotifierProvider(create: (context) => JobApplyprovider()),
    ChangeNotifierProvider(create: (context) => CategoryJobprovider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('login');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: box.get('email') != null ? Homepage() : const SplashScreen(),
      // home: MemeberShipBuyPage(),
    );
  }
}

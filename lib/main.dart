import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_link_demo/homepage.dart';
import 'package:dynamic_link_demo/loginpage.dart';
import 'package:flutter/scheduler.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

void initDynamicLinks(BuildContext context) async {
  dynamicLinks.onLink.listen((dynamicLinkData) async {
    final Uri? deepLink = dynamicLinkData.link;
    print("deeplink found");
    if (deepLink != null) {
      print(deepLink);
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => LoginPage(
              title: 'firebase_dynamic_link  navigation', url: "$deepLink"),
        ),
      );
    }
  }, onError: (e) async {
      print("deeplink error");
      print(e.message);

  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      initDynamicLinks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const HomePage(
        title: "Home Page From Main",
      ),
    );
  }
}

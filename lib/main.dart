import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

void initDynamicLinks(BuildContext context) async {
  FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
    final Uri? deepLink = dynamicLink?.link;
    print("deeplink found");
    if (deepLink != null) {
      print(deepLink);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(
                  title: 'firebase_dynamic_link  navigation',
                  url: "$deepLink")));
    }
  }, onError: (OnLinkErrorException e) async {
    if (kDebugMode) {
      print("deeplink error");
    }
    if (kDebugMode) {
      print(e.message);
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  noSuchMethod(Invocation invocation) {
    initDynamicLinks(context);
    return super.noSuchMethod(invocation);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(
          title: "Home Page From Main",
        ));
  }
}

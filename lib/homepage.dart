import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:dynamic_link_demo/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link = "";

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  @override
  void initState() {
    super.initState();
  }

  buildDynamicLinks(String title, String image, String docId) async {
    String url = "https://demodylink.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$docId'),
      androidParameters: AndroidParameters(
        packageName: "com.example.dynamic_link_demo",
        minimumVersion: 0,
        fallbackUrl: Uri.parse(
            'https://play.google.com/store/apps/details?id=com.ludo.king'),
      ),
      iosParameters: const IOSParameters(
        bundleId: "Bundle-ID",
        minimumVersion: '0',
        // fallbackUrl: Uri.parse('https://i.diawi.com/s1SETP'),
      ),
    );
    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);

    String? desc = shortLink.shortUrl.toString();
    setState(() {
      link = desc;
    });
    await Share.share(
      link,
      subject: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            Container(
              margin: const EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(
                        title: 'Demo LogIn Page',
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: const Text(
                'Generate Link',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                buildDynamicLinks(
                    "Dynamic Link Title",
                    "https://images.unsplash.com/photo-1661956602868-6ae368943878?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2940&q=80",
                    "QWERTY");
              },
            ),
            SizedBox(
                width: 200, child: SelectableText("Generated Link : $link")),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///---init---
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage(
                    title: 'Home PAge',
                  )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Container(
          color: Colors.amberAccent,
          child: const Text("SPLASH SCREEN"),
        ),
      ),
    );
  }
}


import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link = "";

  @override
  void initState() {
    super.initState();
  }



  buildDynamicLinks(String title,String image,String docId) async {
    String url = "https://dynamiclinl.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$docId'),
      androidParameters: AndroidParameters(
        packageName: "com.example.dynamic_link_demo",
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: "Bundle-ID",
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: '',
          imageUrl:
          Uri.parse(image),
          title: title),
    );
    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();

    String? desc = dynamicUrl.shortUrl.toString();
   setState(() {
     link = desc;});
    await Share.share(desc, subject: title,);

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
                primary: Colors.blueGrey,

                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginPage(title: 'Demo LogIn Page',)));
                },
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,

              ),
              child: const Text(
                'Generate Link',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                buildDynamicLinks( "Dynamic Link Title", "","");
                   },
            ),

            SizedBox(width: 200,child: Text("Generated Link : $link")),
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
  void initState(){
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const HomePage(title: 'Home PAge',)));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.amberAccent,body: Center(child: Container(color: Colors.amberAccent, child: const Text("SPLASH SCREEN"),)));
  }
}

import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class DevelopmentOptions extends StatefulWidget {
  const DevelopmentOptions({super.key});

  @override
  State<DevelopmentOptions> createState() => _DevelopmentOptionsState();
}

class _DevelopmentOptionsState extends State<DevelopmentOptions> {
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkURL();
  }

  Future checkURL() async {
    await LocalSharedPrefs().readKey('dev_url').then((devURL) {
      if(devURL != null) {
        setState(() {
          urlController.text = devURL;
        });
      } else {
        setState(() {
          urlController.text = "https://kenari-backend.netlify.app/";
        });
      }
    });
  }

  Future<bool> onBackPressed() async {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Development Options',
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      'URL for API:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                onPressed: () async {
                  await LocalSharedPrefs().writeKey('dev_url', urlController.text).then((_) {
                    ReplaceToPage(context: context, target: const SplashPage()).go();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text(
                    'Simpan',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
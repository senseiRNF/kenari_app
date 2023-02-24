import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  String? name;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  Future<void> initLoad() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) {
      setState(() {
        name = nameResult;
      });
    });
  }

  Future<void> logout() async {
    await LocalSharedPrefs().removeAllKey().then((removeResult) {
      if(removeResult == true) {
        RedirectToSplashPage(context: context).go();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: PrimaryColorStyles.primaryMain(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {

                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Edit Profile',
                                    style: XSTextStyles.medium().copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    Icons.edit_square,
                                    size: 10.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: BorderColorStyles.borderStrokes(),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 40.0,
                                color: IconColorStyles.iconColor(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          name ?? 'Unknown User',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'SFC_WM - 1234567890',
                          style: XSTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
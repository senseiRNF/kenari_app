import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenari_app/fragments/home_fragment.dart';
import 'package:kenari_app/fragments/profile_fragment.dart';
import 'package:kenari_app/fragments/search_fragment.dart';
import 'package:kenari_app/fragments/transaction_fragment.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_form_page.dart';
import 'package:kenari_app/services/api/notification_services/api_notification_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenu = 0;
  int? selectedTranscationTab;

  bool isOnBoarding = false;

  final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    checkIfSendingFCMTOken();
  }

  checkIfSendingFCMTOken() async {
    await LocalSharedPrefs().readKey('token').then((token) async {
      if(token != null) {
        checkIfBoarding();
      } else {
        await LocalSharedPrefs().readKey('user_id').then((userId) async {
          await LocalSharedPrefs().writeKey('token', '').then((_) async {
            await _firebaseMessaging.getToken().then((token) async {
              await APINotificationServices(context: context).postNotificationToken(token, userId).then((_) {
                checkIfBoarding();
              });
            });
          });
        });
      }
    });
  }

  Widget activeFragment() {
    switch(selectedMenu) {
      case 0:
        return HomeFragment(
          onFeePageCallback: (callbackResult) {
            if(callbackResult != null) {
              if(callbackResult['target'] == 'transaction') {
                setState(() {
                  selectedMenu = 2;
                  selectedTranscationTab = callbackResult['index'];
                });
              }
            }
          },
          onLoanPageCallback: (callbackResult) {
            if(callbackResult != null) {
              if(callbackResult['target'] == 'transaction') {
                setState(() {
                  selectedMenu = 2;
                  selectedTranscationTab = callbackResult['index'];
                });
              }
            }
          },
          onTransactionPageCallback: (callbackResult) {
            if(callbackResult != null) {
              if(callbackResult['target'] == 'transaction') {
                setState(() {
                  selectedMenu = 2;
                  selectedTranscationTab = callbackResult['index'];
                });
              }
            }
          },
        );
      case 1:
        return SearchFragment(
          onTransactionPageCallback: (callbackResult) {
            if(callbackResult != null) {
              if(callbackResult['target'] == 'transaction') {
                setState(() {
                  selectedMenu = 2;
                  selectedTranscationTab = callbackResult['index'];
                });
              }
            }
          },
        );
      case 2:
        return TransactionFragment(
          tabSelected: selectedTranscationTab,
        );
      case 3:
        return const ProfileFragment();
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Terjadi kesalahan....',
              style: HeadingTextStyles.headingM(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Silahkan muat ulang aplikasi, apabila kesalahan terus terjadi, mohon untuk segera menghubungi administrator.',
              style: LTextStyles.medium(),
              textAlign: TextAlign.center,
            ),
          ],
        );
    }
  }

  Future checkIfBoarding() async {
    await LocalSharedPrefs().readKey('boarding').then((boardingResult) {
      if(boardingResult == null) {
        setState(() {
          isOnBoarding = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedMenu == 0 ? const Color(0xffff7a15) : Colors.white,
      body: SafeArea(
        child: Stack(
          children: isOnBoarding ?
          [
            activeFragment(),
            Container(
              color: NeutralColorStyles.neutral10().withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () async {
                  await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                    if(writeResult == true) {
                      setState(() {
                        isOnBoarding = false;
                      });
                    }
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                  if(writeResult == true) {
                    setState(() {
                      isOnBoarding = false;
                    });
                  }
                });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Titip Produk',
                              style: STextStyles.medium().copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Dapatkan penghasilan tambahan dengan Titip Produk apapun disini',
                              style: XSTextStyles.regular(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: const Size(20, 20),
                      painter: DrawTriangle(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                  ],
                ),
              ),
            ),
          ] :
          [
            activeFragment(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if(isOnBoarding) {
                          await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                            if(writeResult == true) {
                              setState(() {
                                isOnBoarding = false;
                              });
                            }
                          });
                        } else {
                          if(selectedMenu != 0) {
                            setState(() {
                              selectedMenu = 0;
                              selectedTranscationTab = null;
                            });
                          }
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/svg_icon/home_icon.svg',
                              colorFilter: ColorFilter.mode(
                                selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Beranda',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () async {
                        if(isOnBoarding) {
                          await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                            if(writeResult == true) {
                              setState(() {
                                isOnBoarding = false;
                              });
                            }
                          });
                        } else {
                          if(selectedMenu != 1) {
                            setState(() {
                              selectedMenu = 1;
                              selectedTranscationTab = null;
                            });
                          }
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 20.0,
                              color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Pencarian',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if(isOnBoarding) {
                          await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                            if(writeResult == true) {
                              setState(() {
                                isOnBoarding = false;
                              });
                            }
                          });
                        } else {
                          if(selectedMenu != 2) {
                            setState(() {
                              selectedMenu = 2;
                              selectedTranscationTab = null;
                            });
                          }
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/svg_icon/transaction_icon.svg',
                              colorFilter: ColorFilter.mode(
                                selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Transaksi',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () async {
                        if(isOnBoarding) {
                          await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
                            if(writeResult == true) {
                              setState(() {
                                isOnBoarding = false;
                              });
                            }
                          });
                        } else {
                          if(selectedMenu != 3) {
                            setState(() {
                              selectedMenu = 3;
                              selectedTranscationTab = null;
                            });
                          }
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 20.0,
                              color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Profile',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(isOnBoarding) {
            await LocalSharedPrefs().writeKey('boarding', 'false').then((writeResult) {
              if(writeResult == true) {
                setState(() {
                  isOnBoarding = false;
                });
              }
            });
          } else {
            MoveToPage(context: context, target: const SellerProductFormPage()).go();
          }
        },
        backgroundColor: PrimaryColorStyles.primaryMain(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    // path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
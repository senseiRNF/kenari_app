import 'package:flutter/material.dart';
import 'package:kenari_app/fragments/home_fragment.dart';
import 'package:kenari_app/fragments/profile_fragment.dart';
import 'package:kenari_app/fragments/search_fragment.dart';
import 'package:kenari_app/fragments/transaction_fragment.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_form_page.dart';
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
                selectedMenu = 2;
                selectedTranscationTab = callbackResult['index'];
              }
            }
          },
        );
      case 1:
        return const SearchFragment();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedMenu == 0 ? const Color(0xffff7a15) : Colors.white,
      body: SafeArea(
        child: activeFragment(),
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
                      onTap: () {
                        if(selectedMenu != 0) {
                          setState(() {
                            selectedMenu = 0;
                            selectedTranscationTab = null;
                          });
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
                              Icons.home,
                              color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
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
                      onTap: () {
                        if(selectedMenu != 1) {
                          setState(() {
                            selectedMenu = 1;
                            selectedTranscationTab = null;
                          });
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
                      onTap: () {
                        if(selectedMenu != 2) {
                          setState(() {
                            selectedMenu = 2;
                            selectedTranscationTab = null;
                          });
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
                              Icons.newspaper,
                              color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
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
                      onTap: () {
                        if(selectedMenu != 3) {
                          setState(() {
                            selectedMenu = 3;
                            selectedTranscationTab = null;
                          });
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
        onPressed: () => MoveToPage(context: context, target: const SellerProductFormPage()).go(),
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
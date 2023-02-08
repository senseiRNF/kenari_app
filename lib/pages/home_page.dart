import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenu = 0;
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff7a15),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xffff4700),
                    Color(0xffff5f0a),
                    Color(0xffff7613),
                    Color(0xffff7f17),
                    Color(0xffff7a15),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 31.0,
                      height: 36.0,
                      child: Image.asset(
                        'assets/images/white_main_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        'Selamat datang di\nKenari!',
                        style: MTextStyles.medium().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.white,
                child: ListView(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                        onPageChanged: (page, reason) {
                          setState(() {
                            selectedCard = page;
                          });
                        },
                      ),
                      items: [1, 2].map((i) {
                        return Builder(
                          builder: (BuildContext itemContext) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xff242424),
                                      Color(0xff363636),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: selectedCard == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const SizedBox(
                            height: 3.0,
                            width: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: selectedCard == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const SizedBox(
                            height: 3.0,
                            width: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 54.0,
                                  height: 54.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BorderColorStyles.borderStrokes(),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_iuran.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Iuran',
                                  style: STextStyles.medium(),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 54.0,
                                  height: 54.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BorderColorStyles.borderStrokes(),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_pinjaman.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Pinjaman',
                                  style: STextStyles.medium(),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 54.0,
                                  height: 54.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BorderColorStyles.borderStrokes(),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_titip_jual.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Titip Jual',
                                  style: STextStyles.medium(),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 54.0,
                                  height: 54.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BorderColorStyles.borderStrokes(),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_semua.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Semua',
                                  style: STextStyles.medium(),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Produk Terbaru',
                            style: MTextStyles.medium(),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Lihat semua',
                              style: MTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
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
                      onTap: () {
                        if(selectedMenu != 0) {
                          setState(() {
                            selectedMenu = 0;
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
        onPressed: () {

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
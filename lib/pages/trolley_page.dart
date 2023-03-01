import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key});

  @override
  State<TrolleyPage> createState() => _TrolleyPageState();
}

class _TrolleyPageState extends State<TrolleyPage> {
  List productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      BackFromThisPage(context: context).go();
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.chevron_left,
                        size: 30.0,
                        color: IconColorStyles.iconColor(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      'Troli',
                      style: HeadingTextStyles.headingS(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: productList.isNotEmpty ?
              ListView() :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Image.asset(
                          'assets/images/icon_trolley_empty.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Belum Ada Produk di Troli',
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Yuk eksplor semua produk yang ada di\nKenari, tambah ke Troli & Checkout\nProdukmu!',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: ListView(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Belanja Sekarang',
                    style: LTextStyles.medium().copyWith(
                      color: Colors.white,
                    ),
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
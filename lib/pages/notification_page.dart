import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int selectedTab = 0;
  int selectedFilter = 0;

  List notificationList = [];

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
                      'Notifikasi',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: PrimaryColorStyles.primaryMain(),
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                  ),
                  onTap: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Update',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Transaksi',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: BorderColorStyles.borderDivider(),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.0,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0, right: 5.0),
                            child: Container(
                              width: 75.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedFilter == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(selectedFilter != 0) {
                                    setState(() {
                                      selectedFilter = 0;
                                    });
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Semua',
                                    style: STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 75.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedFilter == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(selectedFilter != 1) {
                                    setState(() {
                                      selectedFilter = 1;
                                    });
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Iuran',
                                    style: STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 75.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedFilter == 2 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(selectedFilter != 2) {
                                    setState(() {
                                      selectedFilter = 2;
                                    });
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Pinjaman',
                                    style: STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 75.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedFilter == 3 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(selectedFilter != 3) {
                                    setState(() {
                                      selectedFilter = 3;
                                    });
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Titip Jual',
                                    style: STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              width: 75.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedFilter == 4 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(selectedFilter != 4) {
                                    setState(() {
                                      selectedFilter = 4;
                                    });
                                  }
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Pesanan',
                                    style: STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: notificationList.isNotEmpty ?
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
                          'assets/images/icon_notification_empty.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        selectedTab == 0 ? 'Belum Ada Informasi' : 'Belum Ada Info Transaksi',
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          selectedTab == 0 ? 'Berbagai update pemberitahuan dapat Anda\nlihat pada halaman ini' : 'Berbagai informasi transaksi dapat Anda lihat\npada halaman ini',
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
          ],
        ),
      ),
    );
  }
}
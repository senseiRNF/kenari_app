import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/notification_transaction_detail_page.dart';
import 'package:kenari_app/services/local/models/local_notification_data.dart';
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

  List<LocalNotificationData> notificationList = [
    LocalNotificationData(
      type: 'pinjaman',
      date: DateTime(2022, 10, 03, 02, 31),
      title: 'Pinjaman Berhasil',
      subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
    ),
    LocalNotificationData(
      type: 'pesanan',
      date: DateTime(2022, 12, 03, 01, 31),
      title: 'Barangmu sudah siap di Ambil!',
      subtitle: 'Barang yang kamu beli siap di Ambil, pastikan barang yang kamu ambil nanti sudah sesuai.',
    ),
    LocalNotificationData(
      type: 'pinjaman',
      date: DateTime(2022, 11, 03, 02, 31),
      title: 'Pinjaman Berhasil',
      subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
    ),
    LocalNotificationData(
      type: 'titip-jual',
      date: DateTime(2022, 12, 03, 01, 31),
      title: 'Titip Jual Disetujui',
      subtitle: 'Penitipan jual produk Anda telah disetujui, silahkan cek daftar titip jual Anda.',
    ),
    LocalNotificationData(
      type: 'iuran',
      date: DateTime(2022, 12, 03, 01, 31),
      title: 'Penarikan Iuran Berhasil',
      subtitle: 'Iuran Anda telah dilunasi, silahkan cek email Anda untuk informasi lebih lanjut.',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void changeFilter(int filter) {
    if(selectedTab == 0) {
      switch(filter) {
        case 1:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Penarikan Iuran Berhasil',
                subtitle: 'Iuran Anda telah dilunasi, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
            ];
          });
          break;
        case 2:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 10, 03, 02, 31),
                title: 'Pinjaman Berhasil',
                subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 11, 03, 02, 31),
                title: 'Pinjaman Berhasil',
                subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
            ];
          });
          break;
        case 3:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Titip Jual Disetujui',
                subtitle: 'Penitipan jual produk Anda telah disetujui, silahkan cek daftar titip jual Anda.',
              ),
            ];
          });
          break;
        case 4:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Barangmu sudah siap di Ambil!',
                subtitle: 'Barang yang kamu beli siap di Ambil, pastikan barang yang kamu ambil nanti sudah sesuai.',
              ),
            ];
          });
          break;
        default:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 10, 03, 02, 31),
                title: 'Pinjaman Berhasil',
                subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Barangmu sudah siap di Ambil!',
                subtitle: 'Barang yang kamu beli siap di Ambil, pastikan barang yang kamu ambil nanti sudah sesuai.',
              ),
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 11, 03, 02, 31),
                title: 'Pinjaman Berhasil',
                subtitle: 'Pengajuan pinjaman Anda telah berhasil, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Titip Jual Disetujui',
                subtitle: 'Penitipan jual produk Anda telah disetujui, silahkan cek daftar titip jual Anda.',
              ),
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Penarikan Iuran Berhasil',
                subtitle: 'Iuran Anda telah dilunasi, silahkan cek email Anda untuk informasi lebih lanjut.',
              ),
            ];
          });
          break;
      }
    } else {
      switch(filter) {
        case 1:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 04, 12, 03, 50),
                title: 'Iuran Wajib',
                total: -100000,
              ),
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 09, 12, 03, 50),
                title: 'Iuran Berjangka 1',
                total: -100000,
              ),
            ];
          });
          break;
        case 2:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Cicilan Pinjaman 1',
                total: -1118594,
              ),
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 08, 29, 03, 50),
                title: 'Pencairan Pinjaman',
                total: 3000000,
              ),
            ];
          });
          break;
        case 3:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Penjualan',
                subtitle: 'Produk "Cabai merah"',
                total: 65000,
              ),
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Penjualan',
                subtitle: 'Produk "Cabai merah"',
                total: 65000,
              ),
            ];
          });
          break;
        case 4:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Pembayaran',
                subtitle: 'Pesanan "Pizza"',
                total: -185000,
              ),
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Pembayaran',
                subtitle: 'Pesanan "Sate"',
                total: -35000,
              ),
            ];
          });
          break;
        default:
          setState(() {
            notificationList = [
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Cicilan Pinjaman 1',
                total: -1118594,
              ),
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Pembayaran',
                subtitle: 'Pesanan "Pizza"',
                total: -185000,
              ),
              LocalNotificationData(
                type: 'pinjaman',
                date: DateTime(2022, 08, 29, 03, 50),
                title: 'Pencairan Pinjaman',
                total: 3000000,
              ),
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Penjualan',
                subtitle: 'Produk "Cabai merah"',
                total: 65000,
              ),
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 04, 12, 03, 50),
                title: 'Iuran Wajib',
                total: -100000,
              ),
              LocalNotificationData(
                type: 'pesanan',
                date: DateTime(2022, 12, 03, 01, 31),
                title: 'Pembayaran',
                subtitle: 'Pesanan "Sate"',
                total: -35000,
              ),
              LocalNotificationData(
                type: 'iuran',
                date: DateTime(2022, 09, 12, 03, 50),
                title: 'Iuran Berjangka 1',
                total: -100000,
              ),
              LocalNotificationData(
                type: 'titip-jual',
                date: DateTime(2022, 09, 29, 03, 55),
                title: 'Penjualan',
                subtitle: 'Produk "Cabai merah"',
                total: 65000,
              ),
            ];
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    changeFilter(selectedFilter);

    notificationList.sort((b, a) => a.date.compareTo(b.date));

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                    height: 1.0,
                    color: NeutralColorStyles.neutral05(),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
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
              ListView.separated(
                itemCount: notificationList.length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  bool showDivider = true;

                  if(separatorIndex < notificationList.length) {
                    if(notificationList[separatorIndex].date.year != notificationList[separatorIndex + 1].date.year) {
                      showDivider = false;
                    } else {
                      if(notificationList[separatorIndex].date.month != notificationList[separatorIndex + 1].date.month) {
                        showDivider = false;
                      }
                    }
                  }

                  return showDivider == true ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(
                      height: 1.0,
                      color: BorderColorStyles.borderStrokes(),
                    ),
                  ) :
                  const Material();
                },
                itemBuilder: (BuildContext listContext, int index) {
                  bool showMonthHeading = false;

                  if(index == 0) {
                    showMonthHeading = true;
                  } else {
                    if(notificationList[index].date.year != notificationList[index -1].date.year) {
                      showMonthHeading = true;
                    } else {
                      if(notificationList[index].date.month != notificationList[index - 1].date.month) {
                        showMonthHeading = true;
                      }
                    }
                  }

                  return selectedTab == 0 ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      showMonthHeading == true ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          index != 0 ?
                          const SizedBox(
                            height: 20.0,
                          ) :
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              DateFormat('MMMM yyyy').format(notificationList[index].date),
                              style: XSTextStyles.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ) :
                      const Material(),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                notificationList[index].title,
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                notificationList[index].subtitle ?? '',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                DateFormat('dd MMM yyyy, HH:mm').format(notificationList[index].date),
                                style: STextStyles.regular(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      showMonthHeading == true ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          index != 0 ?
                          const SizedBox(
                            height: 20.0,
                          ) :
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              DateFormat('MMMM yyyy').format(notificationList[index].date),
                              style: XSTextStyles.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ) :
                      const Material(),
                      InkWell(
                        onTap: () {
                          MoveToPage(context: context, target: NotificationTransactionDetailPage(notificationData: notificationList[index])).go();
                        },
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      notificationList[index].title,
                                      style: MTextStyles.medium().copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    notificationList[index].total != null ?
                                    Text(
                                      "${notificationList[index].total! < 0 ? '-Rp ' : '+Rp '}${NumberFormat('#,###', 'en_id').format(notificationList[index].total!.abs()).replaceAll(',', '.')}",
                                      style: MTextStyles.medium().copyWith(
                                        color: notificationList[index].total! < 0 ? Colors.red : Colors.green,
                                      ),
                                    ) :
                                    const Material(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                notificationList[index].subtitle != null ?
                                Text(
                                  notificationList[index].subtitle!,
                                  style: STextStyles.regular(),
                                ) :
                                const Material(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  DateFormat('dd MMM yyyy, HH:mm').format(notificationList[index].date),
                                  style: STextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ) :
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
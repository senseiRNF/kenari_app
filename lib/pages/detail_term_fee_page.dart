import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class DetailTermFeePage extends StatefulWidget {
  final String title;
  final String feeId;
  final bool status;

  const DetailTermFeePage({
    super.key,
    required this.title,
    required this.feeId,
    required this.status,
  });

  @override
  State<DetailTermFeePage> createState() => _DetailTermFeePageState();
}

class _DetailTermFeePageState extends State<DetailTermFeePage> {
  String? name;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) {
      setState(() {
        name = nameResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            widget.title,
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
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Iuran Berjangka 1',
                            style: STextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          widget.status == true ?
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
                            color: InfoColorStyles.infoSurface(),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: InfoColorStyles.infoMain(),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        'Pencairan saldo\n\nSaat tanggal pencairan telah jatuh tempo, maka saldo otomatis akan tercairkan pada akun Dipay',
                                        style: XSTextStyles.medium().copyWith(
                                          color: InfoColorStyles.infoMain(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saldo saat ini',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                'Rp 100.000',
                                style: MTextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Pertumbuhan saldo',
                                style: MTextStyles.regular(),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.show_chart,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      'Rp 0',
                                      style: MTextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jangka waktu',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                '1 Bulan',
                                style: MTextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Imbal hasil pertahun',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                '5.75%',
                                style: MTextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal mulai',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                                style: MTextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal pencairan',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy').format(DateTime.now().add(const Duration(days: 30))),
                                style: MTextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          widget.status == false ?
                          Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            decoration: BoxDecoration(
                              color: SuccessColorStyles.successSurface(),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: SuccessColorStyles.successMain(),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Pencairan Sukses',
                                    style: XSTextStyles.medium().copyWith(
                                      color: SuccessColorStyles.successMain(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :
                          const Material(),
                          Text(
                            'Pencairan Saldo',
                            style: STextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: Image.asset(
                                  'assets/images/dipay_logo_only.png',
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Dipay',
                                style: MTextStyles.medium(),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '0123456789',
                                      style: STextStyles.medium(),
                                    ),
                                    Text(
                                      'a/n ${name ?? 'Unknown'}',
                                      style: STextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
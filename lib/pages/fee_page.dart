import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_list_page.dart';
import 'package:kenari_app/pages/temporal_fee_deposit_page.dart';
import 'package:kenari_app/services/api/fee_services/api_total_fee_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class FeePage extends StatefulWidget {
  const FeePage({super.key});

  @override
  State<FeePage> createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  String? name;
  String? companyCode;

  int mandatoryFeeAmount = 0;
  int temporalFeeAmount = 0;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        name = nameResult;
      });

      await LocalSharedPrefs().readKey('company_code').then((companyCodeResult) async {
        setState(() {
          companyCode = companyCodeResult;
        });

        await APITotalFeeServices(context: context).call().then((callResult) {
          if(callResult != null && callResult.totalFeeData != null) {
            if(callResult.totalFeeData!.totalIuranWajib != null) {
              setState(() {
                mandatoryFeeAmount = callResult.totalFeeData!.totalIuranWajib!;
              });
            }

            if(callResult.totalFeeData!.totalIuranBerjangka != null) {
              setState(() {
                temporalFeeAmount = callResult.totalFeeData!.totalIuranBerjangka!;
              });
            }
          }
        });
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
                            'Iuran',
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
              child: RefreshIndicator(
                onRefresh: () async {
                  loadData();
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: BackgroundColorStyles.pageBackground(),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 30.0,
                                      color: IconColorStyles.iconColor(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          name ?? '(Pengguna tidak diketahui)',
                                          style: MTextStyles.regular(),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          companyCode ?? '(Kode tidak diketahui)',
                                          style: XSTextStyles.regular(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Saldo Iuran Wajib',
                                            style: XSTextStyles.regular(),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            'Rp ${NumberFormat('#,###', 'en_id').format(mandatoryFeeAmount)}',
                                            style: STextStyles.medium().copyWith(
                                              color: TextColorStyles.textPrimary(),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Saldo Iuran Berjangka',
                                            style: XSTextStyles.regular(),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            'Rp ${NumberFormat('#,###', 'en_id').format(temporalFeeAmount)}',
                                            style: STextStyles.medium().copyWith(
                                              color: TextColorStyles.textPrimary(),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              child: InkWell(
                                onTap: () => MoveToPage(
                                  context: context,
                                  target: const TemporalFeeDepositPage(),
                                  callback: (callbackResult) {
                                    if(callbackResult != null) {
                                      BackFromThisPage(context: context, callbackData: callbackResult).go();
                                    }
                                  },
                                ).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/icon_setoran_iuran.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Setoran Iuran Berjangka',
                                              style: MTextStyles.medium().copyWith(
                                                color: TextColorStyles.textPrimary(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Setoran Iuran Berjangka',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              child: InkWell(
                                onTap: () => MoveToPage(
                                    context: context,
                                    target: FeeListPage(
                                      mandatoryFeeAmount: mandatoryFeeAmount,
                                      temporalFeeAmount: temporalFeeAmount,
                                    ),
                                    callback: (callbackResult) {
                                      if(callbackResult != null && callbackResult == true) {
                                        MoveToPage(
                                          context: context,
                                          target: const TemporalFeeDepositPage(),
                                          callback: (callbackResult) {
                                            if(callbackResult != null) {
                                              BackFromThisPage(context: context, callbackData: callbackResult).go();
                                            }
                                          },
                                        ).go();
                                      }
                                    }
                                ).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/icon_daftar_iuran.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Daftar Iuran Saya',
                                              style: MTextStyles.medium().copyWith(
                                                color: TextColorStyles.textPrimary(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Lihat daftar detail Iuran wajib & berjangka',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              child: InkWell(
                                onTap: () => BackFromThisPage(context: context, callbackData: false).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/icon_riwayat_iuran.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Riwayat Iuran',
                                              style: MTextStyles.medium().copyWith(
                                                color: TextColorStyles.textPrimary(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Riwayat Transaksi Iuran',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                      ),
                                    ],
                                  ),
                                ),
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
    );
  }
}
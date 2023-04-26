import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/fee_services/api_temporal_fee_services.dart';
import 'package:kenari_app/services/api/models/temporal_fee_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TemporalFeeDetailPage extends StatefulWidget {
  final String temporalFeeId;

  const TemporalFeeDetailPage({
    super.key,
    required this.temporalFeeId,
  });

  @override
  State<TemporalFeeDetailPage> createState() => _TemporalFeeDetailPageState();
}

class _TemporalFeeDetailPageState extends State<TemporalFeeDetailPage> {
  TemporalFeeData? temporalFeeData;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APITemporalFeeServices(context: context).callById(widget.temporalFeeId).then((callResult) {
      setState(() {
        temporalFeeData = callResult;
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
                            'Daftar Iuran Saya',
                            style: Theme.of(context).textTheme.headlineSmall,
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
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          temporalFeeData != null && temporalFeeData!.statusPencairan != true ?
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
                                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                          color: InfoColorStyles.infoMain(),
                                          fontWeight: FontBodyWeight.medium(),
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
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                  temporalFeeData != null && temporalFeeData!.jumlahIuran != null ? 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(temporalFeeData!.jumlahIuran!)).replaceAll(',', '.')}' : 'Rp 0',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
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
                                style: Theme.of(context).textTheme.bodyMedium!,
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
                                      temporalFeeData != null && temporalFeeData!.pertumbuhanSaldo != null ? 'Rp ${NumberFormat('#,###', 'en_id').format(double.parse(temporalFeeData!.pertumbuhanSaldo!)).replaceAll(',', '.')}' : 'Rp 0',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
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
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                temporalFeeData != null && temporalFeeData!.jangkaWaktu != null ? '${temporalFeeData!.jangkaWaktu} Bulan' : 'Unknown',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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
                                'Imbal hasil pertahun',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                temporalFeeData != null &&  temporalFeeData!.imbalHasil != null ? '${temporalFeeData!.imbalHasil}%' : 'Unknown',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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
                                'Tanggal mulai',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                temporalFeeData != null && temporalFeeData!.tanggalMulai != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(temporalFeeData!.tanggalMulai!)) : 'Unknown',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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
                                'Tanggal pencairan',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                temporalFeeData != null && temporalFeeData!.tanggalPencairan != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(temporalFeeData!.tanggalPencairan!)) : 'Unknown',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
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
                          temporalFeeData != null && temporalFeeData!.statusPencairan != null && temporalFeeData!.statusPencairan != false ?
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
                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                      color: SuccessColorStyles.successMain(),
                                      fontWeight: FontBodyWeight.medium(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) :
                          const Material(),
                          Text(
                            'Pencairan Saldo',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
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
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      temporalFeeData != null && temporalFeeData!.member != null && temporalFeeData!.member!.phoneNumber != null ? temporalFeeData!.member!.phoneNumber! : 'Unknown',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
                                    ),
                                    Text(
                                      temporalFeeData != null && temporalFeeData!.member != null && temporalFeeData!.member!.name != null ? 'a/n ${temporalFeeData!.member!.name!}' : 'Unknown',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class MandatoryFeeDetailPage extends StatefulWidget {
  const MandatoryFeeDetailPage({super.key});

  @override
  State<MandatoryFeeDetailPage> createState() => _MandatoryFeeDetailPageState();
}

class _MandatoryFeeDetailPageState extends State<MandatoryFeeDetailPage> {
  String? name;
  String? companyCode;
  String? phoneNumber;

  int mandatoryFeeDummy = 10;

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

      await LocalSharedPrefs().readKey('company_code').then((codeResult) async {
        setState(() {
          companyCode = codeResult;
        });

        await LocalSharedPrefs().readKey('phone').then((phoneResult) async {
          setState(() {
            phoneNumber = phoneResult;
          });
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
                            'Detail Iuran Wajib',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      name ?? 'Unknown User',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: TextColorStyles.textPrimary(),
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      companyCode ?? 'Unknown Company',
                                      style: Theme.of(context).textTheme.labelSmall!,
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                thickness: 1.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Saldo Iuran Wajib',
                                      style: Theme.of(context).textTheme.labelSmall!,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Rp 1.200.000',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: TextColorStyles.textPrimary(),
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: WarningColorStyles.warningSurface(),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info,
                                  color: WarningColorStyles.warningMain(),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Selama aktif menjadi karyawan, Saldo Iuran Wajib tidak dapat di tarik',
                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                      color: WarningColorStyles.warningMain(),
                                      fontWeight: FontBodyWeight.medium(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Penagihan Autodebet',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                        child: Image.asset(
                                          'assets/images/dipay_logo_only.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Dipay',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: TextColorStyles.textPrimary(),
                                          fontWeight: FontBodyWeight.medium(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              phoneNumber ?? 'Unknown Phone',
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                color: TextColorStyles.textPrimary(),
                                                fontWeight: FontBodyWeight.medium(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: NeutralColorStyles.neutral05(),
                                  ),
                                  Text(
                                    'Pembayaran Autodebet untuk Penagihan Iuran Wajib setiap bulannya langsung terpotong dari saldo Dipay.',
                                    style: Theme.of(context).textTheme.bodySmall!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.separated(
                        itemCount: mandatoryFeeDummy,
                        separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                          return const Divider(
                            height: 1.0,
                            indent: 25.0,
                            endIndent: 25.0,
                          );
                        },
                        itemBuilder: (BuildContext listContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                index == 0 ?
                                Text(
                                  DateFormat('yyyy').format(DateTime.now()),
                                  style: Theme.of(context).textTheme.labelSmall!,
                                ) :
                                const Material(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Autodebet Iuran',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: TextColorStyles.textPrimary(),
                                          fontWeight: FontBodyWeight.medium(),
                                        ),
                                      ),
                                      Text(
                                        'Rp 100.000',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: SuccessColorStyles.successMain(),
                                          fontWeight: FontBodyWeight.medium(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now()),
                                  style: Theme.of(context).textTheme.bodySmall!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: NeutralColorStyles.neutral04(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Tarik Saldo',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.black54,
                              fontWeight: FontBodyWeight.medium(),
                            ),
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
    );
  }
}
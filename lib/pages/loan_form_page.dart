import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_result_page.dart';
import 'package:kenari_app/services/api/loan_services/api_loan_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_loan_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanFormPage extends StatefulWidget {
  const LoanFormPage({super.key});

  @override
  State<LoanFormPage> createState() => _LoanFormPageState();
}

class _LoanFormPageState extends State<LoanFormPage> {
  String? name;

  int? selectedTerm;

  double loanAmount = 0.0;

  bool isExpandDetail = false;
  bool isAgreed = false;

  List<int> termList = [
    1, 2, 3, 6, 9, 12,
  ];

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
                            'Ajukan Pendanaan',
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
                            'Periode Pendanaan',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 3.0,
                            ),
                            itemCount: termList.length,
                            itemBuilder: (BuildContext listContext, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: selectedTerm == termList[index] ?
                                    PrimaryColorStyles.primaryMain() :
                                    BorderColorStyles.borderStrokes(),
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTerm = termList[index];
                                      });
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${termList[index]} Bulan',
                                        style: selectedTerm == termList[index] ?
                                        STextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                          fontWeight: FontWeight.bold,
                                        ) :
                                        STextStyles.regular(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Pengajuan Pendanaan',
                            style: STextStyles.medium(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Rp ',
                                style: MTextStyles.medium(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  NumberFormat('#,###', 'en_id').format(loanAmount * 1000000).replaceAll(',', '.'),
                                  style: HeadingTextStyles.headingL(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                            ),
                            child: Slider(
                              value: loanAmount,
                              onChanged: (newValue) {
                                setState(() {
                                  loanAmount = newValue;
                                });
                              },
                              min: 0.0,
                              max: 10.0,
                              divisions: 100,
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
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Jumlah yang diajukan',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp ${NumberFormat('#,###', 'en_id').format(loanAmount * 1000000).replaceAll(',', '.')}",
                                      style: STextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Divider(
                              height: 1.0,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Biaya Admin (3%)',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp ${NumberFormat('#,###', 'en_id').format((loanAmount * 1000000) * 0.03).replaceAll(',', '.')}",
                                      style: STextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Divider(
                              height: 1.0,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Jumlah yang diterima',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rp ${NumberFormat('#,###', 'en_id').format((loanAmount * 1000000) - ((loanAmount * 1000000) * 0.03)).replaceAll(',', '.')}",
                                      style: STextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                            child: Divider(
                              height: 1.0,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isExpandDetail = !isExpandDetail;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pembayaran Pendanaan Bulanan',
                                      style: STextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp ${NumberFormat('#,###', 'en_id').format(((loanAmount * 1000000) / (selectedTerm ?? 1)) + (loanAmount * 1000000) * 0.0395).replaceAll(',', '.')}",
                                            style: STextStyles.medium(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      isExpandDetail == false ? Icons.expand_more : Icons.expand_less,
                                      size: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          isExpandDetail == true ?
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pokok',
                                      style: STextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp ${NumberFormat('#,###', 'en_id').format((loanAmount * 1000000) / (selectedTerm ?? 1)).replaceAll(',', '.')}",
                                            style: STextStyles.medium(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Biaya cicilan (3.95% / Bulan)',
                                      style: STextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp ${NumberFormat('#,###', 'en_id').format((loanAmount * 1000000) * 0.0395).replaceAll(',', '.')}",
                                            style: STextStyles.medium(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ) :
                          const Material(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Akun Dipay',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/dipay_logo_only.png',
                                fit: BoxFit.contain,
                                width: 25.0,
                                height: 25.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  name ?? 'Unknown User',
                                  style: STextStyles.medium(),
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
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isAgreed,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (onChanged) {
                            setState(() {
                              isAgreed = !isAgreed;
                            });
                          },
                        ),
                        Text(
                          'Saya telah membaca dan menyetujui ',
                          style: XSTextStyles.regular(),
                          textAlign: TextAlign.justify,
                        ),
                        Expanded(
                          child: Text(
                            '"Perjanjian pendanaan"',
                            style: XSTextStyles.regular().copyWith(
                              color: PrimaryColorStyles.primaryMain(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(selectedTerm != null && loanAmount != 0.0 && isAgreed == true) {
                          OptionDialog(
                            context: context,
                            title: 'Pengajuan Pendanaan',
                            message: 'Apakah anda yakin untuk melanjutkan pengajuan pendanaan?',
                            yesText: 'Ya, Ajukan',
                            yesFunction: () async {
                              await LocalSharedPrefs().readKey('member_id').then((memberId) async {
                                await APILoanServices(context: context).writeTransaction(
                                  LocalLoanData(memberId: memberId, submissionAmount: (loanAmount * 1000000), adminFeePercentage: 3, monthlyInterestPercentage: 3.95, period: selectedTerm!),
                                ).then((writeResult) {
                                  if(writeResult.apiResult == true) {
                                    MoveToPage(
                                      context: context,
                                      target: const LoanResultPage(),
                                      callback: (callbackResult) {
                                        if(callbackResult != null) {
                                          BackFromThisPage(context: context, callbackData: callbackResult).go();
                                        }
                                      },
                                    ).go();
                                  } else {
                                    OkDialog(context: context, message: 'Gagal mengirim permintaan, silahkan coba lagi').show();
                                  }
                                });
                              });
                            },
                            noFunction: () {},
                          ).show();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTerm != null && loanAmount != 0.0 && isAgreed == true ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Ajukan',
                          style: LTextStyles.medium().copyWith(
                            color: selectedTerm != null && loanAmount != 0.0 && isAgreed == true ? LTextStyles.regular().color : Colors.black54,
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
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/bank_account_form_page.dart';
import 'package:kenari_app/services/api/profile_services/api_bank_services.dart';
import 'package:kenari_app/services/api/models/bank_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  BankModel? bankModel;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APIBankServices(context: context).getBankByMemberId().then((bankResult) {
      setState(() {
        bankModel = bankResult;
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
                            'Daftar Rekening',
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
              child: bankModel != null && bankModel!.bankData != null && bankModel!.bankData!.isNotEmpty ?
              RefreshIndicator(
                onRefresh: () async {
                  loadData();
                },
                child: ListView.builder(
                  itemCount: bankModel!.bankData!.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return bankModel!.bankData![index].bank != null ?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                bankModel!.bankData![index].bank!.name ?? '(Bank tidak diketahui)',
                                style: MTextStyles.medium(),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                bankModel!.bankData![index].accountNo ?? '(Nomor rekening tidak diketahui)',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'a.n ${bankModel!.bankData![index].accountName ?? '(Nama pemilik rekening tidak diketahui)'}',
                                style: STextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  MoveToPage(
                                    context: context,
                                    target: BankAccountFormPage(editData: bankModel!.bankData![index]),
                                    callback: (callback) {
                                      if(callback != null && callback == true) {
                                        loadData();
                                      }
                                    },
                                  ).go();
                                },
                                child: Text(
                                  'Ubah Rekening',
                                  style: MTextStyles.medium().copyWith(
                                    color: PrimaryColorStyles.primaryMain(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ) :
                    const Material();
                  },
                ),
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/icon_empty.png',
                        width: 200.0,
                        height: 200.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Data tidak ditemukan',
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      loadData();
                    },
                    child: ListView(),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    MoveToPage(
                      context: context,
                      target: const BankAccountFormPage(),
                      callback: (callback) {
                        if(callback != null && callback == true) {
                          loadData();
                        }
                      },
                    ).go();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Tambah Rekening',
                      style: LTextStyles.medium().copyWith(
                        color: Colors.white,
                      ),
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
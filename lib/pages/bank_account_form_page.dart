import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/models/local_bank_account_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class BankAccountFormPage extends StatefulWidget {
  final LocalBankAccountData? editData;

  const BankAccountFormPage({
    super.key,
    this.editData,
  });

  @override
  State<BankAccountFormPage> createState() => _BankAccountFormPageState();
}

class _BankAccountFormPageState extends State<BankAccountFormPage> {
  LocalBankAccountData? bankAccountData;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    setState(() {
      bankAccountData = widget.editData;

      if(bankAccountData != null) {
        bankNameController.text = bankAccountData!.bankName;
        accountNameController.text = bankAccountData!.accountName;
        accountNumberController.text = bankAccountData!.accountNumber;
      }
    });
  }

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
                      widget.editData != null ? 'Ubah Rekening' : 'Tambah Rekening',
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
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pilih Jenis Bank',
                          style: STextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: bankNameController,
                          decoration: InputDecoration(
                            hintText: 'Pilih bank',
                            hintStyle: MTextStyles.regular(),
                            suffixIcon: const Icon(
                              Icons.expand_more_outlined,
                            ),
                          ),
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            setState(() {

                            });
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Nama Pemilik Rekening',
                          style: STextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: accountNameController,
                          decoration: InputDecoration(
                            hintText: 'Silahkan isi nama pemilik',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            setState(() {

                            });
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Nomor Rekening',
                          style: STextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: accountNumberController,
                          decoration: InputDecoration(
                            hintText: 'Silahkan isi nomor rekening',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bankNameController.text != '' && accountNameController.text != '' && accountNumberController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Simpan',
                        style: LTextStyles.medium().copyWith(
                          color: bankNameController.text != '' && accountNameController.text != '' && accountNumberController.text != '' ? Colors.white : NeutralColorStyles.neutral06(),
                        ),
                      ),
                    ),
                  ),
                  widget.editData != null ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primarySurface(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Hapus Rekening',
                            style: LTextStyles.medium().copyWith(
                              color: PrimaryColorStyles.primaryMain(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) :
                  const Material()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
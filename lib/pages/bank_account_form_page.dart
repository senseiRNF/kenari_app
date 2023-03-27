import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/profile/api_bank_services.dart';
import 'package:kenari_app/services/api/models/bank_model.dart';
import 'package:kenari_app/services/api/models/list_bank_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_bank_account_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class BankAccountFormPage extends StatefulWidget {
  final BankData? editData;

  const BankAccountFormPage({
    super.key,
    this.editData,
  });

  @override
  State<BankAccountFormPage> createState() => _BankAccountFormPageState();
}

class _BankAccountFormPageState extends State<BankAccountFormPage> {
  List<ListBankData> bankList = [];

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  String? bankId;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  void initLoad() async {
    setState(() {
      if(widget.editData != null && widget.editData!.bank != null) {
        bankNameController.text = widget.editData!.bank!.name ?? '';
        accountNameController.text = widget.editData!.accountName ?? '';
        accountNumberController.text = widget.editData!.accountNo ?? '';

        bankId = widget.editData!.bank!.sId;
      }
    });

    await APIBankServices(context: context).getListBank().then((listResult) {
      if(listResult != null && listResult.listBankData != null) {
        setState(() {
          bankList = listResult.listBankData!;
        });
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
                        Stack(
                          children: [
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
                              enabled: false,
                            ),
                            DropdownButton(
                              onChanged: (newValue) {
                                if(newValue != null) {
                                  setState(() {
                                    bankNameController.text = newValue.name ?? '';
                                    bankId = newValue.sId;
                                  });
                                }
                              },
                              isExpanded: true,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.transparent,
                              ),
                              underline: const Material(),
                              items: bankList.map<DropdownMenuItem<ListBankData>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                    child: Text(
                                      value.name ?? 'Unknown Bank',
                                      style: STextStyles.regular(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 1.0,
                          color: Colors.black87,
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
                    onPressed: () async {
                      if(widget.editData == null) {
                        await LocalSharedPrefs().readKey('member_id').then((memberId) async {
                          await APIBankServices(context: context).createBankData(
                            LocalBankAccountData(
                              bankId: bankId ?? '',
                              memberId: memberId ?? '',
                              accountNumber: accountNumberController.text,
                              accountName: accountNameController.text,
                            ),
                          ).then((createResult) {
                            if(createResult == true) {
                              OkDialog(
                                context: context,
                                message: 'Sukses menambahkan data rekening baru',
                                okText: 'Oke',
                                okFunction: () {
                                  BackFromThisPage(context: context, callbackData: true).go();
                                },
                              ).show();
                            }
                          });
                        });
                      } else {
                        await LocalSharedPrefs().readKey('member_id').then((memberId) async {
                          await APIBankServices(context: context).updateBankData(
                            widget.editData!.sId,
                            LocalBankAccountData(
                              bankId: bankId ?? '',
                              memberId: memberId ?? '',
                              accountNumber: accountNumberController.text,
                              accountName: accountNameController.text,
                            ),
                          ).then((updateResult) {
                            if(updateResult == true) {
                              OkDialog(
                                context: context,
                                message: 'Sukses memperbaharui data rekening',
                                okText: 'Oke',
                                okFunction: () {
                                  BackFromThisPage(context: context, callbackData: true).go();
                                },
                              ).show();
                            }
                          });
                        });
                      }
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
                          OptionDialog(
                            context: context,
                            message: 'Hapus data rekening, Anda yakin?',
                            yesFunction: () async {
                              await APIBankServices(context: context).deleteBankData(widget.editData!.sId).then((deleteResult) {
                                if(deleteResult == true) {
                                  OkDialog(
                                    context: context,
                                    message: 'Sukses menghapus data rekening',
                                    okText: 'Oke',
                                    okFunction: () {
                                      BackFromThisPage(context: context, callbackData: true).go();
                                    },
                                  ).show();
                                }
                              });
                            },
                            noFunction: () {},
                          ).show();
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
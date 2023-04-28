import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/bank_account_page.dart';
import 'package:kenari_app/pages/change_password_page.dart';
import 'package:kenari_app/pages/company_address_page.dart';
import 'package:kenari_app/pages/dipay_activation_page.dart';
import 'package:kenari_app/pages/edit_profile_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProfileFragment extends StatelessWidget {
  final String? name;
  final String? companyCode;
  final Function refreshPage;
  final Function onLogout;

  const ProfileFragment({
    super.key,
    required this.name,
    required this.companyCode,
    required this.refreshPage,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: PrimaryColorStyles.primaryMain(),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 40.0,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: InkWell(
                                          onTap: () {
                                            MoveToPage(
                                              context: context,
                                              target: const EditProfilePage(),
                                              callback: (callback) {
                                                if(callback != null && callback == true) {
                                                  refreshPage();
                                                }
                                              },
                                            ).go();
                                          },
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Edit Profile',
                                                  style: XSTextStyles.medium().copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5.0,
                                                ),
                                                const Icon(
                                                  Icons.edit_square,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              name ?? 'Unknown User',
                              style: MTextStyles.regular(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              companyCode ?? 'Unknown Code',
                              style: XSTextStyles.regular(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BorderColorStyles.borderStrokes(),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 25.0,
                                        child: Image.asset(
                                          'assets/images/saldo_dipay_logo.png',
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          MoveToPage(context: context, target: const DipayActivationPage()).go();
                                        },
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Aktivasi Dipay',
                                            style: STextStyles.medium().copyWith(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BorderColorStyles.borderStrokes(),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Iuran Wajib',
                                                style: STextStyles.regular(),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Rp 0',
                                                style: STextStyles.medium(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: BorderColorStyles.borderDivider(),
                                          width: 1.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Iuran Berjangka',
                                                style: STextStyles.regular(),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'Rp 0',
                                                style: STextStyles.medium(),
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
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                              child: InkWell(
                                onTap: () {
                                  MoveToPage(context: context, target: const ChangePasswordPage()).go();
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Ubah Kata Sandi',
                                          style: MTextStyles.regular(),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: InkWell(
                                onTap: () {
                                  MoveToPage(context: context, target: const CompanyAddressPage()).go();
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Daftar Alamat',
                                          style: MTextStyles.regular(),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                              child: InkWell(
                                onTap: () {
                                  MoveToPage(context: context, target: const BankAccountPage()).go();
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Daftar Rekening',
                                          style: MTextStyles.regular(),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: IconColorStyles.iconColor(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          onTap: () {
                            OptionDialog(
                              context: context,
                              message: 'Keluar dari sesi, Anda yakin?',
                              yesFunction: () async {
                                onLogout();
                              },
                              noFunction: () {},
                            ).show();
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Keluar',
                                    style: MTextStyles.regular().copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
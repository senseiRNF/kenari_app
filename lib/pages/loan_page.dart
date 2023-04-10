import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_form_page.dart';
import 'package:kenari_app/pages/loan_list_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  bool isCompletedStep = false;

  bool isDipayActivated = false;
  bool isDipayKYC = false;
  bool isIndofundActivated = false;
  bool isIndofundKYC = false;

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
                            'Pendanaan',
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
              child: isCompletedStep == false ?
              ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: NeutralColorStyles.neutral02(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset(
                              'assets/images/icon_pinjaman.png',
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Text(
                              'Untuk dapat mengajukan pendanaan, Anda perlu menyelesaikan langkah berikut ini:',
                              style: STextStyles.regular(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: Image.asset(
                                    'assets/images/dipay_logo_only.png',
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'dipay',
                                  style: MTextStyles.medium().copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15.0,
                                    height: 15.0,
                                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                    decoration: BoxDecoration(
                                      color: isDipayActivated == true ? SuccessColorStyles.successMain() : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Aktivasi Dipay',
                                              style: STextStyles.regular(),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Login ke akun Dipay. Registrasi diperlukan jika belum memiliki akun.',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isDipayActivated == false ?
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isDipayActivated =  true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Aktivasi',
                                              style: MTextStyles.medium().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) :
                                      const Material(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 15.0,
                                height: 15.0,
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  color: isDipayKYC == true ? SuccessColorStyles.successMain() : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'KYC akun Dipay',
                                              style: STextStyles.regular(),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Upgrade akun Dipay menjadi Premium',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isDipayActivated == true && isDipayKYC == false ?
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isDipayKYC = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'KYC',
                                              style: MTextStyles.medium().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) :
                                      const Material(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/indofund_logo_black.png',
                                width: 80.0,
                                height: 80.0,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15.0,
                                    height: 15.0,
                                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                    decoration: BoxDecoration(
                                      color: isIndofundActivated == true ? SuccessColorStyles.successMain() : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Aktivasi akun Indofund',
                                              style: STextStyles.regular(),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Login ke akun Indofund. Registrasi diperlukan jika belum memiliki akun.',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isIndofundActivated == false ?
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isIndofundActivated = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'Aktivasi',
                                              style: MTextStyles.medium().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) :
                                      const Material(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 15.0,
                                height: 15.0,
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  color: isIndofundKYC == true ? SuccessColorStyles.successMain() : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'KYC akun Indofund',
                                              style: STextStyles.regular(),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Lakukan KYC pada akun Indofund',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      isIndofundActivated == true && isIndofundKYC == false ?
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isIndofundKYC = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'KYC',
                                              style: MTextStyles.medium().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ) :
                                      const Material(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ) :
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Container(
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
                                      'Plafon',
                                      style: XSTextStyles.regular(),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Rp 10.000.000',
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
                                      'Total Tagihan',
                                      style: XSTextStyles.regular(),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Rp 0',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Container(
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
                          onTap: () {
                            MoveToPage(
                              context: context,
                              target: const LoanFormPage(),
                              callback: (callbackResult) {
                                if(callbackResult != null) {
                                  BackFromThisPage(context: context, callbackData: callbackResult).go();
                                }
                              },
                            ).go();
                          },
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
                                        'assets/images/icon_pengajuan_pinjaman.png',
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
                                        'Ajukan Pendanaan',
                                        style: MTextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Aman dengan bunga kompetitif',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Container(
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
                          onTap: () {
                            BackFromThisPage(context: context, callbackData: false).go();
                          },
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
                                        'assets/images/icon_riwayat_pinjaman.png',
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
                                        'Histori Pendanaan',
                                        style: MTextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Lihat daftar peminjaman Anda',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Container(
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
                          onTap: () {
                            MoveToPage(
                              context: context,
                              target: const LoanListPage(),
                              callback: (callbackResult) {
                                if(callbackResult != null) {
                                  BackFromThisPage(context: context, callbackData: callbackResult).go();
                                }
                              },
                            ).go();
                          },
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
                                        'assets/images/icon_pembayaran_pinjaman.png',
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
                                        'Pembayaran Pendanaan',
                                        style: MTextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Lihat total tagihan dan bayar disini!',
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
                  ),
                ],
              ),
            ),
            isCompletedStep == false ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(isDipayActivated == true && isDipayKYC == true && isIndofundActivated == true && isIndofundKYC == true) {
                      setState(() {
                        isCompletedStep = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDipayActivated == true && isDipayKYC == true && isIndofundActivated == true && isIndofundKYC == true ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Selanjutnya',
                      style: LTextStyles.medium().copyWith(
                        color: isDipayActivated == true && isDipayKYC == true && isIndofundActivated == true && isIndofundKYC == true ? LTextStyles.regular().color : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ) :
            const Material(),
          ],
        ),
      ),
    );
  }
}
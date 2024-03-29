import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/authorization_services/api_register_services.dart';
import 'package:kenari_app/services/local/jsons/register_form_result.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class RegisterFormPage extends StatefulWidget {
  final String? companyId;
  final String? companyCode;
  final String? companyName;

  const RegisterFormPage({
    super.key,
    required this.companyId,
    required this.companyCode,
    required this.companyName,
  });

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfPassword = true;

  bool showErrorNameHint = false;
  bool showErrorPhoneHint = false;
  bool showErrorEmailHint = false;
  bool showErrorPasswordHint = false;
  bool showErrorPasswordConfHint = false;

  late String errorNameMessage;
  late String errorPhoneMessage;
  late String errorEmailMessage;
  late String errorPasswordMessage;
  late String errorPasswordConfMessage;

  void checkForm() {
    bool isValid = true;

    RegExp checkPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if(nameController.text == '') {
      isValid = false;

      setState(() {
        showErrorNameHint = true;
        errorNameMessage = 'Harap masukkan nama terlebih dahulu';
      });
    }

    if(phoneController.text == '') {
      isValid = false;

      setState(() {
        showErrorPhoneHint = true;
        errorPhoneMessage = 'Harap masukkan nomor terlebih dahulu';
      });
    }

    if(phoneController.text.length < 10) {
      isValid = false;

      setState(() {
        showErrorPhoneHint = true;
        errorPhoneMessage = 'Nomor minimal 11 digit, maksimal 13 digit';
      });
    }

    if(emailController.text == '') {
      isValid = false;

      setState(() {
        showErrorEmailHint = true;
        errorEmailMessage = 'Harap masukkan email terlebih dahulu';
      });
    }

    if(EmailValidator.validate(emailController.text) == false) {
      isValid = false;

      setState(() {
        showErrorEmailHint = true;
        errorEmailMessage = 'Format penulisan email salah';
      });
    }

    if(passwordController.text == '') {
      isValid = false;

      setState(() {
        showErrorPasswordHint = true;
        errorPasswordMessage = 'Harap masukkan password terlebih dahulu';
      });
    }

    if(!checkPassword.hasMatch(passwordController.text) == true) {
      isValid = false;

      setState(() {
        showErrorPasswordHint = true;
        errorPasswordMessage = 'Password minimal 8 karakter, terdiri dari huruf kapital, huruf kecil, simbol dan angka';
      });
    }

    if(confirmPasswordController.text == '' || confirmPasswordController.text != passwordController.text) {
      isValid = false;

      setState(() {
        showErrorPasswordConfHint = true;
        errorPasswordConfMessage = confirmPasswordController.text != '' ? 'Password harus sama' : 'Harap masukkan kembali password terlebih dahulu';
      });
    }

    if(isValid == true) {
      showUserAgreementBottomDialog().then((result) async {
        if(result != null && result == true) {
          await APIRegisterServices(
            context: context,
            companyId: widget.companyId,
            name: nameController.text,
            phone: phoneController.text,
            email: emailController.text,
            password: passwordController.text,
          ).register().then((callResult) {
            if(callResult.apiResult == true) {
              BackFromThisPage(
                context: context,
                callbackData: RegisterFormResult(
                  registerResult: true,
                  email: emailController.text,
                ),
              ).go();
            } else {
              if(callResult.dioException != null && callResult.dioException!.response != null && callResult.dioException!.response!.statusCode == 412) {
                if(callResult.dioException!.response!.data['data']['errors']['name'] != null) {
                  setState(() {
                    showErrorNameHint = true;
                    errorNameMessage = 'Harap masukkan nama terlebih dahulu';
                  });
                }

                if(callResult.dioException!.response!.data['data']['errors']['email'] != null) {
                  setState(() {
                    showErrorEmailHint = true;
                    errorEmailMessage = 'Email telah terdaftar!';
                  });
                }

                if(callResult.dioException!.response!.data['data']['errors']['phone'] != null) {
                  setState(() {
                    showErrorPhoneHint = true;
                    errorPhoneMessage = 'Nomor telah tedaftar';
                  });
                }

                if(callResult.dioException!.response!.data['data']['errors']['password'] != null) {
                  setState(() {
                    showErrorPasswordHint = true;
                    errorPasswordMessage = 'Password minimal 8 karakter, terdiri dari huruf kapital, huruf kecil, simbol dan angka';
                  });
                }
              }
            }
          });
        }
      });
    }
  }

  Future<bool?> showUserAgreementBottomDialog() async {
    bool? result;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalBottomSheet) {
        bool enableCheckbox = false;
        bool isAgreed = false;

        ScrollController controller = ScrollController();

        return StatefulBuilder(builder: (BuildContext bottomContext, stateSetter) {
          return FractionallySizedBox(
            heightFactor: 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 5.0,
                    width: 60.0,
                    color: NeutralColorStyles.neutral04(),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Syarat dan Ketentuan Umum Kenari',
                          style: LTextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Kebijakan Privasi',
                          style: MTextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Latar Belakang',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kebijakan Privasi (“Kebijakan”) ini berlaku dan mengikat seluruh pengunjung portal Indofund baik melalui website (www.indofund.co.id) maupun aplikasi mobile (aplikasi Indofund) (“Portal”), khususnya anggota Indofund yang telah terdaftar, termasuk Anda. Dengan terus mengakses dan/atau menggunakan layanan yang tersedia pada Portal, maka Anda mengakui bahwa Anda telah membaca dan menyetujui Kebijakan ini.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1.2',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kebijakan ini dibuat agar Anda mengetahui perolehan, pengumpulan, pengolahan, penganalisisan, penyimpanan, penampilan, penyebarluasan, pembukaan akses dan pemusnahan atas data-data pribadi Anda yang kami lakukan, sebelum Anda memberikan data pribadi Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '2.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Perolehan dan/atau Pengumpulan Informasi',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami mengumpulkan informasi dan data pribadi Anda (i) yang Anda berikan secara langsung kepada kami, (ii) yang terkait dengan penggunaan Portal oleh Anda, dan (iii) yang diberikan oleh pihak ketiga dengan persetujuan Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2.2',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Data pribadi Anda sebagaimana disebut dalam Angka 2.1 di atas termasuk, namun tidak terbatas pada:',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(a).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'data identitas dan profil Anda, termasuk KTP, NPWP, nama lengkap, tempat tanggal lahir, jenis kelamin, alamat, nomor rekening, agama, pekerjaan, tujuan penggunaan, sumber dana, alamat email, nomor telepon, informasi keuangan, foto, latar belakang pendidikan dan pekerjaan, dan informasi terkait identitas dan profil lainnya;',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(b).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'pola atau kebiasaan Anda dalam penggunaan Portal, profil risiko Anda, portofolio pemberian pendanaan Anda, sejarah pencarian atau penggunaan layanan, transaksi yang Anda lakukan di Portal, dan informasi terkait pola atau kebiasaan lainnya;',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(c).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'alamat IP Anda, informasi log-in Anda, perangkat keras dan perangkat lunak (termasuk tipe dan versi browser) yang Anda gunakan, serta informasi teknis lainnya terkait penggunaan Portal oleh Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: Text(
                                '(Informasi sebagaimana disebut dalam Angka 2.2 di atas selanjutnya disebut sebagai “Data Pribadi” Anda)',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '3.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Pengolahan dan Penganalisisan Informasi',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami menggunakan Data Pribadi Anda untuk (i) memverifikasi kelayakan Anda sebagai pengguna, (ii) memberikan akses layanan yang disediakan di Portal kepada Anda, (iii) menyelesaikan hak dan kewajiban kepada Anda sebagai pengguna Portal, (iv) mengawasi penggunaan layanan di Portal oleh Anda, (v) memproses dan mengelola akun Anda, (vi) memberikan otorisasi penggunaan akun Anda di Portal, (vii) mendeteksi, mencegah, dan menyangkal setiap tindakan melawan hukum terhadap atau oleh Anda, (viii) melakukan audit internal maupun external, (ix) melakukan pemasaran yang efektif dan relevan, dan (x) untuk hal-hal lainnya yang terkait dengan kegiatan usaha Akseleran sebagai Penyelenggara Layanan Pinjam-Meminjam Uang berbasis Teknologi Informasi.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3.2',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami melakukan pengolahan dan analisis data identitas dan profil Anda, pola atau kebiasaan Anda dalam penggunaan Portal, serta informasi teknis terkait penggunaan Portal oleh Anda, dengan tujuan (i) untuk meningkatkan layanan yang dapat kami berikan kepada seluruh pengguna Portal maupun (ii) untuk meningkatkan performa usaha Portal, termasuk sebagai bahan targeted marketing kami.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '4.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Penyimpanan Data',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami melakukan penyimpanan Data Pribadi Anda dengan teknologi enkripsi sesuai standar ISO 27001 untuk memastikan keamanan Data Pribadi Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4.2',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Data Pribadi Anda kami simpan paling tidak sampai dengan 5 tahun sejak Anda berakhir menjadi pengguna Portal kami, sesuai dengan persyaratan dalam peraturan-perundang-undangan. Apabila Anda ingin agar Data Pribadi Anda dihapus sebelum itu, maka Anda dapat mengirimkan permohonan kepada Customer Service.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '4.3',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Data Pribadi Anda kami simpan pada pusat data kami serta pusat pemulihan bencana kami yang berlokasi di Indonesia.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '5.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Pengungkapan dan Pembukaan Akses',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami akan menjaga kerahasiaan Data Pribadi Anda. Namun demikian, Anda setuju bahwa kami dapat mengungkapkan Data Pribadi Anda kepada pihak yang dianggap perlu oleh kami yang terkait dengan kegiatan usaha kami sebagai Penyelenggara Layanan Pinjam-Meminjam Uang Berbasis Teknologi Informasi, termasuk namun tidak terbatas kepada:',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(a).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'direktur, komisaris, atau karyawan Indofund;',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(b).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'mitra serta penyedia jasa penunjang atas aktifitas usaha Indofund, termasuk mitra kerjasama channeling, penyedia payment gateway, penyedia sistem analisis psychometric, bank, penyelenggara sertifikasi elektronik untuk pembuatan tanda tangan elektronik, konsultan atau penyedia jasa penilaian kelayakan usaha dan kredit, konsultan hukum, konsultan keuangan, konsultan teknis dan konsultan pajak yang ditunjuk Indofund untuk memberikan jasa penunjang yang relevan;',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(c).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Fintech Data Center (FDC) yang didirikan oleh Asosiasi Fintech Pendanaan Bersama Indonesia (AFPI), untuk keperluan pelaporan data kredit Anda sebagai Penerima Pendanaan di Indofund;',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(d).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'pihak-pihak lain yang terkait dengan kegiatan usaha Indofund; dan',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '(e).',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'pihak yang berwenang sesuai dengan ketentuan peraturan perundang-undangan.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '6.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Perubahan Data Pribadi',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '6.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Anda berkewajiban untuk menjaga keakurasian dari Data Pribadi Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '6.2',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Anda dapat mengubah Data Pribadi terdaftar Anda melalui Portal.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '6.3',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Kami dapat melakukan tindakan-tindakan yang diperlukan untuk memastikan keakuratan dan kemutakhiran Data Pribadi Anda, termasuk dengan menghubungi Anda.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '7.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Data Pribadi Anak Bawah Umur',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '7.1',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Dalam hal terdapat Data Pribadi dari pengguna yang ternyata masuk dalam kategori anak di bawah 17 tahun, maka orang tua atau wali dari anak bawah umur tersebut dapat meminta Indofund untuk menghapus Data Pribadi anak tersebut dengan mengirimkan permohonan kepada Customer Service.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '8.',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                'Perubahan Kebijakan Privasi',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Setiap perubahan atas Kebijakan ini akan tertera pada halaman ini, dan apabila dipandang perlu akan diberitahukan kepada seluruh pengguna terdaftar melalui email atau metode lainnya.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'DEMIKIANLAH KEBIJAKAN PRIVASI INI DISETUJUI OLEH DAN MENGIKAT ANDA YANG MENGAKSES PORTAL DAN/ATAU TERDAFTAR SEBAGAI ANGGOTA INDOFUND.',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Konfirmasi Penggunaan Data Lender',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Untuk memenuhi regulasi T+2 yang ditentukan oleh OJK, maka Indofund akan menerapkan sistem auto-withdraw. Dimana saldo di dompet Indofund yang mengendap lebih dari dua hari akan dikenakan proses auto-withdraw (ditarik dan dikembalikan ke rekening bank terdaftar atau Dipay secara otomatis). Pengembalian akan dilakukan setiap hari senin, rabu dan jumat. Apabila Lender sudah melakukan aktivasi akun Dipay maka saldo akan dipindahkan ke Dipay, jika belum maka akan dipindahkan ke rekening bank utama.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Anda akan menggunakan jasa PT Solusi Net Internusa selaku penyelenggara tanda tangan elektronik dengan merek Digisign yang terdaftar pada Kementerian Komunikasi dan Informatika Republik Indonesia untuk keperluan tanda tangan digital dokumen elektronik Anda dan Indofund.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Anda memberikan kuasa kepada PT Bursa Akselerasi Indonesia untuk meneruskan data-data pribadi Anda pada saat Anda mendaftar di Indofund ke PT Solusi Net Internusa sebagai data pendaftaran Digisign guna memenuhi ketentuan Pasal 55 ayat (1) Peraturan Pemerintah Nomor 82 Tahun 2012 Tentang Penyelenggaraan Sistem dan Transaksi Elektronik dan Pasal 41 ayat (1) Peraturan Otoritas Jasa Keuangan Nomor 77/POJK.01/2016 tentang Layanan Pinjam Meminjam Uang Berbasis Teknologi Informasi terkait kewajiban untuk melakukan tanda tangan elektronik. Dengan ini, Anda menyatakan setuju untuk mendaftar sebagai pengguna Digisign untuk dibuatkan data pembuatan tanda tangan elektronik yang tersertifikasi oleh penyelenggara sertifikasi elektronik yang telah mendapatkan pengakuan Menteri sesuai peraturan perundang-undangan dan setuju untuk terikat pada syarat dan ketentuan layanan Digisign.',
                                style: STextStyles.medium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Text(
                        'Saya menyetujui Kebijakan Privasi & Konfirmasi Penggunaan Data dari Kenari.',
                        style: STextStyles.medium(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isAgreed,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (onChanged) {
                              if(controller.position.atEdge) {
                                if(controller.position.pixels != 0) {
                                  setState(() {
                                    enableCheckbox = true;
                                  });
                                }
                              }

                              if(enableCheckbox == true) {
                                stateSetter(() {
                                  isAgreed = !isAgreed;
                                });
                              }
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Saya telah membaca dan setuju dengan semua ketentuan diatas.',
                              style: STextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(enableCheckbox == true) {
                            if(isAgreed) {
                              BackFromThisPage(context: context, callbackData: true).go();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: enableCheckbox ? isAgreed ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04() : NeutralColorStyles.neutral04(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: Text(
                            'Setuju',
                            style: LTextStyles.medium().copyWith(
                              color: isAgreed ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    ).then((modalResult) {
      if(modalResult != null && modalResult == true) {
        result = true;
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      'Daftar Akun',
                      style: HeadingTextStyles.headingS(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/banner_register_form.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          widget.companyName ?? '(Nama perusahaan tidak terdaftar)',
                          style: HeadingTextStyles.headingS().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Material(
                                  color: PrimaryColorStyles.primaryMain(),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.check,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    Text(
                      'Silahkan lengkapi informasi dibawah ini untuk melanjutkan pendaftaran',
                      style: MTextStyles.regular(),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Nama Lengkap',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Isi Nama lengkap disini',
                        hintStyle: MTextStyles.regular(),
                        errorText: showErrorNameHint ? errorNameMessage : null,
                        errorMaxLines: 3,
                      ),
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if(showErrorNameHint == true) {
                          setState(() {
                            showErrorNameHint = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Nomor Handphone',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Isi nomor Handphone aktif',
                        hintStyle: MTextStyles.regular(),
                        errorText: showErrorPhoneHint ? errorPhoneMessage : null,
                        errorMaxLines: 3,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 13,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if(showErrorPhoneHint == true) {
                          setState(() {
                            showErrorPhoneHint = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Email',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Isi Email aktif mu disini',
                        hintStyle: MTextStyles.regular(),
                        errorText: showErrorEmailHint ? errorEmailMessage : null,
                        errorMaxLines: 3,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if(showErrorEmailHint == true) {
                          setState(() {
                            showErrorEmailHint = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Password',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Buat Password mu disini',
                        hintStyle: MTextStyles.regular(),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        errorText: showErrorPasswordHint ? errorPasswordMessage : null,
                        errorMaxLines: 3,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if(showErrorPasswordHint == true) {
                          setState(() {
                            showErrorPasswordHint = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Konfirmasi Password',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfPassword,
                      decoration: InputDecoration(
                        hintText: 'Ulangi Password',
                        hintStyle: MTextStyles.regular(),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureConfPassword = !obscureConfPassword;
                            });
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              obscureConfPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        errorText: showErrorPasswordConfHint ? errorPasswordConfMessage : null,
                        errorMaxLines: 3,
                      ),
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        if(showErrorPasswordConfHint == true) {
                          setState(() {
                            showErrorPasswordConfHint = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () => checkForm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: nameController.text != '' &&
                      phoneController.text != '' &&
                      emailController.text != '' &&
                      passwordController.text != '' &&
                      confirmPasswordController.text != '' &&
                      showErrorNameHint == false &&
                      showErrorPhoneHint == false &&
                      showErrorEmailHint == false &&
                      showErrorPasswordHint == false &&
                      showErrorPasswordConfHint == false ?
                  PrimaryColorStyles.primaryMain() :
                  NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Lanjutkan',
                    style: LTextStyles.medium().copyWith(
                      color: showErrorNameHint == false &&
                          showErrorPhoneHint == false &&
                          showErrorEmailHint == false &&
                          showErrorPasswordHint == false &&
                          showErrorPasswordConfHint == false &&
                          nameController.text != '' &&
                          phoneController.text != '' &&
                          emailController.text != '' &&
                          passwordController.text != '' &&
                          confirmPasswordController.text != '' ?
                      Colors.white : Colors.black54,
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
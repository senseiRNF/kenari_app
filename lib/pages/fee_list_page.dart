import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/temporal_fee_detail_page.dart';
import 'package:kenari_app/services/api/fee_services/api_mandatory_fee_services.dart';
import 'package:kenari_app/services/api/fee_services/api_temporal_fee_services.dart';
import 'package:kenari_app/services/api/models/mandatory_fee_model.dart';
import 'package:kenari_app/services/api/models/temporal_fee_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class FeeListPage extends StatefulWidget {
  final int mandatoryFeeAmount;
  final int temporalFeeAmount;

  const FeeListPage({
    super.key,
    required this.mandatoryFeeAmount,
    required this.temporalFeeAmount,
  });

  @override
  State<FeeListPage> createState() => _FeeListPageState();
}

class _FeeListPageState extends State<FeeListPage> {
  int selectedTab = 0;

  String? name;
  String? companyCode;
  String? phoneNumber;

  bool isActiveStatus = true;

  List<TemporalFeeData> temporalFeeList = [];
  List<MandatoryFeeData> mandatoryFeeList = [];

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

          loadActiveData();
        });
      });
    });
  }

  Future loadActiveData() async {
    if(selectedTab == 0) {
      await APIMandatoryFeeServices(context: context).callAll().then((callResult) {
        if(callResult != null) {
          setState(() {
            mandatoryFeeList = callResult.mandatoryFeeData ?? [];
          });
        }
      });
    } else {
      await APITemporalFeeServices(context: context).callAll().then((callResult) {
        if(callResult != null) {
          setState(() {
            temporalFeeList = callResult.temporalFeeData ?? [];
          });
        }
      });
    }
  }

  List<TemporalFeeData> filteredData() {
    List<TemporalFeeData> result = [];

    if(temporalFeeList.isNotEmpty) {
      for(int i = 0; i < temporalFeeList.length; i++) {
        if(temporalFeeList[i].statusPencairan == !isActiveStatus) {
          result.add(temporalFeeList[i]);
        }
      }
    }

    return result;
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
                            selectedTab == 0 ? 'Detail Iuran Wajib' : 'Daftar Iuran Saya',
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
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: PrimaryColorStyles.primaryMain(),
                      ),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                    ),
                    onTap: (index) {
                      setState(() {
                        selectedTab = index;

                        loadActiveData();
                      });
                    },
                    tabs: [
                      Tab(
                        child: Text(
                          'Iuran Wajib',
                          style: MTextStyles.medium().copyWith(
                            color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Iuran Berjangka',
                          style: MTextStyles.medium().copyWith(
                            color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            Expanded(
              child: selectedTab == 0 ?
              Column(
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
                                      name ?? '(Pengguna tidak diketahui)',
                                      style: STextStyles.medium().copyWith(
                                        color: TextColorStyles.textPrimary(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      companyCode ?? '(Nama perusahaan tidak terdaftar)',
                                      style: XSTextStyles.regular(),
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
                                      style: XSTextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Rp ${NumberFormat('#,###', 'en_id').format(widget.mandatoryFeeAmount).replaceAll(',', '.')}',
                                      style: STextStyles.medium().copyWith(
                                        color: TextColorStyles.textPrimary(),
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
                                    style: XSTextStyles.medium().copyWith(
                                      color: WarningColorStyles.warningMain(),
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
                            style: LTextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
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
                                        style: MTextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              phoneNumber ?? '(Nomor telepon tidak terdaftar)',
                                              style: STextStyles.medium().copyWith(
                                                color: TextColorStyles.textPrimary(),
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
                                    style: STextStyles.regular(),
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
                        itemCount: mandatoryFeeList.length,
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
                                  mandatoryFeeList[index].createdAt != null ? DateFormat('yyyy').format(DateTime.parse(mandatoryFeeList[index].createdAt!)) : '(Tidak diketahui) Year',
                                  style: XSTextStyles.regular(),
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
                                        style: MTextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                      Text(
                                        'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(mandatoryFeeList[index].amount != null && mandatoryFeeList[index].amount != '' ? mandatoryFeeList[index].amount! : '0')).replaceAll(',', '.')}',
                                        style: MTextStyles.medium().copyWith(
                                          color: SuccessColorStyles.successMain(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  mandatoryFeeList[index].createdAt != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(mandatoryFeeList[index].createdAt!)) : '(Tidak diketahui)',
                                  style: STextStyles.regular(),
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
                ],
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Total Saldo Iuran Berjangka',
                            style: STextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Rp ${NumberFormat('#,###', 'en_id').format(widget.temporalFeeAmount).replaceAll(',', '.')}',
                            style: LTextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: BorderColorStyles.borderStrokes(),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isActiveStatus == true ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isActiveStatus = true;
                                      });
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Center(
                                        child: Text(
                                          'Aktif',
                                          style: XSTextStyles.medium().copyWith(
                                            color: isActiveStatus == true ? TextColorStyles.textPrimary() : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isActiveStatus == false ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isActiveStatus = false;
                                      });
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Center(
                                        child: Text(
                                          'Selesai',
                                          style: XSTextStyles.medium().copyWith(
                                            color: isActiveStatus == false ? TextColorStyles.textPrimary() : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: filteredData().isNotEmpty ?
                    ListView.separated(
                      itemCount: filteredData().length,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return Container(
                          color: Colors.white,
                          child: separatorIndex < filteredData().length - 1 ?
                          Divider(
                            height: 1.0,
                            indent: 25.0,
                            endIndent: 25.0,
                            color: NeutralColorStyles.neutral05(),
                          ) :
                          const Material(),
                        );
                      },
                      itemBuilder: (BuildContext listContext, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            index == 0 ?
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                              child: Text(
                                filteredData()[index].tanggalMulai != null ? DateFormat('yyyy').format(DateTime.parse(filteredData()[index].tanggalMulai!)) : '(Tidak diketahui)',
                                style: XSTextStyles.regular(),
                              ),
                            ) :
                            const Material(),
                            Container(
                              color: Colors.white,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if(filteredData()[index].sId != null) {
                                      MoveToPage(
                                        context: context,
                                        target: TemporalFeeDetailPage(
                                          temporalFeeId: filteredData()[index].sId!,
                                        ),
                                      ).go();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Iuran Berjangka',
                                                style: MTextStyles.medium().copyWith(
                                                  color: TextColorStyles.textPrimary(),
                                                ),
                                              ),
                                              Text(
                                                filteredData()[index].jumlahIuran != null ? 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredData()[index].jumlahIuran!)).replaceAll(',', '.')}' : 'Rp 0',
                                                style: STextStyles.medium().copyWith(
                                                  color: TextColorStyles.textPrimary(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${filteredData()[index].jangkaWaktu != null ? '${filteredData()[index].jangkaWaktu} Bulan' : '(Tidak diketahui)'} (${filteredData()[index].imbalHasil != null ? '${filteredData()[index].imbalHasil}%' : '(Tidak diketahui)'})',
                                          style: STextStyles.regular(),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Tanggal Pencairan',
                                              style: STextStyles.regular(),
                                            ),
                                            Text(
                                              filteredData()[index].tanggalPencairan != null ? DateFormat('dd MMMM yyyy').format(DateTime.parse(filteredData()[index].tanggalPencairan!)) : '(Tidak diketahui)',
                                              style: STextStyles.medium(),
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
                              ),
                            ),
                          ],
                        );
                      },
                    ) :
                    Center(
                      child: Text(
                        'Tidak ditemukan data yang cocok...',
                        style: MTextStyles.medium(),
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
                child: ElevatedButton(
                  onPressed: () {
                    if(selectedTab == 1) {
                      BackFromThisPage(context: context, callbackData: true).go();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      selectedTab == 1 ? 'Tambah Iuran' : 'Tarik Saldo',
                      style: LTextStyles.medium().copyWith(
                        color: selectedTab == 1 ? Colors.white : Colors.black54,
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
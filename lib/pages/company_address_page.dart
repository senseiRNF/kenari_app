import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/models/local_company_address_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class CompanyAddressPage extends StatefulWidget {
  const CompanyAddressPage({super.key});

  @override
  State<CompanyAddressPage> createState() => _CompanyAddressPageState();
}

class _CompanyAddressPageState extends State<CompanyAddressPage> {
  List<LocalCompanyAddress> companyAddressList = [
    LocalCompanyAddress(
      companydId: 0,
      companyName: 'PT Surya Fajar Capital.tbk',
      phone: '0123456789',
      isMainAddress: true,
      address: 'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
    ),
    LocalCompanyAddress(
      companydId: 1,
      companyName: 'PT Bursa Akselerasi Indonesia',
      phone: '0123456789',
      isMainAddress: false,
      address: 'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
    ),
  ];
  
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
                      'Alamat Perusahaan',
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
              child: companyAddressList.isNotEmpty ?
              ListView.builder(
                itemCount: companyAddressList.length,
                itemBuilder: (BuildContext listContext, int index) {
                  return InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  companyAddressList[index].companyName,
                                  style: MTextStyles.medium(),
                                ),
                              ),
                              companyAddressList[index].isMainAddress ?
                              Container(
                                decoration: BoxDecoration(
                                  color: PrimaryColorStyles.primarySurface(),
                                  border: Border.all(
                                    color: PrimaryColorStyles.primaryBorder(),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                  child: Text(
                                    'Utama',
                                    style: STextStyles.medium().copyWith(
                                      color: PrimaryColorStyles.primaryMain(),
                                    ),
                                  ),
                                ),
                              ) :
                              const Material(),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            companyAddressList[index].phone,
                            style: STextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            companyAddressList[index].address,
                            style: STextStyles.regular(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) :
              Stack(),
            ),
          ],
        ),
      ),
    );
  }
}
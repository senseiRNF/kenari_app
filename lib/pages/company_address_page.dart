import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/models/company_model.dart';
import 'package:kenari_app/services/api/profile/api_company_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class CompanyAddressPage extends StatefulWidget {
  const CompanyAddressPage({super.key});

  @override
  State<CompanyAddressPage> createState() => _CompanyAddressPageState();
}

class _CompanyAddressPageState extends State<CompanyAddressPage> {
  CompanyModel? companyModel;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  Future initLoad() async {
    await LocalSharedPrefs().readKey('company_id').then((companyId) async {
      await APICompanyServices(context: context).getCompanyById(companyId).then((companyResult) {
        setState(() {
          companyModel = companyResult;
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
              child: companyModel != null && companyModel!.companyData != null && companyModel!.companyData!.addresses != null && companyModel!.companyData!.addresses!.isNotEmpty ?
              ListView.builder(
                itemCount: companyModel!.companyData!.addresses!.length,
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
                                  companyModel!.companyData!.name ?? 'Unknown Company',
                                  style: MTextStyles.medium(),
                                ),
                              ),
                              companyModel!.companyData!.status != null && companyModel!.companyData!.status! == true ?
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
                            companyModel!.companyData!.phone ?? 'Unknown Phone',
                            style: STextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            companyModel!.companyData!.addresses![index].address ?? 'Unknown Address',
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
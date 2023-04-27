import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/models/company_model.dart';
import 'package:kenari_app/services/api/profile_services/api_company_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class CompanyAddressSelectionPage extends StatefulWidget {
  const CompanyAddressSelectionPage({super.key});

  @override
  State<CompanyAddressSelectionPage> createState() => _CompanyAddressSelectionPageState();
}

class _CompanyAddressSelectionPageState extends State<CompanyAddressSelectionPage> {
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
                            'Pilih Alamat',
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
              child: companyModel != null && companyModel!.companyData != null && companyModel!.companyData!.addresses != null && companyModel!.companyData!.addresses!.isNotEmpty ?
              ListView.builder(
                itemCount: companyModel!.companyData!.addresses!.length,
                itemBuilder: (BuildContext listContext, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      color: Colors.white,
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
                                // companyModel!.companyData!.status != null && companyModel!.companyData!.status! == true ?
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: PrimaryColorStyles.primarySurface(),
                                //     border: Border.all(
                                //       color: PrimaryColorStyles.primaryBorder(),
                                //     ),
                                //     borderRadius: BorderRadius.circular(10.0),
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                //     child: Text(
                                //       'Utama',
                                //       style: STextStyles.medium().copyWith(
                                //         color: PrimaryColorStyles.primaryMain(),
                                //       ),
                                //     ),
                                //   ),
                                // ) :
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
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextButton(
                              onPressed: () {
                                BackFromThisPage(
                                  context: context,
                                  callbackData: {
                                    'company_data': companyModel!.companyData!,
                                    'selected': companyModel!.companyData!.addresses![index].address,
                                  },
                                ).go();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'Pilih',
                                  style: MTextStyles.medium(),
                                ),
                              ),
                            ),
                          ],
                        ),
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
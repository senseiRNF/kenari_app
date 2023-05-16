import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/models/variant_type_model.dart';
import 'package:kenari_app/services/api/variant_services/api_variant_type_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class VariantSelectionPage extends StatefulWidget {
  final Map? productVariant;

  const VariantSelectionPage({
    super.key,
    this.productVariant,
  });

  @override
  State<VariantSelectionPage> createState() => _VariantSelectionPageState();
}

class _VariantSelectionPageState extends State<VariantSelectionPage> {
  List<VariantTypeData> variantList = [];
  List<VariantTypeData> selectedVariant = [];
  
  List<Map> detailVariantList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    List<VariantTypeData> tempVariantList = [];

    await APIVariantTypeServices(context: context).call().then((variantResult) {
      if(variantResult != null && variantResult.variantTypeData != null) {
        tempVariantList = variantResult.variantTypeData!;
      }
    });

    setState(() {
      variantList = tempVariantList;
    });
  }

  Future<List> showVariantListBottomDialog(int variantIndex, String variantName, List subVariantList) async {
    List detailVariantListList = [];

    for(int i = 0; i < subVariantList.length; i++) {
      detailVariantListList.add(
        {
          'selected': true,
          'data': subVariantList[i],
        },
      );
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Pilih $variantName',
                      style: LTextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  detailVariantListList.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: detailVariantListList.length + 1,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return const Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: Colors.black38,
                        );
                      },
                      itemBuilder: (BuildContext subVariantContext, int subVariantIndex) {
                        return subVariantIndex == detailVariantListList.length ?
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showAddNewSubVariantBottomDialog(variantIndex, variantName).then((subVariantResult) {
                                  if(subVariantResult != null) {
                                    stateSetter(() {
                                      detailVariantListList.add(
                                        {
                                          'selected': true,
                                          'data': subVariantResult,
                                        },
                                      );
                                    });
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Tambah $variantName Lain',
                                  style: STextStyles.medium().copyWith(
                                    color: PrimaryColorStyles.primaryMain(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ) :
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                detailVariantListList[subVariantIndex]['data'],
                                style: MTextStyles.regular(),
                              ),
                            ),
                            Checkbox(
                              value: detailVariantListList[subVariantIndex]['selected'],
                              activeColor: PrimaryColorStyles.primaryMain(),
                              onChanged: (newValue) {
                                if(newValue != null) {
                                  stateSetter(() {
                                    detailVariantListList[subVariantIndex]['selected'] = newValue;
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ) :
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Belum ada daftar yang ada, silahkan untuk menambahkan daftar',
                          style: STextStyles.regular(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            showAddNewSubVariantBottomDialog(variantIndex, variantName).then((subVariantResult) {
                              if(subVariantResult != null) {
                                stateSetter(() {
                                  detailVariantListList.add(
                                    {
                                      'selected': true,
                                      'data': subVariantResult,
                                    },
                                  );
                                });
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Tambah',
                              style: STextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(context: context).go();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Simpan',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    return detailVariantListList;
  }

  Future<String?> showAddNewSubVariantBottomDialog(int variantIndex, String variantName) async {
    String? subvariant;
    TextEditingController subVariantNameController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Tambah $variantName',
                      style: LTextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Nama $variantName',
                      style: STextStyles.medium(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: subVariantNameController,
                      decoration: InputDecoration(
                        hintText: 'Masukan nama $variantName',
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(context: context, callbackData: subVariantNameController.text).go();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Simpan',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((result) {
      if(result != null) {
        subvariant = subVariantNameController.text;

        setState(() {
          // variantList[variantIndex]['subvariant'].add(
          //   subVariantNameController.text,
          // );
        });
      }
    });

    return subvariant;
  }

  Future<List> showUpdateAllSelectedVariantBottomDialog() async {
    List variantResult = [];
    List updatedVariantList = [
      {
        'variant': 'Semua',
        'selected': true,
      }
    ];

    // for(int i = 0; i < savedVariant['subvariant'].length; i++) {
    //   updatedVariantList.add({
    //     'variant': savedVariant['subvariant'][i],
    //     'selected': true,
    //   });
    // }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Pilih varian yang ingin diatur',
                      style: LTextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: updatedVariantList.length,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return Divider(
                          height: 15.0,
                          thickness: 1.0,
                          color: BorderColorStyles.borderDivider(),
                        );
                      },
                      itemBuilder: (BuildContext variantContext, int variantIndex) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                updatedVariantList[variantIndex]['variant'],
                                style: MTextStyles.regular(),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Checkbox(
                                value: updatedVariantList[variantIndex]['selected'],
                                activeColor: PrimaryColorStyles.primaryMain(),
                                onChanged: (newValue) {
                                  if(variantIndex == 0) {
                                    for(int x = 0; x < updatedVariantList.length; x++) {
                                      if(newValue != null) {
                                        stateSetter(() {
                                          updatedVariantList[x]['selected'] = newValue;
                                        });
                                      }
                                    }
                                  } else {
                                    if(newValue != null) {
                                      stateSetter(() {
                                        updatedVariantList[variantIndex]['selected'] = newValue;
                                      });

                                      bool isSelectedAll = true;

                                      for(int x = 1; x < updatedVariantList.length; x++) {
                                        if(updatedVariantList[x]['selected'] == false) {
                                          isSelectedAll = false;

                                          break;
                                        }
                                      }

                                      stateSetter(() {
                                        updatedVariantList[0]['selected'] = isSelectedAll;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(context: context, callbackData: updatedVariantList).go();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Simpan',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((result) {
      if(result != null && result.isNotEmpty) {
        variantResult = result;
      }
    });

    return variantResult;
  }

  Future<Map> showUpdateAllPriceAndStockVariantBottomDialog(List selectedVariant) async {
    Map resultVariantList = {};

    TextEditingController priceController = TextEditingController();
    TextEditingController stockController = TextEditingController();

    bool isAlwaysAvailable = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Pilih varian yang ingin diatur',
                      style: LTextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Harga',
                          style: STextStyles.medium().copyWith(
                            color: TextColorStyles.textPrimary(),
                          ),
                        ),
                        TextField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixIcon: Text("Rp "),
                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                            hintText: '0',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Stok',
                          style: STextStyles.medium().copyWith(
                            color: TextColorStyles.textPrimary(),
                          ),
                        ),
                        TextField(
                          controller: stockController,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '0',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: Checkbox(
                            value: isAlwaysAvailable,
                            activeColor: PrimaryColorStyles.primaryMain(),
                            onChanged: (newValue) {
                              if(newValue != null) {
                                stateSetter(() {
                                  isAlwaysAvailable = newValue;

                                  if(isAlwaysAvailable == true) {
                                    stockController.text = '1';
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              stateSetter(() {
                                isAlwaysAvailable = !isAlwaysAvailable;

                                if(isAlwaysAvailable == true) {
                                  stockController.text = '1';
                                }
                              });
                            },
                            child: Text(
                              'Stok selalu ada',
                              style: MTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(
                          context: context,
                          callbackData: {
                            'variant': selectedVariant,
                            'price': priceController.text,
                            'stock': stockController.text,
                            'is_always_available': isAlwaysAvailable,
                          },
                        ).go();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Simpan',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((result) {
      if(result != null) {
        resultVariantList = result;
      }
    });

    return resultVariantList;
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
                            'Varian',
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical:  15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tipe Varian',
                    style: MTextStyles.medium(),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Pilih maksimum 2 tipe varian produk',
                    style: STextStyles.regular(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  variantList.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      alignment: WrapAlignment.start,
                      children: variantList.asMap().map((variantIndex, variantData) => MapEntry(variantIndex, Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedVariant.isNotEmpty && selectedVariant[0].sId == variantData.sId ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedVariant.add(variantData);
                              });
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                variantData.name ?? 'Unknown',
                                style: selectedVariant.isNotEmpty && selectedVariant[0].sId == variantData.sId ? MTextStyles.medium() : MTextStyles.regular(),
                              ),
                            ),
                          ),
                        ),
                      ))).values.toList(),
                    ),
                  ) :
                  const Material(),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            selectedVariant.isNotEmpty ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical:  15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedVariant[0].name ?? 'Unknown',
                          style: MTextStyles.medium(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // showSubVariantListBottomDialog(selectedVariant!, variantList[selectedVariant!]['title'], variantList[selectedVariant!]['subvariant']).then((detailVariantListResult) {
                          //   if(detailVariantListResult.isNotEmpty) {
                          //     List tempdetailVariantList = [];
                          //
                          //     for(int i = 0; i < detailVariantListResult.length; i++) {
                          //       if(detailVariantListResult[i]['selected'] == true) {
                          //         tempdetailVariantList.add(detailVariantListResult[i]['data']);
                          //       }
                          //     }
                          //
                          //     setState(() {
                          //       detailVariantList = tempdetailVariantList;
                          //     });
                          //   }
                          // });
                        },
                        child: Text(
                          'Tambah',
                          style: STextStyles.medium(),
                        ),
                      )
                    ],
                  ),
                  detailVariantList.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      alignment: WrapAlignment.start,
                      children: detailVariantList.map((subVariantData) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              subVariantData['name'],
                              style: STextStyles.regular(),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  detailVariantList.removeWhere((element) => element == subVariantData);
                                });
                              },
                              customBorder: const CircleBorder(),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: NeutralColorStyles.neutral07(),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ) :
                  const Material(),
                ],
              ),
            ) :
            const Material(),
            variantList.isNotEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Apabila ada varian yang memiliki Harga & Stok sama, kamu bisa mengubahnya secara sekaligus bersamaan.',
                          style: XSTextStyles.regular(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showUpdateAllSelectedVariantBottomDialog().then((variantResult) {
                            // if(variantList.isNotEmpty) {
                            //   showUpdateAllPriceAndStockVariantBottomDialog(variantResult).then((priceAndStockResult) {
                            //     for(int i = 0; i < priceAndStockResult['variant'].length; i++) {
                            //       for(int x = 0; x < savedVariant['subvariant'].length; x++) {
                            //         if(priceAndStockResult['variant'][i]['selected'] == true && priceAndStockResult['variant'][i]['variant'] == savedVariant['subvariant'][x]) {
                            //           setState(() {
                            //             savedVariant['price'][x] = priceAndStockResult['price'];
                            //             savedVariant['price_controller'][x].text = priceAndStockResult['price'];
                            //             savedVariant['stock'][x] = priceAndStockResult['stock'];
                            //             savedVariant['stock_controller'][x].text = priceAndStockResult['stock'];
                            //             savedVariant['is_always_available'][x] = priceAndStockResult['is_always_available'];
                            //           });
                            //
                            //           break;
                            //         }
                            //       }
                            //     }
                            //   });
                            // }
                          });
                        },
                        child: Text(
                          'Ubah Sekaligus',
                          style: STextStyles.medium(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Daftar Varian',
                        style: MTextStyles.medium().copyWith(
                          color: TextColorStyles.textPrimary(),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedVariant.length,
                        separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                          return const SizedBox(
                            height: 25.0,
                          );
                        },
                        itemBuilder: (BuildContext variantContext, int variantIndex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                selectedVariant[variantIndex].name ?? 'Unknown',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textSecondary(),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Harga',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                              TextField(
                                controller: detailVariantList[variantIndex]['price_controller'],
                                decoration: const InputDecoration(
                                  isDense: true,
                                  prefixIcon: Text("Rp "),
                                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  hintText: '0',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (changedValue) {
                                  // if(changedValue != '') {
                                  //   setState(() {
                                  //     savedVariant['price'][variantIndex] = int.parse(changedValue);
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     savedVariant['price'][variantIndex] = 0;
                                  //   });
                                  // }
                                },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Stok',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                              TextField(
                                controller: detailVariantList[variantIndex][variantIndex],
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: '0',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (changedValue) {
                                  if(changedValue != '') {
                                    setState(() {
                                      detailVariantList[variantIndex]['stock'] = int.parse(changedValue);
                                    });
                                  } else {
                                    setState(() {
                                      detailVariantList[variantIndex]['stock'] = 0;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Checkbox(
                                      value: detailVariantList[variantIndex]['is_always_available'],
                                      activeColor: PrimaryColorStyles.primaryMain(),
                                      onChanged: (newValue) {
                                        if(newValue != null) {
                                          setState(() {
                                            detailVariantList[variantIndex]['is_always_available'] = newValue;

                                            if(detailVariantList[variantIndex]['is_always_available'] == true) {
                                              detailVariantList[variantIndex]['stock'] = 1;
                                              detailVariantList[variantIndex]['stock_controller'].text = '1';
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          detailVariantList[variantIndex]['is_always_available'] = !detailVariantList[variantIndex]['is_always_available'];

                                          if(detailVariantList[variantIndex]['is_always_available'] == true) {
                                            detailVariantList[variantIndex]['stock'] = 1;
                                            detailVariantList[variantIndex]['stock_controller'].text = '1';
                                          }
                                        });
                                      },
                                      child: Text(
                                        'Stok selalu ada',
                                        style: MTextStyles.medium().copyWith(
                                          color: PrimaryColorStyles.primaryMain(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ) :
            const Material(),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    // if(savedVariant.isNotEmpty) {
                    //   BackFromThisPage(context: context, callbackData: savedVariant).go();
                    // } else {
                    //   if(detailVariantList.isNotEmpty) {
                    //     Map data = {
                    //       'variant': variantList[selectedVariant!]['title'],
                    //       'subvariant': detailVariantList,
                    //     };
                    //
                    //     List price = [];
                    //     List stock = [];
                    //     List isAlwaysAvailable = [];
                    //     List priceController = [];
                    //     List stockController = [];
                    //
                    //     for(int i = 0; i < detailVariantList.length; i++) {
                    //       priceController.add(TextEditingController());
                    //       price.add(0);
                    //       stockController.add(TextEditingController());
                    //       stock.add(0);
                    //       isAlwaysAvailable.add(false);
                    //     }
                    //
                    //     data.addEntries({
                    //       MapEntry('price_controller', priceController),
                    //       MapEntry('stock_controller', stockController),
                    //       MapEntry('price', price),
                    //       MapEntry('stock', stock),
                    //       MapEntry('is_always_available', isAlwaysAvailable),
                    //     });
                    //
                    //     setState(() {
                    //       savedVariant = data;
                    //     });
                    //   }
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedVariant.isNotEmpty ? PrimaryColorStyles.primaryMain() : detailVariantList.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      selectedVariant.isNotEmpty ? 'Simpan Varian' : 'Lanjutkan',
                      style: LTextStyles.medium().copyWith(
                        color: selectedVariant.isNotEmpty ? Colors.white : detailVariantList.isNotEmpty ? LTextStyles.regular().color : Colors.black54,
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
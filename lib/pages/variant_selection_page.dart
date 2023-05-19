import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
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
  List<SelectedVariant> selectedVariantList = [];

  List<CompleteVariant> completeVariantList = [];

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

  Future<String?> showAddNewSubVariantBottomDialog(VariantTypeData data) async {
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
                      'Tambah ${data.name}',
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
                      'Nama ${data.name}',
                      style: STextStyles.medium(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: subVariantNameController,
                      decoration: InputDecoration(
                        hintText: 'Masukan nama ${data.name}',
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if(subVariantNameController.text != '') {
                          BackFromThisPage(context: context, callbackData: subVariantNameController.text).go();
                        } else {
                          OkDialog(
                            context: context,
                            message: 'Mohon untuk memasukan nama terlebih dahulu!',
                            showIcon: false,
                          ).show();
                        }
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
      subvariant = result;
    });

    return subvariant;
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
            Expanded(
              child: ListView(
                children: [
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
                                  color: selectedVariantList.isNotEmpty ?
                                  selectedVariantList.length < 2 ?
                                  selectedVariantList[0].variantType.sId == variantData.sId ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes() :
                                  selectedVariantList[0].variantType.sId == variantData.sId || selectedVariantList[1].variantType.sId == variantData.sId ? PrimaryColorStyles.primaryMain() :
                                  BorderColorStyles.borderStrokes() :
                                  BorderColorStyles.borderStrokes(),
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
                                    if(selectedVariantList.isNotEmpty) {
                                      bool found = false;
                                      int? foundIndex;

                                      for(int i = 0; i < selectedVariantList.length; i++) {
                                        if(selectedVariantList[i].variantType.sId == variantData.sId) {
                                          found = true;
                                          foundIndex = i;
                                        }
                                      }

                                      if(found == true) {
                                        setState(() {
                                          selectedVariantList.removeAt(foundIndex!);
                                        });
                                      } else {
                                        if(selectedVariantList.length < 2) {
                                          setState(() {
                                            selectedVariantList.add(
                                              SelectedVariant(
                                                variantType: variantData,
                                                subvariantList: [],
                                              ),
                                            );
                                          });
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        selectedVariantList.add(
                                          SelectedVariant(
                                            variantType: variantData,
                                            subvariantList: [],
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      variantData.name ?? 'Unknown',
                                      style: selectedVariantList.isNotEmpty && selectedVariantList[0].variantType.sId == variantData.sId ? MTextStyles.medium() : MTextStyles.regular(),
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
                  selectedVariantList.isNotEmpty ?
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical:  15.0),
                    color: Colors.white,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedVariantList.length,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return const SizedBox(
                          height: 20.0,
                        );
                      },
                      itemBuilder: (BuildContext variantContext, int variantIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  selectedVariantList[variantIndex].variantType.name ?? 'Unknown',
                                  style: LTextStyles.medium(),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showAddNewSubVariantBottomDialog(selectedVariantList[variantIndex].variantType).then((subvariantResult) {
                                      if(subvariantResult != null && subvariantResult != '') {
                                        setState(() {
                                          selectedVariantList[variantIndex].subvariantList.add(
                                            Subvariant(
                                              name: subvariantResult,
                                              isSelected: true,
                                            )
                                          );
                                        });
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Tambah Varian',
                                    style: MTextStyles.medium().copyWith(
                                      color: PrimaryColorStyles.primaryMain(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            selectedVariantList[variantIndex].subvariantList.isNotEmpty ?
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: selectedVariantList[variantIndex].subvariantList.length,
                              itemBuilder: (BuildContext subvariantContext, int subvariantIndex) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            selectedVariantList[variantIndex].subvariantList[subvariantIndex].name,
                                            style: MTextStyles.regular(),
                                          ),
                                        ),
                                        Checkbox(
                                          value: selectedVariantList[variantIndex].subvariantList[subvariantIndex].isSelected,
                                          activeColor: PrimaryColorStyles.primaryMain(),
                                          onChanged: (newValue) {
                                            if(newValue != null) {
                                              setState(() {
                                                selectedVariantList[variantIndex].subvariantList[subvariantIndex].isSelected = newValue;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 1.0,
                                      thickness: 1.0,
                                      color: Colors.black54,
                                    )
                                  ],
                                );
                              },
                            ) :
                            const Material(),
                          ],
                        );
                      },
                    ),
                  ) :
                  const Material(),
                ],
              ),
            ),
            completeVariantList.isEmpty ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(selectedVariantList.isNotEmpty) {
                      List<CompleteVariant> tempCompleteVariantList = [];
                      List tempSelectedVariantList = [];

                      for(int i = 0; i < selectedVariantList.length; i++) {
                        List tempFirstFilteredList = [];

                        for(int x = 0; x < selectedVariantList[i].subvariantList.length; x++) {
                          List<Map> tempSecondFilteredList = [];

                          if(selectedVariantList[i].subvariantList[x].isSelected == true) {
                            tempSecondFilteredList.add({
                              'variant_type': selectedVariantList[i].variantType,
                              'subvariant': selectedVariantList[i].subvariantList[x],
                            });

                            // tempCompleteVariantList.add(
                            //   CompleteVariant(
                            //     name: selectedVariantList[i].subvariantList[x].name,
                            //     priceController: TextEditingController(),
                            //     price: 0,
                            //     stockController: TextEditingController(),
                            //     stock: 0,
                            //     isAlwaysAvailable: false,
                            //   ),
                            // );
                          }

                          tempFirstFilteredList.add(
                            tempSecondFilteredList,
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedVariantList.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Simpan Varian',
                      style: LTextStyles.medium().copyWith(
                        color: selectedVariantList.isNotEmpty ? Colors.white : Colors.black54,
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

class Subvariant {
  String name;
  bool isSelected;

  Subvariant({
    required this.name,
    required this.isSelected,
  });
}

class SelectedVariant {
  VariantTypeData variantType;
  List<Subvariant> subvariantList;

  SelectedVariant({
    required this.variantType,
    required this.subvariantList,
  });
}

class CompleteVariant {
  String name;
  TextEditingController priceController;
  int price;
  TextEditingController stockController;
  int stock;
  bool isAlwaysAvailable;

  CompleteVariant({
    required this.name,
    required this.priceController,
    required this.price,
    required this.stockController,
    required this.stock,
    required this.isAlwaysAvailable,
  });
}

// class SubVariantSelectionPage extends StatefulWidget {
//   final List<VariantTypeData> variantData;
//
//   const SubVariantSelectionPage({
//     super.key,
//     required this.variantData,
//   });
//
//   @override
//   State<SubVariantSelectionPage> createState() => _SubVariantSelectionPageState();
// }
//
// class _SubVariantSelectionPageState extends State<SubVariantSelectionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//             color: Colors.white,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Apabila ada varian yang memiliki Harga & Stok sama, kamu bisa mengubahnya secara sekaligus bersamaan.',
//                     style: XSTextStyles.regular(),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     showUpdateAllSelectedVariantBottomDialog().then((variantResult) {
//                       // if(variantList.isNotEmpty) {
//                       //   showUpdateAllPriceAndStockVariantBottomDialog(variantResult).then((priceAndStockResult) {
//                       //     for(int i = 0; i < priceAndStockResult['variant'].length; i++) {
//                       //       for(int x = 0; x < savedVariant['subvariant'].length; x++) {
//                       //         if(priceAndStockResult['variant'][i]['selected'] == true && priceAndStockResult['variant'][i]['variant'] == savedVariant['subvariant'][x]) {
//                       //           setState(() {
//                       //             savedVariant['price'][x] = priceAndStockResult['price'];
//                       //             savedVariant['price_controller'][x].text = priceAndStockResult['price'];
//                       //             savedVariant['stock'][x] = priceAndStockResult['stock'];
//                       //             savedVariant['stock_controller'][x].text = priceAndStockResult['stock'];
//                       //             savedVariant['is_always_available'][x] = priceAndStockResult['is_always_available'];
//                       //           });
//                       //
//                       //           break;
//                       //         }
//                       //       }
//                       //     }
//                       //   });
//                       // }
//                     });
//                   },
//                   child: Text(
//                     'Ubah Sekaligus',
//                     style: STextStyles.medium(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 5.0,
//           ),
//           detailVariantList.isNotEmpty ?
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Daftar Varian',
//                   style: MTextStyles.medium().copyWith(
//                     color: TextColorStyles.textPrimary(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25.0,
//                 ),
//                 ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: detailVariantList.length,
//                   separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
//                     return const SizedBox(
//                       height: 25.0,
//                     );
//                   },
//                   itemBuilder: (BuildContext variantContext, int variantIndex) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Nama',
//                           style: STextStyles.medium().copyWith(
//                             color: TextColorStyles.textPrimary(),
//                           ),
//                         ),
//                         TextField(
//                           controller: detailVariantList[variantIndex]['title'],
//                           decoration: const InputDecoration(
//                             isDense: true,
//                           ),
//                           onChanged: (changedValue) {
//                             setState(() {
//                               detailVariantList[variantIndex]['title'] = TextEditingController(text: changedValue);
//                             });
//                           },
//                         ),
//                         const SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           'Harga',
//                           style: STextStyles.medium().copyWith(
//                             color: TextColorStyles.textPrimary(),
//                           ),
//                         ),
//                         TextField(
//                           controller: detailVariantList[variantIndex]['price_controller'],
//                           decoration: const InputDecoration(
//                             isDense: true,
//                             prefixIcon: Text("Rp "),
//                             prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
//                             hintText: '0',
//                           ),
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           onChanged: (changedValue) {
//                             if(changedValue != '') {
//                               setState(() {
//                                 detailVariantList[variantIndex]['price'] = int.parse(changedValue);
//                               });
//                             } else {
//                               setState(() {
//                                 detailVariantList[variantIndex]['price'] = 0;
//                               });
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           'Stok',
//                           style: STextStyles.medium().copyWith(
//                             color: TextColorStyles.textPrimary(),
//                           ),
//                         ),
//                         TextField(
//                           controller: detailVariantList[variantIndex]['stock_controller'],
//                           decoration: const InputDecoration(
//                             isDense: true,
//                             hintText: '0',
//                           ),
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           onChanged: (changedValue) {
//                             if(changedValue != '') {
//                               setState(() {
//                                 detailVariantList[variantIndex]['stock'] = int.parse(changedValue);
//                               });
//                             } else {
//                               setState(() {
//                                 detailVariantList[variantIndex]['stock'] = 0;
//                               });
//                             }
//                           },
//                         ),
//                         const SizedBox(
//                           height: 10.0,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: 20.0,
//                               height: 20.0,
//                               child: Checkbox(
//                                 value: detailVariantList[variantIndex]['is_always_available'],
//                                 activeColor: PrimaryColorStyles.primaryMain(),
//                                 onChanged: (newValue) {
//                                   if(newValue != null) {
//                                     setState(() {
//                                       detailVariantList[variantIndex]['is_always_available'] = newValue;
//
//                                       if(detailVariantList[variantIndex]['is_always_available'] == true) {
//                                         detailVariantList[variantIndex]['stock'] = 1;
//                                         detailVariantList[variantIndex]['stock_controller'].text = '1';
//                                       }
//                                     });
//                                   }
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10.0,
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     detailVariantList[variantIndex]['is_always_available'] = !detailVariantList[variantIndex]['is_always_available'];
//
//                                     if(detailVariantList[variantIndex]['is_always_available'] == true) {
//                                       detailVariantList[variantIndex]['stock'] = 1;
//                                       detailVariantList[variantIndex]['stock_controller'].text = '1';
//                                     }
//                                   });
//                                 },
//                                 child: Text(
//                                   'Stok selalu ada',
//                                   style: MTextStyles.medium().copyWith(
//                                     color: PrimaryColorStyles.primaryMain(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ) :
//           const Material(),
//         ],
//       ),
//     );
//   }
// }
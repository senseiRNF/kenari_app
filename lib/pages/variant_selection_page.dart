import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class VariantSelectionPage extends StatefulWidget {
  const VariantSelectionPage({
    super.key,
  });

  @override
  State<VariantSelectionPage> createState() => _VariantSelectionPageState();
}

class _VariantSelectionPageState extends State<VariantSelectionPage> {
  Map savedVariant = {};

  List variantList = [
    {
      'title': 'Warna',
      'subvariant': [],
    },
    {
      'title': 'Rasa',
      'subvariant': [],
    },
  ];
  List selectedSubVariant = [];

  int? selectedVariant;

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
              child: savedVariant.isNotEmpty ?
              ListView(
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
                              if(variantList.isNotEmpty) {
                                showUpdateAllPriceAndStockVariantBottomDialog(variantResult).then((priceAndStockResult) {
                                  for(int i = 0; i < priceAndStockResult['variant'].length; i++) {
                                    for(int x = 0; x < savedVariant['subvariant'].length; x++) {
                                      if(priceAndStockResult['variant'][i]['selected'] == true && priceAndStockResult['variant'][i]['variant'] == savedVariant['subvariant'][x]) {
                                        setState(() {
                                          savedVariant['price'][x] = priceAndStockResult['price'];
                                          savedVariant['price_controller'][x].text = priceAndStockResult['price'];
                                          savedVariant['stock'][x] = priceAndStockResult['stock'];
                                          savedVariant['stock_controller'][x].text = priceAndStockResult['stock'];
                                          savedVariant['is_always_available'][x] = priceAndStockResult['is_always_available'];
                                        });

                                        break;
                                      }
                                    }
                                  }
                                });
                              }
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
                          itemCount: savedVariant['subvariant'].length,
                          separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                            return const SizedBox(
                              height: 25.0,
                            );
                          },
                          itemBuilder: (BuildContext subVariantContext, int subVariantIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  savedVariant['subvariant'][subVariantIndex],
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
                                  controller: savedVariant['price_controller'][subVariantIndex],
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
                                    if(changedValue != '') {
                                      setState(() {
                                        savedVariant['price'][subVariantIndex] = int.parse(changedValue);
                                      });
                                    } else {
                                      setState(() {
                                        savedVariant['price'][subVariantIndex] = 0;
                                      });
                                    }
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
                                  controller: savedVariant['stock_controller'][subVariantIndex],
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
                                        savedVariant['stock'][subVariantIndex] = int.parse(changedValue);
                                      });
                                    } else {
                                      setState(() {
                                        savedVariant['stock'][subVariantIndex] = 0;
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
                                        value: savedVariant['is_always_available'][subVariantIndex],
                                        activeColor: PrimaryColorStyles.primaryMain(),
                                        onChanged: (newValue) {
                                          if(newValue != null) {
                                            setState(() {
                                              savedVariant['is_always_available'][subVariantIndex] = newValue;

                                              if(savedVariant['is_always_available'][subVariantIndex] == true) {
                                                savedVariant['stock'][subVariantIndex] = 1;
                                                savedVariant['stock_controller'][subVariantIndex].text = '1';
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
                                            savedVariant['is_always_available'][subVariantIndex] = !savedVariant['is_always_available'][subVariantIndex];

                                            if(savedVariant['is_always_available'][subVariantIndex] == true) {
                                              savedVariant['stock'][subVariantIndex] = 1;
                                              savedVariant['stock_controller'][subVariantIndex].text = '1';
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
              ListView(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            children: variantList.asMap().map((variantIndex, variantData) => MapEntry(variantIndex, Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedVariant == variantIndex ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
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
                                      selectedVariant = variantIndex;
                                      selectedSubVariant = [];
                                    });
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      variantList[variantIndex]['title'] ?? 'Unknown',
                                      style: selectedVariant == variantIndex ? MTextStyles.medium() : MTextStyles.regular(),
                                    ),
                                  ),
                                ),
                              ),
                            ))).values.toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  showAddNewVariantBottomDialog();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    'Buat Varian',
                                    style: MTextStyles.medium().copyWith(
                                      color: PrimaryColorStyles.primaryMain(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  selectedVariant != null ?
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
                                variantList[selectedVariant!]['title'],
                                style: MTextStyles.medium(),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showSubVariantListBottomDialog(selectedVariant!, variantList[selectedVariant!]['title'], variantList[selectedVariant!]['subvariant']).then((selectedSubVariantResult) {
                                  if(selectedSubVariantResult.isNotEmpty) {
                                    List tempSelectedSubVariant = [];

                                    for(int i = 0; i < selectedSubVariantResult.length; i++) {
                                      if(selectedSubVariantResult[i]['selected'] == true) {
                                        tempSelectedSubVariant.add(selectedSubVariantResult[i]['data']);
                                      }
                                    }

                                    setState(() {
                                      selectedSubVariant = tempSelectedSubVariant;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                'Tambah',
                                style: STextStyles.medium(),
                              ),
                            )
                          ],
                        ),
                        selectedSubVariant.isNotEmpty ?
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            children: selectedSubVariant.map((subVariantData) => Container(
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
                                    subVariantData,
                                    style: STextStyles.regular(),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedSubVariant.removeWhere((element) => element == subVariantData);
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
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(savedVariant.isNotEmpty) {
                      BackFromThisPage(context: context, callbackData: savedVariant).go();
                    } else {
                      if(selectedSubVariant.isNotEmpty) {
                        Map data = {
                          'variant': variantList[selectedVariant!]['title'],
                          'subvariant': selectedSubVariant,
                        };

                        List price = [];
                        List stock = [];
                        List isAlwaysAvailable = [];
                        List priceController = [];
                        List stockController = [];

                        for(int i = 0; i < selectedSubVariant.length; i++) {
                          priceController.add(TextEditingController());
                          price.add(0);
                          stockController.add(TextEditingController());
                          stock.add(0);
                          isAlwaysAvailable.add(false);
                        }

                        data.addEntries({
                          MapEntry('price_controller', priceController),
                          MapEntry('stock_controller', stockController),
                          MapEntry('price', price),
                          MapEntry('stock', stock),
                          MapEntry('is_always_available', isAlwaysAvailable),
                        });

                        setState(() {
                          savedVariant = data;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: savedVariant.isNotEmpty ? PrimaryColorStyles.primaryMain() : selectedSubVariant.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      savedVariant.isNotEmpty ? 'Simpan Varian' : 'Lanjutkan',
                      style: LTextStyles.medium().copyWith(
                        color: savedVariant.isNotEmpty ? Colors.white : selectedSubVariant.isNotEmpty ? LTextStyles.regular().color : Colors.black54,
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

  Future<void> showAddNewVariantBottomDialog() async {
    TextEditingController variantNameController = TextEditingController();

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
                      'Buat Varian',
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
                      'Nama Tipe Varian',
                      style: STextStyles.medium(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: variantNameController,
                      decoration: const InputDecoration(
                        hintText: 'Masukan nama tipe varian',
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(context: context, callbackData: variantNameController.text).go();
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
        setState(() {
          variantList.add(
            {
              'title': result,
              'subvariant': [

              ],
            },
          );
        });
      }
    });
  }

  Future<List> showSubVariantListBottomDialog(int variantIndex, String variantName, List subVariantList) async {
    List selectedSubvariantList = [];

    for(int i = 0; i < subVariantList.length; i++) {
      selectedSubvariantList.add(
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
                  selectedSubvariantList.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: selectedSubvariantList.length + 1,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return const Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: Colors.black38,
                        );
                      },
                      itemBuilder: (BuildContext subVariantContext, int subVariantIndex) {
                        return subVariantIndex == selectedSubvariantList.length ?
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showAddNewSubVariantBottomDialog(variantIndex, variantName).then((subVariantResult) {
                                  if(subVariantResult != null) {
                                    stateSetter(() {
                                      selectedSubvariantList.add(
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
                                selectedSubvariantList[subVariantIndex]['data'],
                                style: MTextStyles.regular(),
                              ),
                            ),
                            Checkbox(
                              value: selectedSubvariantList[subVariantIndex]['selected'],
                              activeColor: PrimaryColorStyles.primaryMain(),
                              onChanged: (newValue) {
                                if(newValue != null) {
                                  stateSetter(() {
                                    selectedSubvariantList[subVariantIndex]['selected'] = newValue;
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
                          'Belum ada daftar Berat yang ada, silahkan untuk menambahkan daftar Berat',
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
                                  selectedSubvariantList.add(
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

    return selectedSubvariantList;
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
          variantList[variantIndex]['subvariant'].add(
            subVariantNameController.text,
          );
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

    for(int i = 0; i < savedVariant['subvariant'].length; i++) {
      updatedVariantList.add({
        'variant': savedVariant['subvariant'][i],
        'selected': true,
      });
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
}
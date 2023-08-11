import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/miscellaneous/separator_formatter.dart';
import 'package:kenari_app/services/api/models/variant_type_model.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
import 'package:kenari_app/services/api/variant_services/api_variant_type_services.dart';
import 'package:kenari_app/services/local/models/local_variant_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class VariantSelectionPage extends StatefulWidget {
  final bool? isUpdate;
  final LocalTypeVariant? productVariant;

  const VariantSelectionPage({
    super.key,
    this.isUpdate,
    this.productVariant,
  });

  @override
  State<VariantSelectionPage> createState() => _VariantSelectionPageState();
}

class _VariantSelectionPageState extends State<VariantSelectionPage> {
  List<VariantTypeData> variantList = [];

  LocalTypeVariant? selectedVariant;

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

      setState(() {
        variantList = tempVariantList;
      });

      if(widget.productVariant != null) {
        List<LocalVariantData> tempVariantData = [];

        for(int i = 0; i < widget.productVariant!.variantData.length; i++) {
          tempVariantData.add(widget.productVariant!.variantData[i]);
        }

        setState(() {
          selectedVariant = LocalTypeVariant(
            typeVariantId: widget.productVariant!.typeVariantId,
            typeVariantName: widget.productVariant!.typeVariantName,
            variantData: tempVariantData,
          );
        });

        // if(widget.isUpdate != null && widget.isUpdate == true) {
        //   MoveToPage(
        //     context: context,
        //     target: SubVariantSelectionPage(localTypeVariantData: selectedVariant!),
        //     callback: (callbackResult) {
        //       if(callbackResult != null) {
        //         setState(() {
        //           selectedVariant!.variantData = callbackResult;
        //         });
        //
        //         BackFromThisPage(
        //           context: context,
        //           callbackData: selectedVariant,
        //         ).go();
        //       } else {
        //         BackFromThisPage(context: context).go();
        //       }
        //     },
        //   ).go();
        // }
      }
    });
  }

  Future<String?> showAddNewSubVariantBottomDialog(LocalTypeVariant data) async {
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
                      'Tambah ${data.typeVariantName}',
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
                      'Nama ${data.typeVariantName}',
                      style: STextStyles.medium(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: subVariantNameController,
                      decoration: InputDecoration(
                        hintText: 'Masukan nama ${data.typeVariantName}',
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
                  widget.isUpdate != null && widget.isUpdate == true ?
                  const Material() :
                  Column(
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
                              'Pilih tipe varian produk',
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
                                      color: selectedVariant != null && selectedVariant!.typeVariantId == variantData.sId ?
                                      PrimaryColorStyles.primaryMain() :
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
                                        if(selectedVariant != null && selectedVariant!.typeVariantId == variantData.sId) {
                                          setState(() {
                                            selectedVariant = null;
                                          });
                                        } else {
                                          if(variantData.sId != null && variantData.name != null) {
                                            setState(() {
                                              selectedVariant = LocalTypeVariant(
                                                typeVariantId: variantData.sId!,
                                                typeVariantName: variantData.name!,
                                                variantData: [],
                                              );
                                            });
                                          }
                                        }
                                      },
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                        child: Text(
                                          variantData.name ?? '(Tidak diketahui)',
                                          style: selectedVariant != null && selectedVariant!.typeVariantId == variantData.sId ?
                                          MTextStyles.medium() :
                                          MTextStyles.regular(),
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
                    ],
                  ),
                  selectedVariant != null ?
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical:  15.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              selectedVariant!.typeVariantName,
                              style: LTextStyles.medium(),
                            ),
                            TextButton(
                              onPressed: () => showAddNewSubVariantBottomDialog(selectedVariant!).then((subvariantResult) {
                                if(subvariantResult != null && subvariantResult != '') {
                                  setState(() {
                                    selectedVariant!.variantData.add(
                                      LocalVariantData(
                                        name: subvariantResult,
                                        price: 0,
                                        stock: 0,
                                        isAlwaysAvailable: false,
                                      ),
                                    );
                                  });
                                }
                              }),
                              child: Text(
                                'Tambah',
                                style: MTextStyles.medium().copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        selectedVariant!.variantData.isNotEmpty ?
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: selectedVariant!.variantData.asMap().map((subvariantIndex, subvariantData) => MapEntry(subvariantIndex, Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedVariant!.variantData[subvariantIndex].name,
                                    style: MTextStyles.regular(),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Material(
                                    color: Colors.white,
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      onTap: () {
                                        if(selectedVariant!.variantData[subvariantIndex].variantId != null) {
                                          OptionDialog(
                                            context: context,
                                            message: 'Hapus varian, Anda yakin?',
                                            yesFunction: () async {
                                              await APISellerProductServices(context: context).dioRemoveVariant(selectedVariant!.variantData[subvariantIndex].variantId).then((removeResult) {
                                                if(removeResult == true) {
                                                  setState(() {
                                                    selectedVariant!.variantData.removeAt(subvariantIndex);
                                                  });
                                                }
                                              });
                                            },
                                          ).show();
                                        } else {
                                          setState(() {
                                            selectedVariant!.variantData.removeAt(subvariantIndex);
                                          });
                                        }
                                      },
                                      customBorder: const CircleBorder(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.cancel,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))).values.toList(),
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
                    if(selectedVariant != null && selectedVariant!.variantData.isNotEmpty) {
                      MoveToPage(
                        context: context,
                        target: SubVariantSelectionPage(localTypeVariantData: selectedVariant!),
                        callback: (callbackResult) {
                          if(callbackResult != null) {
                            setState(() {
                              selectedVariant!.variantData = callbackResult;
                            });

                            BackFromThisPage(
                              context: context,
                              callbackData: selectedVariant,
                            ).go();
                          }
                        },
                      ).go();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedVariant != null && selectedVariant!.variantData.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Lanjutkan',
                      style: LTextStyles.medium().copyWith(
                        color: selectedVariant != null && selectedVariant!.variantData.isNotEmpty ? Colors.white : Colors.black54,
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

/// ----------------------------------------------------------------------------

class SubVariantSelectionPage extends StatefulWidget {
  final LocalTypeVariant localTypeVariantData;

  const SubVariantSelectionPage({
    super.key,
    required this.localTypeVariantData,
  });

  @override
  State<SubVariantSelectionPage> createState() => _SubVariantSelectionPageState();
}

class _SubVariantSelectionPageState extends State<SubVariantSelectionPage> {
  List<LocalSubVariantData> subvariantList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    if(widget.localTypeVariantData.variantData.isNotEmpty) {
      for(int i = 0; i < widget.localTypeVariantData.variantData.length; i++) {

        subvariantList.add(
          LocalSubVariantData(
            variantData: widget.localTypeVariantData.variantData[i],
            priceController: TextEditingController(text: widget.localTypeVariantData.variantData[i].price != 0 ? NumberFormat('#,###').format(widget.localTypeVariantData.variantData[i].price).replaceAll(',', '.') : ''),
            stockController: TextEditingController(text: widget.localTypeVariantData.variantData[i].stock != 0 ? NumberFormat('#,###').format(widget.localTypeVariantData.variantData[i].stock).replaceAll(',', '.') : ''),
          ),
        );
      }
    }
  }

  bool checkingIfUpdatedSomething() {
    bool result = true;

    for(int i = 0; i < subvariantList.length; i++) {
      if(subvariantList[i].priceController.text == '' || subvariantList[i].stockController.text == '') {
        result = false;

        break;
      }
    }

    return result;
  }

  Future<List<Map<LocalSubVariantData, bool>>?> showUpdateSelectionSubvariantBottomDialog() async {
    List<Map<LocalSubVariantData, bool>>? result;

    if(subvariantList.isNotEmpty) {
      List<Map<LocalSubVariantData, bool>> tempSubvariantList = [];

      LocalSubVariantData tempSubvariantData;

      for(int i = 0; i < subvariantList.length; i++) {
        tempSubvariantData = subvariantList[i];

        tempSubvariantList.add({tempSubvariantData: true});
      }

      bool checkingIfCheckedAll() {
        bool checked = true;

        for(int i = 0; i < tempSubvariantList.length; i++) {
          if(tempSubvariantList[i].values.first == false) {
            checked = false;

            break;
          }
        }

        return checked;
      }

      bool checkingIfUpdatedSomething() {
        bool checked = false;

        for(int i = 0; i < tempSubvariantList.length; i++) {
          if(tempSubvariantList[i].values.first == true) {
            checked = true;

            break;
          }
        }

        return checked;
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
                child: ListView(
                  shrinkWrap: true,
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
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Pilih Semua',
                              style: MTextStyles.regular(),
                            ),
                          ),
                          Checkbox(
                            value: checkingIfCheckedAll(),
                            activeColor: PrimaryColorStyles.primaryMain(),
                            onChanged: (newValue) {
                              if(newValue != null) {
                                for(int i = 0; i < tempSubvariantList.length; i++) {
                                  stateSetter(() {
                                    tempSubvariantList[i].update(tempSubvariantList[i].keys.first, (value) => newValue);
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(
                        height: 1.0,
                        thickness: 1.0,
                        color: Colors.black54,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tempSubvariantList.length,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: Colors.black54,
                          ),
                        );
                      },
                      itemBuilder: (BuildContext listContext, int listIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  tempSubvariantList[listIndex].keys.first.variantData.name,
                                  style: MTextStyles.regular(),
                                ),
                              ),
                              Checkbox(
                                value: tempSubvariantList[listIndex].values.first,
                                activeColor: PrimaryColorStyles.primaryMain(),
                                onChanged: (newValue) {
                                  if(newValue != null) {
                                    stateSetter(() {
                                      tempSubvariantList[listIndex].update(tempSubvariantList[listIndex].keys.first, (value) => newValue);
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(checkingIfUpdatedSomething() == true) {
                            BackFromThisPage(
                              context: context,
                              callbackData: tempSubvariantList,
                            ).go();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: checkingIfUpdatedSomething() != false ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Pilih',
                            style: LTextStyles.medium().copyWith(
                              color: checkingIfUpdatedSomething() != false ? Colors.white : Colors.black54,
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
      ).then((dialogResult) {
        if(dialogResult != null) {
          result = dialogResult;
        }
      });
    }

    return result;
  }

  Future<List<Map<LocalSubVariantData, bool>>?> showUpdatePriceStockSubvariantBottomDialog(List<Map<LocalSubVariantData, bool>> selectedSubvariantList) async {
    List<Map<LocalSubVariantData, bool>> result = [];

    if(selectedSubvariantList.isNotEmpty) {
      List<Map<LocalSubVariantData, bool>> tempSubvariantList = selectedSubvariantList;

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
                child: SizedBox(
                  height: MediaQuery.of(modalContext).size.height / 2,
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
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const SizedBox(
                              height: 15.0,
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
                                      ThousandsSeparatorInputFormatter(),
                                    ],
                                    onChanged: (_) {
                                      stateSetter(() {});
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
                                    controller: stockController,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      hintText: '0',
                                    ),
                                    enabled: isAlwaysAvailable == true ? false : true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      ThousandsSeparatorInputFormatter(),
                                    ],
                                    onChanged: (_) {
                                      stateSetter(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if(priceController.text != '' && stockController.text != '') {
                              for(int i = 0; i < tempSubvariantList.length; i++) {
                                if(tempSubvariantList[i].values.first == true) {
                                  tempSubvariantList[i].keys.first.priceController.text = priceController.text;
                                  tempSubvariantList[i].keys.first.stockController.text = stockController.text;
                                  tempSubvariantList[i].keys.first.variantData.price = int.parse(priceController.text.replaceAll('.', ''));
                                  tempSubvariantList[i].keys.first.variantData.stock = int.parse(stockController.text.replaceAll('.', ''));
                                  tempSubvariantList[i].keys.first.variantData.isAlwaysAvailable = isAlwaysAvailable;
                                }
                              }

                              BackFromThisPage(
                                context: context,
                                callbackData: tempSubvariantList,
                              ).go();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: priceController.text != '' && stockController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Simpan',
                              style: LTextStyles.medium().copyWith(
                                color: priceController.text != '' && stockController.text != '' ? Colors.white : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).then((dialogResult) {
        if(dialogResult != null) {
          result = dialogResult;
        }
      });
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
                          onPressed: () async {
                            await showUpdateSelectionSubvariantBottomDialog().then((selectedVariant) async {
                              if(selectedVariant != null) {
                                await showUpdatePriceStockSubvariantBottomDialog(selectedVariant).then((priceAndStock) {
                                  if(priceAndStock != null) {
                                    List<LocalSubVariantData> tempSubvariantList = [];
                                    List<Map<LocalSubVariantData, bool>> tempResultList = priceAndStock;

                                    for(int i = 0; i < tempResultList.length; i++) {
                                      if(tempResultList[i].values.first == true) {
                                        tempSubvariantList.add(tempResultList[i].keys.first);
                                      } else {
                                        tempSubvariantList.add(subvariantList[i]);
                                      }
                                    }

                                    setState(() {
                                      subvariantList = tempSubvariantList;
                                    });
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
                          itemCount: subvariantList.length,
                          separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                            return const SizedBox(
                              height: 25.0,
                            );
                          },
                          itemBuilder: (BuildContext subvariantContext, int subvariantIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  subvariantList[subvariantIndex].variantData.name,
                                  style: MTextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
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
                                  controller: subvariantList[subvariantIndex].priceController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    prefixIcon: Text("Rp "),
                                    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                    hintText: '10.000',
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                  onChanged: (changedValue) {
                                    if(changedValue != '') {
                                      setState(() {
                                        subvariantList[subvariantIndex].variantData.price = int.parse(changedValue.replaceAll('.', ''));
                                      });
                                    } else {
                                      setState(() {
                                        subvariantList[subvariantIndex].variantData.price = 0;
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
                                  controller: subvariantList[subvariantIndex].stockController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    hintText: '0',
                                  ),
                                  enabled: subvariantList[subvariantIndex].variantData.isAlwaysAvailable == true ? false : true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                  onChanged: (changedValue) {
                                    if(changedValue != '') {
                                      setState(() {
                                        subvariantList[subvariantIndex].variantData.stock = int.parse(changedValue.replaceAll('.', ''));
                                      });
                                    } else {
                                      setState(() {
                                        subvariantList[subvariantIndex].variantData.stock = 0;
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
                                        value: subvariantList[subvariantIndex].variantData.isAlwaysAvailable,
                                        activeColor: PrimaryColorStyles.primaryMain(),
                                        onChanged: (newValue) {
                                          if(newValue != null) {
                                            setState(() {
                                              subvariantList[subvariantIndex].variantData.isAlwaysAvailable = newValue;

                                              if(subvariantList[subvariantIndex].variantData.isAlwaysAvailable == true) {
                                                subvariantList[subvariantIndex].variantData.stock = 1;
                                                subvariantList[subvariantIndex].stockController.text = '1';
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
                                            subvariantList[subvariantIndex].variantData.isAlwaysAvailable = !subvariantList[subvariantIndex].variantData.isAlwaysAvailable;

                                            if(subvariantList[subvariantIndex].variantData.isAlwaysAvailable == true) {
                                              subvariantList[subvariantIndex].variantData.stock = 1;
                                              subvariantList[subvariantIndex].stockController.text = '1';
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
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(checkingIfUpdatedSomething() != false) {
                      List<LocalVariantData> callbackDataList = [];

                      for(int i = 0; i < subvariantList.length; i++) {
                        callbackDataList.add(subvariantList[i].variantData);
                      }

                      BackFromThisPage(
                        context: context,
                        callbackData: callbackDataList,
                      ).go();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: checkingIfUpdatedSomething() != false ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Simpan Varian',
                      style: LTextStyles.medium().copyWith(
                        color: checkingIfUpdatedSomething() != false ? Colors.white : Colors.black54,
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
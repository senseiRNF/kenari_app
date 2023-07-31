import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/miscellaneous/separator_formatter.dart';
import 'package:kenari_app/services/api/models/variant_type_model.dart';
import 'package:kenari_app/services/api/variant_services/api_variant_type_services.dart';
import 'package:kenari_app/services/local/models/local_variant_data.dart';
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
  SelectedVariant? selectedVariantList;

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

    // if(widget.productVariant != null && widget.productVariant!.isNotEmpty) {
    //   List<SelectedVariant> tempSelectedVariantList = [];
    //
    //   for(int i = 0; i < widget.productVariant!['variant_type_data'].length; i++) {
    //     tempSelectedVariantList.add(widget.productVariant!['variant_type_data'][i]);
    //   }
    //
    //   setState(() {
    //     selectedVariantList = tempSelectedVariantList;
    //   });
    // }
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
                        // Text(
                        //   'Pilih maksimum 2 tipe varian produk',
                        //   style: STextStyles.regular(),
                        // ),
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
                                  color: selectedVariantList != null && selectedVariantList!.variantType.sId == variantData.sId ?
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
                                    if(selectedVariantList != null && selectedVariantList!.variantType.sId == variantData.sId) {
                                      setState(() {
                                        selectedVariantList = null;
                                      });
                                    } else {
                                      setState(() {
                                        selectedVariantList = SelectedVariant(
                                          variantType: variantData,
                                          subvariantList: [],
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
                                      style: selectedVariantList != null && selectedVariantList!.variantType.sId == variantData.sId ?
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
                  selectedVariantList != null ?
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
                              selectedVariantList!.variantType.name ?? 'Unknown',
                              style: LTextStyles.medium(),
                            ),
                            TextButton(
                              onPressed: () {
                                showAddNewSubVariantBottomDialog(selectedVariantList!.variantType).then((subvariantResult) {
                                  if(subvariantResult != null && subvariantResult != '') {
                                    setState(() {
                                      selectedVariantList!.subvariantList.add(
                                        Subvariant(
                                          name: subvariantResult,
                                          isSelected: true,
                                        ),
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
                        selectedVariantList!.subvariantList.isNotEmpty ?
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: selectedVariantList!.subvariantList.length,
                          itemBuilder: (BuildContext subvariantContext, int subvariantIndex) {
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedVariantList!.subvariantList[subvariantIndex].name,
                                        style: MTextStyles.regular(),
                                      ),
                                    ),
                                    Checkbox(
                                      value: selectedVariantList!.subvariantList[subvariantIndex].isSelected,
                                      activeColor: PrimaryColorStyles.primaryMain(),
                                      onChanged: (newValue) {
                                        if(newValue != null) {
                                          setState(() {
                                            selectedVariantList!.subvariantList[subvariantIndex].isSelected = newValue;
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
                    List tempListSubvariant = [];

                    for(int i = 0; i < selectedVariantList!.subvariantList.length; i++) {
                      if(selectedVariantList!.subvariantList[i].isSelected == true) {
                        tempListSubvariant.add({
                          'variant_type1_id': selectedVariantList!.variantType.sId,
                          'name1': selectedVariantList!.subvariantList[i].name,
                          'variant_type2_id': '',
                          'name2': '',
                        });
                      }
                    }

                    MoveToPage(
                      context: context,
                      target: SubVariantSelectionPage(
                        variantData: {
                          'variant_type_data': selectedVariantList,
                          'generated_data': tempListSubvariant,
                        },
                      ),
                      callback: (callbackResult) {
                        if(callbackResult != null) {
                          BackFromThisPage(
                            context: context,
                            callbackData: {
                              'variant_type_data': selectedVariantList,
                              'generated_data': tempListSubvariant,
                              'inputted_data': callbackResult,
                            },
                          ).go();
                        }
                      },
                    ).go();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedVariantList != null ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Lanjutkan',
                      style: LTextStyles.medium().copyWith(
                        color: selectedVariantList != null ? Colors.white : Colors.black54,
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

class SubVariantSelectionPage extends StatefulWidget {
  final Map variantData;

  const SubVariantSelectionPage({
    super.key,
    required this.variantData,
  });

  @override
  State<SubVariantSelectionPage> createState() => _SubVariantSelectionPageState();
}

class _SubVariantSelectionPageState extends State<SubVariantSelectionPage> {
  List subvariantList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    if(widget.variantData['generated_data'] != null) {
      for(int i = 0; i < widget.variantData['generated_data'].length; i++) {
        subvariantList.add({
          'title': "${widget.variantData['generated_data'][i]['name1']}${widget.variantData['generated_data'][i]['name2'] != '' ? ' - ${widget.variantData['generated_data'][i]['name2']}' : ''}",
          'price': 0,
          'price_controller': TextEditingController(),
          'stock': 0,
          'stock_controller': TextEditingController(),
          'is_always_available': false,
        });
      }
    }
  }

  bool checkingIfUpdatedSomething() {
    bool result = true;

    for(int i = 0; i < subvariantList.length; i++) {
      if(subvariantList[i]['price_controller'].text == '' || subvariantList[i]['stock_controller'].text == '') {
        result = false;

        break;
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
                          onPressed: () {
                            MoveToPage(
                              context: context,
                              target: UpdateAllVariantPage(data: subvariantList),
                              callback: (callbackResult) {
                                if(callbackResult != null) {
                                  for(int i = 0; i < subvariantList.length; i++) {
                                    if(callbackResult['updated_data'][i]['is_updated'] == true) {
                                      setState(() {
                                        subvariantList[i]['price'] = int.parse(callbackResult['updated_price']);
                                        subvariantList[i]['price_controller'].text = callbackResult['updated_price'];
                                        subvariantList[i]['stock'] = int.parse(callbackResult['updated_stock']);
                                        subvariantList[i]['stock_controller'].text = callbackResult['updated_stock'];
                                        subvariantList[i]['is_always_available'] = callbackResult['updated_availability'];
                                      });
                                    }
                                  }
                                }
                              },
                            ).go();
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
                                  '${subvariantList[subvariantIndex]['title']}',
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
                                  controller: subvariantList[subvariantIndex]['price_controller'],
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
                                        subvariantList[subvariantIndex]['price'] = int.parse(changedValue.replaceAll('.', ''));
                                      });
                                    } else {
                                      setState(() {
                                        subvariantList[subvariantIndex]['price'] = 0;
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
                                  controller: subvariantList[subvariantIndex]['stock_controller'],
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    hintText: '0',
                                  ),
                                  enabled: subvariantList[subvariantIndex]['is_always_available'] == true ? false : true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                  onChanged: (changedValue) {
                                    if(changedValue != '') {
                                      setState(() {
                                        subvariantList[subvariantIndex]['stock'] = int.parse(changedValue.replaceAll('.', ''));
                                      });
                                    } else {
                                      setState(() {
                                        subvariantList[subvariantIndex]['stock'] = 0;
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
                                        value: subvariantList[subvariantIndex]['is_always_available'],
                                        activeColor: PrimaryColorStyles.primaryMain(),
                                        onChanged: (newValue) {
                                          if(newValue != null) {
                                            setState(() {
                                              subvariantList[subvariantIndex]['is_always_available'] = newValue;

                                              if(subvariantList[subvariantIndex]['is_always_available'] == true) {
                                                subvariantList[subvariantIndex]['stock'] = 1;
                                                subvariantList[subvariantIndex]['stock_controller'].text = '1';
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
                                            subvariantList[subvariantIndex]['is_always_available'] = !subvariantList[subvariantIndex]['is_always_available'];

                                            if(subvariantList[subvariantIndex]['is_always_available'] == true) {
                                              subvariantList[subvariantIndex]['stock'] = 1;
                                              subvariantList[subvariantIndex]['stock_controller'].text = '1';
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
                      BackFromThisPage(
                        context: context,
                        callbackData: subvariantList,
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

class UpdateAllVariantPage extends StatefulWidget {
  final List data;

  const UpdateAllVariantPage({
    super.key,
    required this.data,
  });

  @override
  State<UpdateAllVariantPage> createState() => _UpdateAllVariantPageState();
}

class _UpdateAllVariantPageState extends State<UpdateAllVariantPage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  bool isAlwaysAvailable = false;
  bool isCheckedAll = false;

  List subvariantList = [];
  List updatedData = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      subvariantList = widget.data;
    });

    for(int i = 0; i < subvariantList.length; i++) {
      updatedData.add({
        'is_updated': false,
        'data': subvariantList[i],
      });
    }
  }

  bool checkingIfCheckedAll() {
    bool result = true;

    for(int i = 0; i < updatedData.length; i++) {
      if(updatedData[i]['is_updated'] == false) {
        result = false;

        break;
      }
    }

    return result;
  }

  bool checkingIfUpdatedSomething() {
    bool result = false;

    for(int i = 0; i < updatedData.length; i++) {
      if(updatedData[i]['is_updated'] == true) {
        result = true;

        break;
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Pilih varian yang ingin diatur',
                      style: LTextStyles.medium(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: checkingIfCheckedAll(),
                          activeColor: PrimaryColorStyles.primaryMain(),
                          onChanged: (newValue) {
                            for(int i = 0; i < updatedData.length; i++) {
                              setState(() {
                                updatedData[i]['is_updated'] = newValue;
                              });
                            }
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Pilih Semua',
                            style: MTextStyles.regular(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(
                      height: 1.0,
                      color: BorderColorStyles.borderDivider(),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: updatedData.length,
                    itemBuilder: (BuildContext subvariantListContext, int subvariantIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: updatedData[subvariantIndex]['is_updated'],
                              activeColor: PrimaryColorStyles.primaryMain(),
                              onChanged: (newValue) {
                                setState(() {
                                  updatedData[subvariantIndex]['is_updated'] = newValue;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                updatedData[subvariantIndex]['data']['title'],
                                style: MTextStyles.regular(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                          ],
                          onChanged: (_) {
                            setState(() {});
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
                          ],
                          onChanged: (_) {
                            setState(() {});
                          },
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
                                setState(() {
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
                              setState(() {
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
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(checkingIfUpdatedSomething() != false && priceController.text != '' && stockController.text != '') {
                      BackFromThisPage(
                        context: context,
                        callbackData: {
                          'updated_data': updatedData,
                          'updated_price': priceController.text,
                          'updated_stock': stockController.text,
                          'updated_availability': isAlwaysAvailable,
                        },
                      ).go();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: checkingIfUpdatedSomething() != false && priceController.text != '' && stockController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Simpan',
                      style: LTextStyles.medium().copyWith(
                        color: checkingIfUpdatedSomething() != false && priceController.text != '' && stockController.text != '' ? Colors.white : Colors.black54,
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
import 'package:flutter/material.dart';
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
  List<Map> variantList = [
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
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50.0,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: variantList.length,
                                  separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                                    return const SizedBox(
                                      width: 10.0,
                                    );
                                  },
                                  itemBuilder: (BuildContext variantContext, int variantIndex) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: selectedVariant == variantIndex ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                        ),
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
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              variantList[variantIndex]['title'] ?? 'Unknown',
                                              style: selectedVariant == variantIndex ? MTextStyles.medium() : MTextStyles.regular(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
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

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: variantList.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Simpan Varian',
                      style: LTextStyles.medium().copyWith(
                        color: variantList.isNotEmpty ? LTextStyles.regular().color : Colors.black54,
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
                            )
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
}
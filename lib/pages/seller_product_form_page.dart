import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/company_address_selection_page.dart';
import 'package:kenari_app/pages/seller_product_result_page.dart';
import 'package:kenari_app/pages/variant_selection_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductFormPage extends StatefulWidget {
  final Map? updateData;

  const SellerProductFormPage({
    super.key,
    this.updateData,
  });

  @override
  State<SellerProductFormPage> createState() => _SellerProductFormPageState();
}

class _SellerProductFormPageState extends State<SellerProductFormPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  TextEditingController preOrderDurationController = TextEditingController(text: '1');

  List productImg = [];
  List durationList = [
    'Hari',
    'Minggu',
  ];

  bool isUnlimitedStock = false;
  bool isPreOrder = false;

  String? category;
  String durationSelected = 'Hari';

  Map variant = {};
  Map companyData = {};

  @override
  void initState() {
    super.initState();

    if(widget.updateData != null && widget.updateData!.isNotEmpty) {
      setState(() {
        productNameController.text = widget.updateData!['title'];
        productDescriptionController.text = widget.updateData!['description'];

        List priceTempList = widget.updateData!['price'];

        priceTempList.sort();

        int minPrice = priceTempList[0];
        int maxPrice = priceTempList[priceTempList.length - 1];

        productPriceController.text = 'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}';
      });
    }
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
                            widget.updateData != null ? 'Ubah Detail' : 'Titip Produk',
                            style: Theme.of(context).textTheme.headlineSmall,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
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
                                  'Silahkan mengisi informasi dibawah ini untuk menitip jualkan barang.',
                                  style: TextThemeXS.medium().copyWith(
                                    color: WarningColorStyles.warningMain(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Gallery Produk',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            crossAxisCount: 4,
                          ),
                          itemCount: productImg.length + 1,
                          itemBuilder: (BuildContext imgContext, int index) {
                            return Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: PrimaryColorStyles.primarySurface(),
                                border: Border.all(
                                  color: PrimaryColorStyles.primaryBorder(),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if(index == 0) {
                                      setState(() {
                                        productImg.add(null);
                                      });
                                    }
                                  },
                                  onLongPress: () {
                                    if(index != 0) {
                                      setState(() {
                                        productImg.removeAt(index - 1);
                                      });
                                    }
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Icon(
                                        index == 0 ? Icons.add : Icons.image,
                                        color: PrimaryColorStyles.primaryMain(),
                                        size: 25.0,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        index == 0 ? 'Tambah\nFoto/Video' : 'Dummy Image',
                                        style: TextThemeXS.regular().copyWith(
                                          color: PrimaryColorStyles.primaryMain(),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
                          'Nama Produk',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        TextField(
                          controller: productNameController,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama produk',
                          ),
                          maxLength: 25,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Deskripsi Produk',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        TextField(
                          controller: productDescriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan deskripsi produk',
                          ),
                          maxLines: null,
                          maxLength: 300,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Kategori',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      category ?? 'Pilih Kategori',
                                      style: Theme.of(context).textTheme.bodyMedium!,
                                    ),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    color: PrimaryColorStyles.primaryMain(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Harga Produk',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        TextField(
                          controller: productPriceController,
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixIcon: Text("Rp "),
                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                            hintText: '10.000',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Stok Produk',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        TextField(
                          controller: productStockController,
                          decoration: const InputDecoration(
                            hintText: '1',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                                value: isUnlimitedStock,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (newValue) {
                                  if(newValue != null) {
                                    setState(() {
                                      isUnlimitedStock = newValue;
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
                                    isUnlimitedStock = !isUnlimitedStock;
                                  });
                                },
                                child: Text(
                                  'Stok selalu ada',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontBodyWeight.medium(),
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
                    height: 5.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Aktifkan PreOrder',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ),
                            Switch(
                              value: isPreOrder,
                              activeTrackColor: PrimaryColorStyles.primaryMain(),
                              onChanged: (newValue) {
                                setState(() {
                                  isPreOrder = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        isPreOrder == true ?
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Durasi',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontBodyWeight.medium(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60.0,
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                durationSelected,
                                                style: Theme.of(context).textTheme.bodyMedium!,
                                              ),
                                            ),
                                            Icon(
                                              Icons.expand_more,
                                              color: IconColorStyles.iconColor(),
                                            ),
                                          ],
                                        ),
                                        DropdownButton(
                                          onChanged: (newValue) {
                                            if(newValue != null) {
                                              setState(() {
                                                durationSelected = newValue;
                                              });
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.expand_more,
                                            color: Colors.transparent,
                                          ),
                                          underline: const Material(),
                                          items: durationList.map<DropdownMenuItem<String>>((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                                child: Text(
                                                  value,
                                                  style: Theme.of(context).textTheme.bodySmall!,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1.0,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Jumlah',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontBodyWeight.medium(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60.0,
                                    child: TextField(
                                      controller: preOrderDurationController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Masukkan jumlah durasi',
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ) :
                        Text(
                          'Aktifkan PreOrder jika kamu butuh waktu menyediakan stok lebih lama.',
                          style: Theme.of(context).textTheme.bodySmall!,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Varian Produk',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MoveToPage(
                                  context: context,
                                  target: const VariantSelectionPage(),
                                  callback: (callbackData) {
                                    if(callbackData != null) {
                                      setState(() {
                                        variant = callbackData;
                                      });
                                    }
                                  },
                                ).go();
                              },
                              child: Text(
                                'Tambah Varian',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        variant.isNotEmpty ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${variant['variant']} (${variant['subvariant'].length} Varian)',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontBodyWeight.medium(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Tambahkan varian warna, ukuran, atau tipe lainnya agar pembeli mudah memilih.',
                              style: Theme.of(context).textTheme.bodySmall!,
                            ),
                          ],
                        ) :
                        Text(
                          'Tambahkan varian warna, ukuran, atau tipe lainnya agar pembeli mudah memilih.',
                          style: Theme.of(context).textTheme.bodySmall!,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Alamat Pengambilan',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MoveToPage(
                                  context: context,
                                  target: const CompanyAddressSelectionPage(),
                                  callback: (callbackData) {
                                    if(callbackData != null) {
                                      setState(() {
                                        companyData = callbackData;
                                      });
                                    }
                                  },
                                ).go();
                              },
                              child: Text(
                                'Pilih Alamat',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        companyData.isNotEmpty ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              companyData['company_data'].name ?? 'Unknown Company',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontBodyWeight.medium(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              companyData['company_data'].phone ?? 'Unknown Phone',
                              style: Theme.of(context).textTheme.bodySmall!,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              companyData['selected'] ?? 'Unknown Address',
                              style: Theme.of(context).textTheme.bodySmall!,
                            ),
                          ],
                        ) :
                        Text(
                          'Pilih Alamat Pengambilan dimana pembeli akan mengambil pesanannya.',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
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
                    if(widget.updateData == null) {
                      OptionDialog(
                        context: context,
                        title: 'Titip Produk',
                        message: 'Pastikan semua detail Produk yang akan di submit sudah sesuai',
                        yesText: 'Lanjutkan',
                        yesFunction: () {
                          MoveToPage(
                            context: context,
                            target: const SellerProductResultPage(isSuccess: true),
                            callback: (callbackData) {
                              if(callbackData != null) {
                                BackFromThisPage(context: context, callbackData: callbackData).go();
                              }
                            },
                          ).go();
                        },
                        noText: 'Batal',
                        noFunction: () {

                        },
                      ).show();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: productNameController.text != '' && productPriceController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      widget.updateData != null ? 'Simpan Perubahan' : 'Ajukan Penitipan',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: productNameController.text != '' && productPriceController.text != '' ? Theme.of(context).textTheme.bodyLarge!.color : Colors.black54,
                        fontWeight: FontBodyWeight.medium(),
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
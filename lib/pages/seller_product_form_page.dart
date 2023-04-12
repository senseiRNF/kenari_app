import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/variant_selection_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductFormPage extends StatefulWidget {
  const SellerProductFormPage({super.key});

  @override
  State<SellerProductFormPage> createState() => _SellerProductFormPageState();
}

class _SellerProductFormPageState extends State<SellerProductFormPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productStockController = TextEditingController();

  List productImg = [];

  bool isUnlimitedStock = false;
  bool isPreOrder = false;

  String? category;

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
                            'Titip Produk',
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
                                  style: XSTextStyles.medium().copyWith(
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
                          style: MTextStyles.medium(),
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
                                        style: XSTextStyles.regular().copyWith(
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
                          style: STextStyles.medium(),
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
                          style: STextStyles.medium(),
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
                          style: STextStyles.medium(),
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
                                      style: MTextStyles.regular(),
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
                          style: STextStyles.medium(),
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
                          style: STextStyles.medium(),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
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
                            Text(
                              'Stok selalu ada',
                              style: MTextStyles.medium(),
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
                                style: MTextStyles.medium(),
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
                        Text(
                          'Aktifkan PreOrder jika kamu butuh waktu menyediakan stok lebih lama.',
                          style: STextStyles.regular(),
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
                                style: MTextStyles.medium(),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MoveToPage(context: context, target: const VariantSelectionPage()).go();
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
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Tambahkan varian warna, ukuran, atau tipe lainnya agar pembeli mudah memilih.',
                          style: STextStyles.regular(),
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
                                style: MTextStyles.medium(),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Pilih Alamat',
                                style: MTextStyles.medium().copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Pilih Alamat Pengambilan dimana pembeli akan mengambil pesanannya.',
                          style: STextStyles.regular(),
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

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: productNameController.text != '' && productPriceController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Ajukan Penitipan',
                      style: LTextStyles.medium().copyWith(
                        color: productNameController.text != '' && productPriceController.text != '' ? LTextStyles.regular().color : Colors.black54,
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
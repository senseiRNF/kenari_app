import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/miscellaneous/separator_formatter.dart';
import 'package:kenari_app/pages/company_address_selection_page.dart';
import 'package:kenari_app/pages/seller_product_result_page.dart';
import 'package:kenari_app/pages/variant_selection_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/models/company_model.dart';
import 'package:kenari_app/services/api/models/seller_product_detail_model.dart';
import 'package:kenari_app/services/api/product_services/api_category_services.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
import 'package:kenari_app/services/local/models/local_seller_product_data.dart';
import 'package:kenari_app/services/local/models/local_variant_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductFormPage extends StatefulWidget {
  final String? productId;

  const SellerProductFormPage({
    super.key,
    this.productId,
  });

  @override
  State<SellerProductFormPage> createState() => _SellerProductFormPageState();
}

class _SellerProductFormPageState extends State<SellerProductFormPage> {
  SellerProductDetailData? sellerProductDetailData;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  TextEditingController preOrderDurationController = TextEditingController(text: '1');

  List<CategoryData> categoryList = [];
  List<MediaProductData> productImg = [];
  List durationList = [
    'Hari',
    'Minggu',
  ];

  bool isAlwaysAvailable = false;
  bool isPreOrder = false;

  String? categoryId;
  String durationSelected = 'Hari';

  LocalTypeVariant? variant;
  Map companyData = {};

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APICategoryServices(context: context).call().then((categoryResult) async {
      if(categoryResult != null && categoryResult.categoryData != null) {
        setState(() {
          categoryList = categoryResult.categoryData!;
        });
      }

      if(widget.productId != null) {
        SellerProductDetailData? tempSellerProductDetailData;

        await APISellerProductServices(context: context).callById(widget.productId!).then((callResult) {
          if(callResult != null && callResult.sellerProductDetailData != null) {
            tempSellerProductDetailData = callResult.sellerProductDetailData;
          }

          setState(() {
            sellerProductDetailData = tempSellerProductDetailData;
          });
        });

        if(sellerProductDetailData != null) {
          setState(() {
            productNameController.text = sellerProductDetailData!.name ?? '';
            productDescriptionController.text = sellerProductDetailData!.description ?? '';
            productPriceController.text = NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDetailData!.price ?? '0')).replaceAll(',', '.');
            productStockController.text = NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDetailData!.stock ?? '0')).replaceAll(',', '.');

            if(sellerProductDetailData!.productCategory != null) {
              categoryId = sellerProductDetailData!.productCategory!.sId;
              productCategoryController.text = sellerProductDetailData!.productCategory!.name ?? '';
            }

            isAlwaysAvailable = sellerProductDetailData!.isStockAlwaysAvailable ?? false;
            isPreOrder = sellerProductDetailData!.isPreOrder ?? false;

            if(sellerProductDetailData!.images != null) {
              List<MediaProductData> tempProductImg = [];

              for(int i = 0; i < sellerProductDetailData!.images!.length; i++) {
                if(sellerProductDetailData!.images![i].url != null) {
                  tempProductImg.add(
                    MediaProductData(
                      url: sellerProductDetailData!.images![i].url!,
                      sId: sellerProductDetailData!.images![i].sId,
                    ),
                  );
                }
              }

              setState(() {
                productImg = tempProductImg;
              });
            }

            if(sellerProductDetailData!.varians != null) {
              List<LocalVariantData> tempVariantData = [];
              LocalTypeVariant? tempTypeVariant;

              for(int x = 0; x < sellerProductDetailData!.varians!.length; x++) {
                if(sellerProductDetailData!.varians![x].sId != null && sellerProductDetailData!.varians![x].name1 != null) {
                  tempVariantData.add(
                    LocalVariantData(
                      variantId: sellerProductDetailData!.varians![x].sId,
                      name: sellerProductDetailData!.varians![x].name1!,
                      price: int.parse(sellerProductDetailData!.varians![x].price ?? '0'),
                      stock: int.parse(sellerProductDetailData!.varians![x].stock ?? '0'),
                      isAlwaysAvailable: sellerProductDetailData!.varians![x].isStockAlwaysAvailable!,
                    ),
                  );
                }

                if(sellerProductDetailData!.varians![x].varianType1 != null && sellerProductDetailData!.varians![x].varianType1!.sId != null && sellerProductDetailData!.varians![x].varianType1!.name != null) {
                  tempTypeVariant = LocalTypeVariant(
                    typeVariantId: sellerProductDetailData!.varians![x].varianType1!.sId!,
                    typeVariantName: sellerProductDetailData!.varians![x].varianType1!.name!,
                    variantData: tempVariantData,
                  );
                }
              }

              variant = tempTypeVariant;
            }

            if(sellerProductDetailData!.address != null && sellerProductDetailData!.company != null) {
              companyData = {
                'company_data': CompanyData(
                  sId: sellerProductDetailData!.company!.sId,
                  name: sellerProductDetailData!.company!.name,
                  code: sellerProductDetailData!.company!.code,
                  phone: sellerProductDetailData!.company!.phone != '' ? sellerProductDetailData!.company!.phone : null,
                ),
                'selected_id': sellerProductDetailData!.address!.sId,
                'selected': sellerProductDetailData!.address!.address,
              };
            }
          });
        }
      }
    });
  }

  Future<XFile?> pickingImage(ImageSource source) async {
    XFile? result;

    ImagePicker picker = ImagePicker();

    await picker.pickImage(
      source: source,
      imageQuality: source == ImageSource.gallery ? 100 : 50,
    ).then((pickResult) async {
      result = pickResult;
    });

    return result;
  }

  Future saveData() async {
    List items = [];

    if(variant != null && variant!.variantData.isNotEmpty) {
      for(int a = 0; a < variant!.variantData.length; a++) {
        items.add({
          '"varian_type1_id"': '"${variant!.typeVariantId}"',
          '"name1"': '"${variant!.variantData[a].name}"',
          '"varian_type2_id"': '""',
          '"name2"': '""',
          '"price"': '"${variant!.variantData[a].price}"',
          '"stock"': '"${variant!.variantData[a].stock}"',
          '"is_stock_always_available"': '"${variant!.variantData[a].isAlwaysAvailable}"',
        });
      }
    }

    await APISellerProductServices(context: context).dioCreate(
      FormSellerProductData(
        name: productNameController.text,
        productCategoryId: '$categoryId',
        description: productDescriptionController.text,
        price: productPriceController.text.replaceAll('.', ''),
        stock: productStockController.text.replaceAll('.', ''),
        isAlwaysAvailable: isAlwaysAvailable,
        isPreorder: isPreOrder,
        addressId: companyData['selected_id'],
        items: items,
        files: productImg,
      ),
    ).then((postResult) {
      if(postResult == true) {
        MoveToPage(
          context: context,
          target: const SellerProductResultPage(isSuccess: true),
          callback: (callbackData) {
            if(callbackData != null) {
              BackFromThisPage(context: context, callbackData: callbackData).go();
            }
          },
        ).go();
      }
    });
  }

  Future updateData() async {
    if(widget.productId != null) {
      List items = [];

      if(variant != null && variant!.variantData.isNotEmpty) {
        for(int a = 0; a < variant!.variantData.length; a++) {
          if(variant!.variantData[a].variantId != null) {
            items.add({
              '"varian_id"': '"${variant!.variantData[a].variantId}"',
              '"varian_type1_id"': '"${variant!.typeVariantId}"',
              '"name1"': '"${variant!.variantData[a].name}"',
              '"varian_type2_id"': '""',
              '"name2"': '""',
              '"price"': '"${variant!.variantData[a].price}"',
              '"stock"': '"${variant!.variantData[a].stock}"',
              '"is_stock_always_available"': '"${variant!.variantData[a].isAlwaysAvailable}"',
            });
          } else {
            items.add({
              '"varian_type1_id"': '"${variant!.typeVariantId}"',
              '"name1"': '"${variant!.variantData[a].name}"',
              '"varian_type2_id"': '""',
              '"name2"': '""',
              '"price"': '"${variant!.variantData[a].price}"',
              '"stock"': '"${variant!.variantData[a].stock}"',
              '"is_stock_always_available"': '"${variant!.variantData[a].isAlwaysAvailable}"',
            });
          }
        }
      }

      await APISellerProductServices(context: context).dioUpdate(
        widget.productId!,
        FormSellerProductData(
          name: productNameController.text,
          productCategoryId: '$categoryId',
          description: productDescriptionController.text,
          price: productPriceController.text.replaceAll('.', ''),
          stock: productStockController.text.replaceAll('.', ''),
          isAlwaysAvailable: isAlwaysAvailable,
          isPreorder: isPreOrder,
          addressId: companyData['selected_id'],
          items: items,
          files: productImg,
        ),
      ).then((postResult) {
        if(postResult == true) {
          SuccessDialog(
            context: context,
            message: 'Perubahan di Simpan',
            okFunction: () {
              BackFromThisPage(context: context).go();
            },
          ).show();
        }
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
                            widget.productId != null ? 'Ubah Detail' : 'Titip Produk',
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
                            if(index == 0) {
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
                                      SourceSelectionDialog(
                                        context: context,
                                        title: 'Tambah Gambar',
                                        message: 'Silahkan pilih sumber gambar',
                                        cameraFunction: () async {
                                          await pickingImage(ImageSource.camera).then((pickResult) {
                                            if(pickResult != null) {
                                              int bytesFile = File(pickResult.path).lengthSync();

                                              if(bytesFile <= 3200000) {
                                                setState(() {
                                                  productImg.add(MediaProductData(xFile: pickResult));
                                                });
                                              } else {
                                                OkDialog(
                                                  context: context,
                                                  message: 'Ukuran file terlalu besar (max: 3MB)',
                                                  showIcon: false,
                                                ).show();
                                              }
                                            }
                                          });
                                        },
                                        galleryFunction: () async {
                                          await pickingImage(ImageSource.gallery).then((pickResult) {
                                            if(pickResult != null) {
                                              int bytesFile = File(pickResult.path).lengthSync();

                                              if(bytesFile <= 3200000) {
                                                setState(() {
                                                  productImg.add(MediaProductData(xFile: pickResult));
                                                });
                                              } else {
                                                OkDialog(
                                                  context: context,
                                                  message: 'Ukuran file terlalu besar (max: 3MB)',
                                                  showIcon: false,
                                                ).show();
                                              }
                                            }
                                          });
                                        },
                                      ).show();
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: PrimaryColorStyles.primaryMain(),
                                          size: 25.0,
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Tambah\nFoto/Video',
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
                            } else {
                              return productImg[index-1].xFile != null ?
                              Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: PrimaryColorStyles.primarySurface(),
                                  border: Border.all(
                                    color: PrimaryColorStyles.primaryBorder(),
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(productImg[index-1].xFile!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onLongPress: () {
                                      setState(() {
                                        productImg.removeAt(index - 1);
                                      });
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Material(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ) :
                              CachedNetworkImage(
                                imageUrl: "$baseURL/${productImg[index-1].url ?? ''}",
                                imageBuilder: (context, imgProvider) {
                                  return Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      color: PrimaryColorStyles.primarySurface(),
                                      border: Border.all(
                                        color: PrimaryColorStyles.primaryBorder(),
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: imgProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onLongPress: () {
                                          OptionDialog(
                                            context: context,
                                            message: 'Hapus gambar yang telah tersimpan, Anda yakin?',
                                            yesFunction: () async {
                                              await APISellerProductServices(context: context).dioRemoveImage(productImg[index-1].sId).then((removeResult) {
                                                if(removeResult == true) {
                                                  setState(() {
                                                    productImg.removeAt(index - 1);
                                                  });
                                                }
                                              });
                                            },
                                          ).show();
                                        },
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: const Material(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (errContext, url, error) {
                                  return SizedBox(
                                    height: 60.0,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onLongPress: () {
                                          OptionDialog(
                                            context: context,
                                            message: 'Hapus gambar yang telah tersimpan, Anda yakin?',
                                            yesFunction: () async {
                                              await APISellerProductServices(context: context).dioRemoveImage(productImg[index-1].sId).then((removeResult) {
                                                if(removeResult == true) {
                                                  setState(() {
                                                    productImg.removeAt(index - 1);
                                                  });
                                                }
                                              });
                                            },
                                          ).show();
                                        },
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Icon(
                                              Icons.broken_image_outlined,
                                              color: IconColorStyles.iconColor(),
                                            ),
                                            Text(
                                              'Tidak dapat memuat gambar',
                                              style: XSTextStyles.medium(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
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
                        Stack(
                          children: [
                            TextField(
                              controller: productCategoryController,
                              decoration: InputDecoration(
                                hintText: 'Pilih Kategori',
                                hintStyle: MTextStyles.regular(),
                                suffixIcon: Icon(
                                  Icons.expand_more_outlined,
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                              enabled: false,
                            ),
                            DropdownButton(
                              onChanged: (newValue) {
                                if(newValue != null) {
                                  setState(() {
                                    productCategoryController.text = newValue.name ?? '';
                                    categoryId = newValue.sId;
                                  });
                                }
                              },
                              isExpanded: true,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.transparent,
                              ),
                              underline: const Material(),
                              items: categoryList.map<DropdownMenuItem<CategoryData>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                    child: Text(
                                      value.name ?? '(Kategori tidak diketahui)',
                                      style: STextStyles.regular(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
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
                            ThousandsSeparatorInputFormatter(),
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
                            hintText: '0',
                          ),
                          enabled: isAlwaysAvailable == false ? true : false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsSeparatorInputFormatter(),
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
                                value: isAlwaysAvailable,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (newValue) {
                                  if(newValue != null) {
                                    if(newValue == true) {
                                      setState(() {
                                        productStockController.text = '1';
                                      });
                                    }
                                    setState(() {
                                      isAlwaysAvailable = newValue;
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
                                  });
                                },
                                child: Text(
                                  'Stok selalu ada',
                                  style: MTextStyles.medium(),
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
                                    style: STextStyles.medium(),
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
                                                style: MTextStyles.regular(),
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
                                                  style: STextStyles.regular(),
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
                                    style: STextStyles.medium(),
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
                                        ThousandsSeparatorInputFormatter(),
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
                                LocalTypeVariant? tempVariant = variant;

                                MoveToPage(
                                  context: context,
                                  target: VariantSelectionPage(
                                    isUpdate: widget.productId != null ? true : null,
                                    productVariant: tempVariant,
                                  ),
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
                        variant != null && variant!.variantData.isNotEmpty ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${variant!.variantData.length} Varian',
                              style: STextStyles.medium(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Tambahkan varian agar pembeli mudah memilih.',
                              style: STextStyles.regular(),
                            ),
                          ],
                        ) :
                        Text(
                          'Tambahkan varian agar pembeli mudah memilih.',
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
                        companyData.isNotEmpty ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              companyData['company_data'].name ?? '(Nama perusahaan tidak terdaftar)',
                              style: MTextStyles.medium(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              companyData['company_data'].phone ?? '(Nomor telepon tidak terdaftar)',
                              style: STextStyles.regular(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              companyData['selected'] ?? '(Alamat tidak diketahui)',
                              style: STextStyles.regular(),
                            ),
                          ],
                        ) :
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
                    if(productImg.isNotEmpty && productNameController.text != '' && categoryId != null && productPriceController.text != '' && productStockController.text != '' && companyData.isNotEmpty) {
                      if(widget.productId != null) {
                        OptionDialog(
                          context: context,
                          title: 'Ubah Produk',
                          message: 'Pastikan semua detail Produk yang akan di submit sudah sesuai',
                          yesText: 'Lanjutkan',
                          yesFunction: () async => updateData(),
                          noText: 'Batal',
                        ).show();
                      } else {
                        OptionDialog(
                          context: context,
                          title: 'Titip Produk',
                          message: 'Pastikan semua detail Produk yang akan di submit sudah sesuai',
                          yesText: 'Lanjutkan',
                          yesFunction: () async => saveData(),
                          noText: 'Batal',
                        ).show();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: productImg.isNotEmpty && productNameController.text != '' && categoryId != null && productPriceController.text != '' && productStockController.text != '' && companyData.isNotEmpty ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      widget.productId != null ? 'Simpan Perubahan' : 'Ajukan Penitipan',
                      style: LTextStyles.medium().copyWith(
                        color: productImg.isNotEmpty && productNameController.text != '' && categoryId != null && productPriceController.text != '' && productStockController.text != '' && companyData.isNotEmpty ? Colors.white : Colors.black54,
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
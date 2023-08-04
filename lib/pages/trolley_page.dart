import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/checkout_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key});

  @override
  State<TrolleyPage> createState() => _TrolleyPageState();
}

class _TrolleyPageState extends State<TrolleyPage> {
  List<LocalTrolleyProduct> trolleyData = [];

  bool isSelectedAll = true;

  GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    List<TrolleyData> tempData = [];

    await APITrolleyServices(context: context).call().then((trolleyResult) {
      if(trolleyResult != null && trolleyResult.trolleyData != null) {
        setState(() {
          tempData = trolleyResult.trolleyData!;
        });
      }

      List<LocalTrolleyProduct> tempLocalTrolleyData = [];

      for(int i = 0; i < tempData.length; i++) {
        tempLocalTrolleyData.add(
          LocalTrolleyProduct(
            isSelected: true,
            trolleyData: tempData[i],
            qty: int.parse(tempData[i].qty ?? '0'),
            canBeUpdated: true,
          ),
        );
      }

      setState(() {
        trolleyData = tempLocalTrolleyData;
      });

      checkIsAllSelected(trolleyData);
    });
  }

  Future<bool> updateCart(LocalTrolleyProduct product, int qty) async {
    bool result = false;

    await APITrolleyServices(context: context, hideLoadingOnUpdate: true).update(
      LocalTrolleyProduct(
        isSelected: true,
        trolleyData: TrolleyData(
          price: product.trolleyData.price,
          varian: product.trolleyData.varian != null ?
          Varian(
            sId: product.trolleyData.varian!.sId,
            price: product.trolleyData.varian!.price,
            name1: product.trolleyData.varian!.name1,
            stock: product.trolleyData.varian!.stock,
            isStockAlwaysAvailable: product.trolleyData.varian!.isStockAlwaysAvailable,
            // varianType1: product.trolleyData.varian!.varianType1,
            promoPrice: product.trolleyData.varian!.promoPrice,
            isPromo: product.trolleyData.varian!.isPromo,
          ) :
          null,
          product: product.trolleyData.product != null ?
          Product(
            sId: product.trolleyData.product!.sId,
          ) :
          null,
        ),
        qty: qty,
      ),
    ).then((updateResult) {
      result = updateResult;
    });

    return result;
  }

  Future deleteAllProduct() async {

  }

  int countTotal() {
    int result = 0;

    if(trolleyData.isNotEmpty) {
      for(int i = 0; i < trolleyData.length; i++) {
        if(trolleyData[i].isSelected == true) {
          result = result + (int.parse(trolleyData[i].trolleyData.price ?? '0') * trolleyData[i].qty);
        }
      }
    }

    return result;
  }

  checkIsAllSelected(List<LocalTrolleyProduct> data) {
    bool result = true;

    for(int i = 0; i < data.length; i++) {
      if(data[i].isSelected == false) {
        result = false;

        break;
      }
    }

    setState(() {
      isSelectedAll = result;
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
                            'Troli',
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
              child: trolleyData.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              onChanged: (newValue) {
                                if(newValue != null) {
                                  setState(() {
                                    isSelectedAll = newValue;

                                    for(int i = 0; i < trolleyData.length; i++) {
                                      trolleyData[i].isSelected = newValue;
                                    }
                                  });
                                }
                              },
                              value: isSelectedAll,
                              title: Text(
                                'Pilih Semua Barang',
                                style: STextStyles.regular(),
                              ),
                              dense: true,
                              activeColor: Theme.of(context).primaryColor,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: InkWell(
                              onTap: () {
                                OptionDialog(
                                  context: context,
                                  title: 'Hapus Semua Produk?',
                                  message: 'Semua produk yang di pilih akan di hapus dari daftar Troli. Lanjutkan?',
                                  yesFunction: () async {
                                    List<LocalTrolleyProduct> tempList = trolleyData;
                                    List<LocalTrolleyProduct> tempRemovedProduct = [];
                                    List<String> tempIdRemovedProduct = [];
                                    List<int> tempIndexRemovedProduct = [];

                                    for(int i = tempList.length - 1; i >= 0; i--) {
                                      if(tempList[i].isSelected == true) {
                                        tempRemovedProduct.add(tempList[i]);
                                        tempIdRemovedProduct.add(tempList[i].trolleyData.sId ?? '');
                                        tempIndexRemovedProduct.add(i);
                                      }
                                    }

                                    await APITrolleyServices(context: context).removeAll(tempIdRemovedProduct).then((removeResult) {
                                      if(removeResult == true) {
                                        setState(() {
                                          for(int x = 0; x < tempIndexRemovedProduct.length; x++) {
                                            trolleyData.removeAt(tempIndexRemovedProduct[x]);
                                            listKey.currentState!.removeItem(tempIndexRemovedProduct[x], (context, animation) {
                                              return ItemListWithAnimation(
                                                trolleyProduct: tempRemovedProduct[x],
                                                animation: animation,
                                                onChangedCheckbox: (selectProduct) {
                                                  tempRemovedProduct[x].isSelected = selectProduct;

                                                  checkIsAllSelected(tempRemovedProduct);
                                                },
                                                onReduceQty: () async {
                                                  if(tempRemovedProduct[x].canBeUpdated == true) {
                                                    if(tempRemovedProduct[x].qty > 1) {
                                                      setState(() {
                                                        tempRemovedProduct[x].canBeUpdated = false;
                                                      });

                                                      await updateCart(tempRemovedProduct[x], -1).then((updateResult) {
                                                        setState(() {
                                                          tempRemovedProduct[x].canBeUpdated = true;

                                                          if(updateResult == true) {
                                                            tempRemovedProduct[x].qty = tempRemovedProduct[x].qty - 1;
                                                          }
                                                        });
                                                      });
                                                    }
                                                  }
                                                },
                                                onAddQty: () async {
                                                  if(tempRemovedProduct[x].canBeUpdated == true) {
                                                    if(tempRemovedProduct[x].trolleyData.product != null) {
                                                      if(tempRemovedProduct[x].trolleyData.varian != null) {
                                                        if(tempRemovedProduct[x].qty < int.parse(tempRemovedProduct[x].trolleyData.varian!.stock ?? '0')) {
                                                          setState(() {
                                                            tempRemovedProduct[x].canBeUpdated = false;
                                                          });

                                                          await updateCart(tempRemovedProduct[x], 1).then((updateResult) {
                                                            setState(() {
                                                              tempRemovedProduct[x].canBeUpdated = true;

                                                              if(updateResult == true) {
                                                                tempRemovedProduct[x].qty = tempRemovedProduct[x].qty + 1;
                                                              }
                                                            });
                                                          });
                                                        }
                                                      } else {
                                                        if(tempRemovedProduct[x].trolleyData.product!.stock != null && tempRemovedProduct[x].trolleyData.product!.stock != '') {
                                                          if(tempRemovedProduct[x].qty < int.parse(tempRemovedProduct[x].trolleyData.product!.stock ?? '0')) {
                                                            setState(() {
                                                              tempRemovedProduct[x].canBeUpdated = false;
                                                            });

                                                            await updateCart(tempRemovedProduct[x], 1).then((updateResult) {
                                                              setState(() {
                                                                tempRemovedProduct[x].canBeUpdated = true;

                                                                if(updateResult == true) {
                                                                  tempRemovedProduct[x].qty = tempRemovedProduct[x].qty + 1;
                                                                }
                                                              });
                                                            });
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                              );
                                            }, duration: const Duration(milliseconds: 500));
                                          }
                                        });
                                      }
                                    });
                                  },
                                  
                                ).show();
                              },
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.delete,
                                  color: IconColorStyles.iconColor(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        loadData();
                      },
                      child: AnimatedList(
                        key: listKey,
                        initialItemCount: trolleyData.length,
                        itemBuilder: (BuildContext listTrolleyContext, int index, Animation<double> animation) {
                          return Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.15,
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext pressedContext) {
                                    OptionDialog(
                                      context: context,
                                      title: 'Hapus Produk?',
                                      message: 'Produk yang di pilih akan di hapus dari daftar Troli. Lanjutkan?',
                                      yesFunction: () async {
                                        LocalTrolleyProduct tempList = trolleyData[index];

                                        await APITrolleyServices(context: context).remove(trolleyData[index].trolleyData.sId ?? '').then((removeResult) {
                                          if(removeResult == true) {
                                            setState(() {
                                              trolleyData.removeAt(index);
                                              listKey.currentState!.removeItem(index, (context, animation) {
                                                return ItemListWithAnimation(
                                                  trolleyProduct: tempList,
                                                  animation: animation,
                                                  onChangedCheckbox: (selectProduct) {
                                                    tempList.isSelected = selectProduct;

                                                    checkIsAllSelected(trolleyData);
                                                  },
                                                  onReduceQty: () async {
                                                    if(tempList.canBeUpdated == true) {
                                                      if(tempList.qty > 1) {
                                                        setState(() {
                                                          tempList.canBeUpdated = false;
                                                        });

                                                        await updateCart(tempList, -1).then((updateResult) {
                                                          setState(() {
                                                            tempList.canBeUpdated = true;

                                                            if(updateResult == true) {
                                                              tempList.qty = tempList.qty - 1;
                                                            }
                                                          });
                                                        });
                                                      }
                                                    }
                                                  },
                                                  onAddQty: () async {
                                                    if(tempList.canBeUpdated == true) {
                                                      if(tempList.trolleyData.product != null) {
                                                        if(tempList.trolleyData.varian != null) {
                                                          if(tempList.qty < int.parse(tempList.trolleyData.varian!.stock ?? '0')) {
                                                            setState(() {
                                                              tempList.canBeUpdated = false;
                                                            });

                                                            await updateCart(tempList, 1).then((updateResult) {
                                                              setState(() {
                                                                tempList.canBeUpdated = true;

                                                                if(updateResult == true) {
                                                                  tempList.qty = tempList.qty + 1;
                                                                }
                                                              });
                                                            });
                                                          }
                                                        } else {
                                                          if(tempList.trolleyData.product!.stock != null && tempList.trolleyData.product!.stock != '') {
                                                            if(tempList.qty < int.parse(tempList.trolleyData.product!.stock ?? '0')) {
                                                              setState(() {
                                                                tempList.canBeUpdated = false;
                                                              });

                                                              await updateCart(tempList, 1).then((updateResult) {
                                                                setState(() {
                                                                  tempList.canBeUpdated = true;

                                                                  if(updateResult == true) {
                                                                    tempList.qty = tempList.qty + 1;
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  },
                                                );
                                              }, duration: const Duration(milliseconds: 500));
                                            });
                                          }
                                        });
                                      },
                                      
                                    ).show();
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: ItemListWithAnimation(
                              trolleyProduct: trolleyData[index],
                              animation: animation,
                              onChangedCheckbox: (selectProduct) {
                                setState(() {
                                  trolleyData[index].isSelected = selectProduct;
                                });

                                checkIsAllSelected(trolleyData);
                              },
                              onReduceQty: () async {
                                if(trolleyData[index].canBeUpdated == true) {
                                  if(trolleyData[index].qty > 1) {
                                    setState(() {
                                      trolleyData[index].canBeUpdated = false;
                                    });

                                    await updateCart(trolleyData[index], -1).then((updateResult) {
                                      setState(() {
                                        trolleyData[index].canBeUpdated = true;

                                        if(updateResult == true) {
                                          trolleyData[index].qty = trolleyData[index].qty - 1;
                                        }
                                      });
                                    });
                                  }
                                }
                              },
                              onAddQty: () async {
                                if(trolleyData[index].canBeUpdated == true) {
                                  if(trolleyData[index].trolleyData.product != null) {
                                    if(trolleyData[index].trolleyData.varian != null) {
                                      if(trolleyData[index].qty < int.parse(trolleyData[index].trolleyData.varian!.stock ?? '0')) {
                                        setState(() {
                                          trolleyData[index].canBeUpdated = false;
                                        });

                                        await updateCart(trolleyData[index], 1).then((updateResult) {
                                          setState(() {
                                            trolleyData[index].canBeUpdated = true;

                                            if(updateResult == true) {
                                              trolleyData[index].qty = trolleyData[index].qty + 1;
                                            }
                                          });
                                        });
                                      }
                                    } else {
                                      if(trolleyData[index].trolleyData.product!.stock != null && trolleyData[index].trolleyData.product!.stock != '') {
                                        if(trolleyData[index].qty < int.parse(trolleyData[index].trolleyData.product!.stock ?? '0')) {
                                          setState(() {
                                            trolleyData[index].canBeUpdated = false;
                                          });

                                          await updateCart(trolleyData[index], 1).then((updateResult) {
                                            setState(() {
                                              trolleyData[index].canBeUpdated = true;

                                              if(updateResult == true) {
                                                trolleyData[index].qty = trolleyData[index].qty + 1;
                                              }
                                            });
                                          });
                                        }
                                      }
                                    }
                                  }
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Image.asset(
                          'assets/images/icon_trolley_empty.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Belum Ada Produk di Troli',
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Yuk eksplor semua produk yang ada di\nKenari, tambah ke Troli & Checkout\nProdukmu!',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      loadData();
                    },
                    child: ListView(),
                  ),
                ],
              ),
            ),
            trolleyData.isNotEmpty ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Total Harga',
                            style: MTextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Rp ${NumberFormat('#,###', 'en_id').format(countTotal()).replaceAll(',', '.')},-',
                            style: TextStyle(
                              color: PrimaryColorStyles.primaryMain(),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        List<LocalTrolleyProduct> selectedProductList = [];

                        for(int i = 0; i < trolleyData.length; i++) {
                          if(trolleyData[i].isSelected == true) {
                            selectedProductList.add(trolleyData[i]);
                          }
                        }

                        if(selectedProductList.isNotEmpty) {
                          MoveToPage(
                            context: context,
                            target: CheckoutPage(
                              selectedProductList: trolleyData,
                            ),
                            callback: (callbackResult) {
                              if(callbackResult != null) {
                                BackFromThisPage(context: context, callbackData: callbackResult).go();
                              }
                            },
                          ).go();
                        } else {
                          OkDialog(
                            context: context,
                            message: 'Harap pilih produk terlebih dahulu!',
                            showIcon: false,
                          ).show();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Checkout',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) :
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    BackFromThisPage(context: context).go();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Belanja Sekarang',
                      style: LTextStyles.medium().copyWith(
                        color: Colors.white,
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

class ItemListWithAnimation extends StatelessWidget {
  final LocalTrolleyProduct trolleyProduct;
  final Animation<double> animation;
  final Function onChangedCheckbox;
  final Function onReduceQty;
  final Function onAddQty;

  const ItemListWithAnimation({
    super.key,
    required this.trolleyProduct,
    required this.animation,
    required this.onChangedCheckbox,
    required this.onReduceQty,
    required this.onAddQty,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: buildItem(),
    );
  }

  Widget buildItem() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: trolleyProduct.isSelected,
              onChanged: (selectProduct) {
                if(selectProduct != null) {
                  onChangedCheckbox(selectProduct);
                }
              },
              activeColor: PrimaryColorStyles.primaryMain(),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: "$baseURL/${trolleyProduct.trolleyData.product != null && trolleyProduct.trolleyData.product!.images != null && trolleyProduct.trolleyData.product!.images!.isNotEmpty && trolleyProduct.trolleyData.product!.images![0].url != null ? trolleyProduct.trolleyData.product!.images![0].url! : ''}",
                    imageBuilder: (context, imgProvider) {
                      return Container(
                        width: 65.0,
                        height: 65.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: imgProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return SizedBox(
                        width: 65.0,
                        height: 65.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              color: IconColorStyles.iconColor(),
                            ),
                            Text(
                              'Unable to load image',
                              style: XSTextStyles.medium(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          trolleyProduct.trolleyData.product != null && trolleyProduct.trolleyData.product!.name != null ? trolleyProduct.trolleyData.product!.name! : '(Produk tidak diketahui)',
                          style: MTextStyles.medium(),
                        ),
                        trolleyProduct.trolleyData.varian != null ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              trolleyProduct.trolleyData.varian!.name1 ?? '(Varian tidak diketahui)',
                              style: STextStyles.regular(),
                            ),
                          ],
                        ) :
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(trolleyProduct.trolleyData.price ?? '0')).replaceAll(',', '.')}',
                                style: MTextStyles.regular().copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: trolleyProduct.qty == 1 ? NeutralColorStyles.neutral03() : BorderColorStyles.borderDivider(),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  onReduceQty();
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: trolleyProduct.qty == 1 ? NeutralColorStyles.neutral03() : IconColorStyles.iconColor(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: SizedBox(
                                width: 20.0,
                                child: Text(
                                  '${trolleyProduct.qty}',
                                  style: MTextStyles.regular(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BorderColorStyles.borderDivider(),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  onAddQty();
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: IconColorStyles.iconColor(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        trolleyProduct.canBeUpdated != true ?
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: LinearProgressIndicator(),
                        ) :
                        const Material(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
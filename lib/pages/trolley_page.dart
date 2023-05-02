import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/checkout_page.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key,});

  @override
  State<TrolleyPage> createState() => _TrolleyPageState();
}

class _TrolleyPageState extends State<TrolleyPage> {
  List<LocalTrolleyProduct> trolleyData = [];

  int total = 0;

  bool isSelectedAll = false;

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
      int tempTotal = 0;

      for(int i = 0; i < tempData.length; i++) {
        tempLocalTrolleyData.add(
          LocalTrolleyProduct(
            isSelected: false,
            trolleyData: tempData[i],
            qty: int.parse(tempData[i].qty ?? '0'),
          ),
        );

        tempTotal = tempTotal + (int.parse(tempData[i].price ?? '0') * int.parse(tempData[i].qty ?? '0'));
      }

      setState(() {
        trolleyData = tempLocalTrolleyData;
        total = tempTotal;
      });
    });
  }

  Future deleteAllProduct() async {

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
                                  yesFunction: () {
                                    List<LocalTrolleyProduct> tempList = trolleyData;

                                    for(int i = tempList.length - 1; i >= 0; i--) {
                                      if(tempList[i].isSelected == true) {
                                        LocalTrolleyProduct tempTrolleyProduct = tempList[i];

                                        setState(() {
                                          trolleyData.removeAt(i);
                                          listKey.currentState!.removeItem(i, (context, animation) {
                                            return ItemListWithAnimation(
                                              trolleyProduct: tempTrolleyProduct,
                                              animation: animation,
                                              onChangedCheckbox: (_) {},
                                              onReduceQty: () {},
                                              onAddQty: () {},
                                            );
                                          }, duration: const Duration(milliseconds: 500));
                                        });
                                      }
                                    }
                                  },
                                  noFunction: () {},
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
                                      yesFunction: () {
                                        LocalTrolleyProduct tempList = trolleyData[index];

                                        setState(() {
                                          trolleyData.removeAt(index);
                                          listKey.currentState!.removeItem(index, (context, animation) {
                                            return ItemListWithAnimation(
                                              trolleyProduct: tempList,
                                              animation: animation,
                                              onChangedCheckbox: (selectProduct) {
                                                setState(() {
                                                  tempList.isSelected = selectProduct;
                                                });

                                                for(int i = 0; i < trolleyData.length; i++) {
                                                  if(trolleyData[i].isSelected == false) {
                                                    setState(() {
                                                      isSelectedAll = false;
                                                    });

                                                    break;
                                                  }
                                                }
                                              },
                                              onReduceQty: () {
                                                if(tempList.qty > 1) {
                                                  setState(() {
                                                    tempList.qty = tempList.qty - 1;
                                                  });
                                                }
                                              },
                                              onAddQty: () {
                                                setState(() {
                                                  tempList.qty = tempList.qty + 1;
                                                });
                                              },
                                            );
                                          },
                                          duration: const Duration(milliseconds: 500));
                                        });
                                      },
                                      noFunction: () {},
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

                                for(int i = 0; i < trolleyData.length; i++) {
                                  if(trolleyData[i].isSelected == false) {
                                    setState(() {
                                      isSelectedAll = false;
                                    });

                                    break;
                                  }
                                }
                              },
                              onReduceQty: () {
                                if(trolleyData[index].qty > 1) {
                                  setState(() {
                                    trolleyData[index].qty = trolleyData[index].qty - 1;
                                  });
                                }
                              },
                              onAddQty: () {
                                setState(() {
                                  trolleyData[index].qty = trolleyData[index].qty + 1;
                                });
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
                            'Rp ${NumberFormat('#,###', 'en_id').format(total).replaceAll(',', '.')},-',
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
                        MoveToPage(
                          context: context,
                          target: const CheckoutPage(
                            trolleyData: [],
                          ),
                          callback: (callbackResult) {
                            if(callbackResult != null) {
                              BackFromThisPage(context: context, callbackData: callbackResult).go();
                            }
                          }
                        ).go();
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
                    imageUrl: trolleyProduct.trolleyData.product != null && trolleyProduct.trolleyData.product!.images != null && trolleyProduct.trolleyData.product!.images![0].url != null ? trolleyProduct.trolleyData.product!.images![0].url! : '',
                    imageBuilder: (context, imgProvider) {
                      return Container(
                        width: 65.0,
                        height: 65.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: imgProvider,
                            fit: BoxFit.cover,
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
                          trolleyProduct.trolleyData.product != null && trolleyProduct.trolleyData.product!.name != null ? trolleyProduct.trolleyData.product!.name! : 'Unknown Product',
                          style: MTextStyles.medium(),
                        ),
                        trolleyProduct.trolleyData.varian != null && trolleyProduct.trolleyData.varianName != null ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              trolleyProduct.trolleyData.varianName ?? 'Unknown Variant',
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
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 5.0),
                        //   child: LinearProgressIndicator(),
                        // ),
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
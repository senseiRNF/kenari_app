import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_page.dart';
import 'package:kenari_app/pages/loan_page.dart';
import 'package:kenari_app/pages/notification_page.dart';
import 'package:kenari_app/pages/product_list_banner_page.dart';
import 'package:kenari_app/pages/product_list_page.dart';
import 'package:kenari_app/pages/seller_page.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomeFragment extends StatelessWidget {
  final int selectedCard;
  final List<String> filterList;
  final List<ProductData> productList;
  final List<ProductData> newProductList;
  final List<ProductData> popularProductList;
  final List<ProductData> discountProductList;
  final List<CategoryData> categoryList;
  final Function onChangeSelectedPage;
  final Function onShowAllMenuBottomDialog;
  final Function onShowProductBottomDialog;
  final Function onProductSelected;
  final Function onCallbackFromFeePage;
  final Function onCallbackFromLoanPage;
  final Function onCallbackFromSellerPage;

  const HomeFragment({
    super.key,
    required this.selectedCard,
    required this.filterList,
    required this.productList,
    required this.newProductList,
    required this.popularProductList,
    required this.discountProductList,
    required this.categoryList,
    required this.onChangeSelectedPage,
    required this.onShowAllMenuBottomDialog,
    required this.onShowProductBottomDialog,
    required this.onProductSelected,
    required this.onCallbackFromFeePage,
    required this.onCallbackFromLoanPage,
    required this.onCallbackFromSellerPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xffff4700),
                Color(0xffff5f0a),
                Color(0xffff7613),
                Color(0xffff7f17),
                Color(0xffff7a15),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 31.0,
                  height: 36.0,
                  child: Image.asset(
                    'assets/images/white_main_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    'Selamat datang di\nKenari!',
                    style: MTextStyles.medium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      MoveToPage(
                        context: context,
                        target: const TrolleyPage(
                          productList: [

                          ],
                        ),
                        callback: (callbackResult) {
                          if(callbackResult != null) {

                          }
                        },
                      ).go();
                    },
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      MoveToPage(context: context, target: const NotificationPage()).go();
                    },
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: BackgroundColorStyles.pageBackground(),
            child: ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    onPageChanged: (page, reason) {
                      onChangeSelectedPage(page);
                    },
                  ),
                  items: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff242424),
                              Color(0xff363636),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    'assets/images/dipay_logo.png',
                                    fit: BoxFit.fitWidth,
                                    width: 50.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'Aktivasi akun Dipay untuk segala\nmacam transaksi di Kenari',
                                  style: STextStyles.medium().copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {

                                      },
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Aktivasi Akun',
                                            style: XSTextStyles.medium().copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff101828),
                              Color(0xff475467),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    'assets/images/indofund_logo_white.png',
                                    fit: BoxFit.fitWidth,
                                    width: 50.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'Aktivasi akun Indofund untuk\nkemudahan fitur pinjaman di Kenari',
                                  style: STextStyles.medium().copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {

                                      },
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Aktivasi Akun',
                                            style: XSTextStyles.medium().copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: selectedCard == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        height: 3.0,
                        width: 20.0,
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: selectedCard == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        height: 3.0,
                        width: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                MoveToPage(
                                  context: context,
                                  target: const FeePage(),
                                  callback: (callbackResult) {
                                    if(callbackResult != null && callbackResult == false) {
                                      onCallbackFromFeePage();
                                    }
                                  },
                                ).go();
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_iuran.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Iuran',
                            style: STextStyles.medium(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                MoveToPage(
                                  context: context,
                                  target: const LoanPage(),
                                  callback: (callbackResult) {
                                    if(callbackResult != null) {
                                      onCallbackFromLoanPage(callbackResult);
                                    }
                                  },
                                ).go();
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_pinjaman.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Pinjaman',
                            style: STextStyles.medium(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                MoveToPage(
                                  context: context,
                                  target: const SellerPage(),
                                  callback: (callbackResult) {
                                    if(callbackResult != null) {
                                      onCallbackFromSellerPage(callbackResult);
                                    }
                                  },
                                ).go();
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_titip_jual.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Titip Jual',
                            style: STextStyles.medium(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                onShowAllMenuBottomDialog();
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_semua.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Semua',
                            style: STextStyles.medium(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produk Terbaru',
                        style: MTextStyles.medium(),
                      ),
                      TextButton(
                        onPressed: () {
                          MoveToPage(context: context, target: ProductListPage(
                            filterType: 'Terbaru',
                            filterList: filterList,
                            productList: productList,
                          )).go();
                        },
                        child: Text(
                          'Lihat semua',
                          style: MTextStyles.medium().copyWith(
                            color: PrimaryColorStyles.primaryMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: newProductList.length,
                          itemBuilder: (BuildContext listContext, int index) {
                            String price = '';

                            if(newProductList[index].varians == null || newProductList[index].varians!.isEmpty) {
                              price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(newProductList[index].price ?? '0')).replaceAll(',', '.')}';
                            } else {
                              List sortedVariantPrice = newProductList[index].varians!;

                              sortedVariantPrice.sort();

                              int lowest = sortedVariantPrice[0] ?? 0;
                              int highest = sortedVariantPrice[sortedVariantPrice.length - 1] ?? 0;

                              price = 'Rp ${NumberFormat('#,###', 'en_id').format(lowest).replaceAll(',', '.')} - ${NumberFormat('#,###', 'en_id').format(highest).replaceAll(',', '.')}';
                            }

                            return Padding(
                              padding: index == 0 ? const EdgeInsets.only(left: 25.0, right: 5.0) : index == newProductList.length - 1 ? const EdgeInsets.only(left: 5.0, right: 25.0) : const EdgeInsets.symmetric(horizontal: 5.0),
                              child: InkWell(
                                onTap: () => onProductSelected(newProductList[index]),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SizedBox(
                                  width: 150.0,
                                  height: 200.0,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  newProductList[index].images != null && newProductList[index].images![0].url != null ? newProductList[index].images![0].url! : '',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(
                                                  newProductList[index].productCategory != null && newProductList[index].productCategory!.name != null ? newProductList[index].productCategory!.name! : 'Unknow Category',
                                                  style: XSTextStyles.regular(),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                  child: Text(
                                                    newProductList[index].name ?? 'Unknown Product',
                                                    style: STextStyles.medium(),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        price,
                                                        style: XSTextStyles.medium().copyWith(
                                                          color: PrimaryColorStyles.primaryMain(),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        onShowProductBottomDialog(newProductList[index]);
                                                      },
                                                      customBorder: const CircleBorder(),
                                                      child: Icon(
                                                        Icons.more_horiz,
                                                        size: 15.0,
                                                        color: IconColorStyles.iconColor(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                  height: 30.0,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.9,
                  ),
                  items: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          MoveToPage(context: context, target: ProductListBannerPage(
                            productList: productList,
                            bannerType: 'discount',
                            filterList: filterList,
                          )).go();
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/banner_discount.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          MoveToPage(context: context, target: ProductListBannerPage(
                            productList: productList,
                            bannerType: 'clothes',
                            filterList: filterList,
                          )).go();
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/banner_new_collection.png',
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Kategori Produk',
                    style: MTextStyles.medium(),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext categoryContext, int categoryIndex) {
                            return Padding(
                              padding: categoryIndex == 0 ? const EdgeInsets.only(left: 25.0, right: 5) : categoryIndex == categoryList.length - 1 ? const EdgeInsets.only(left: 5.0, right: 25.0,) : const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: BorderColorStyles.borderStrokes(),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    MoveToPage(context: context, target: ProductListPage(
                                      filterType: 'Kategori_${categoryList[categoryIndex].name}',
                                      productList: productList,
                                      filterList: filterList,
                                    )).go();
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        categoryList[categoryIndex].name ?? 'Unknown Category',
                                        style: MTextStyles.regular(),
                                      ),
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
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text(
                    'Produk Populer',
                    style: MTextStyles.medium(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: popularProductList.length,
                          separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                            return Divider(
                              thickness: 0.5,
                              color: BorderColorStyles.borderDivider(),
                            );
                          },
                          itemBuilder: (BuildContext popularContext, int index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 110.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        popularProductList[index].images != null && popularProductList[index].images![0].url != null ? popularProductList[index].images![0].url! : '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        popularProductList[index].name ?? 'Unknown Product',
                                        style: STextStyles.medium(),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: BorderColorStyles.borderStrokes(),
                                              ),
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                              child: Text(
                                                popularProductList[index].productCategory != null && popularProductList[index].productCategory!.name != null ? popularProductList[index].productCategory!.name! : 'Unknown Category',
                                                style: XSTextStyles.regular(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: popularProductList[index].promoPrice != null ?
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].promoPrice ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: PrimaryColorStyles.primaryMain(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].price ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: TextColorStyles.textDisabled(),
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ) :
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(
                                                  height: 25.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].price ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: PrimaryColorStyles.primaryMain(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.shopping_cart,
                                            color: IconColorStyles.iconColor(),
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Diskon',
                        style: MTextStyles.medium(),
                      ),
                      TextButton(
                        onPressed: () {
                          MoveToPage(context: context, target: ProductListPage(
                            filterType: 'Diskon',
                            productList: productList,
                            filterList: filterList,
                          )).go();
                        },
                        child: Text(
                          'Lihat semua',
                          style: MTextStyles.medium().copyWith(
                            color: PrimaryColorStyles.primaryMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 210.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: discountProductList.length,
                          itemBuilder: (BuildContext listContext, int index) {
                            String normalPrice = '';
                            String discountPrice = '';

                            normalPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].price ?? '0')).replaceAll(',', '.')}';
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].promoPrice ?? '0')).replaceAll(',', '.')}';

                            return Padding(
                              padding: index == 0 ? const EdgeInsets.only(left: 25.0, right: 5.0) : index == discountProductList.length - 1 ? const EdgeInsets.only(left: 5.0, right: 25.0) : const EdgeInsets.symmetric(horizontal: 5.0),
                              child: SizedBox(
                                width: 150.0,
                                height: 200.0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                discountProductList[index].images != null && discountProductList[index].images![0].url != null ? discountProductList[index].images![0].url! : '',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                discountProductList[index].productCategory != null && discountProductList[index].productCategory!.name != null ? discountProductList[index].productCategory!.name! : 'Unknown Category',
                                                style: XSTextStyles.regular(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  discountProductList[index].name ?? 'Unknown Product',
                                                  style: STextStyles.medium(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Text(
                                                discountPrice,
                                                style: XSTextStyles.medium().copyWith(
                                                  color: PrimaryColorStyles.primaryMain(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      normalPrice,
                                                      style: XSTextStyles.medium().copyWith(
                                                        color: TextColorStyles.textDisabled(),
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {

                                                    },
                                                    customBorder: const CircleBorder(),
                                                    child: Icon(
                                                      Icons.more_horiz,
                                                      size: 15.0,
                                                      color: IconColorStyles.iconColor(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/fragments/home_fragment.dart';
import 'package:kenari_app/fragments/profile_fragment.dart';
import 'package:kenari_app/fragments/search_fragment.dart';
import 'package:kenari_app/fragments/transaction_fragment.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_page.dart';
import 'package:kenari_app/pages/product_page.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/product/api_category_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_product_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenu = 0;
  int selectedCard = 0;

  String? name;
  String? companyCode;
  String filterType = 'Tampilkan Semua';

  TextEditingController searchController = TextEditingController();

  List<LocalProductData> productList = [
    LocalProductData(
      type: 'Sembako',
      name: 'Cabai Merah',
      variant: ['1/4 Kg', '1/2 Kg', '1 Kg'],
      normalPrice: [25000, 45000, 65000],
      discountPrice: [0, 0, 0],
      stock: [50, 50, 50],
      imagePath: ['assets/images/example_images/cabai-rawit-merah.png'],
      newFlag: true,
      popularFlag: false,
      discountFlag: false,
    ),
    LocalProductData(
      type: 'Makanan',
      name: 'Keripik Kentang',
      normalPrice: [55000],
      discountPrice: [0],
      stock: [50],
      imagePath: ['assets/images/example_images/keripik-kentang.png'],
      newFlag: true,
      popularFlag: false,
      discountFlag: false,
    ),
    LocalProductData(
      type: 'Buah-buahan',
      name: 'Jambu Air',
      variant: ['1/4 Kg', '1/2 Kg', '1 Kg'],
      normalPrice: [25000, 45000, 65000],
      discountPrice: [0, 0, 0],
      stock: [50, 50, 50],
      imagePath: ['assets/images/example_images/jambu-air.png'],
      newFlag: true,
      popularFlag: false,
      discountFlag: false,
    ),
    LocalProductData(
      type: 'Makanan',
      name: 'Paket sayuran untuk masak',
      normalPrice: [400000],
      discountPrice: [200000],
      stock: [50],
      imagePath: ['assets/images/example_images/paket-sayuran.png'],
      newFlag: false,
      popularFlag: true,
      discountFlag: true,
    ),
    LocalProductData(
      type: 'Outfit',
      name: 'Kaos Terkini',
      normalPrice: [400000],
      discountPrice: [200000],
      stock: [50],
      imagePath: ['assets/images/example_images/kaos-terkini.png'],
      newFlag: false,
      popularFlag: true,
      discountFlag: true,
    ),
    LocalProductData(
      type: 'Outfit',
      name: 'Blue Jeans',
      normalPrice: [400000],
      discountPrice: [200000],
      stock: [50],
      imagePath: ['assets/images/example_images/blue-jeans.png'],
      newFlag: false,
      popularFlag: true,
      discountFlag: true,
    ),
    LocalProductData(
      type: 'Elektronik',
      name: 'Vape Electric',
      normalPrice: [400000],
      discountPrice: [0],
      stock: [50],
      imagePath: ['assets/images/example_images/vape-electric.png'],
      newFlag: false,
      popularFlag: true,
      discountFlag: false,
    ),
    LocalProductData(
      type: 'Makanan',
      name: 'Cookies',
      variant: ['1/4 Kg', '1/2 Kg', '1 Kg'],
      normalPrice: [20000, 30000, 50000],
      discountPrice: [15000, 25000, 45000],
      stock: [50],
      imagePath: ['assets/images/example_images/cookies.png'],
      newFlag: false,
      popularFlag: false,
      discountFlag: true,
    ),
    LocalProductData(
      type: 'Makanan',
      name: 'Strawberry Cake',
      normalPrice: [50000],
      discountPrice: [46000],
      stock: [50],
      imagePath: ['assets/images/example_images/strawberry-cupcakes.png'],
      newFlag: false,
      popularFlag: false,
      discountFlag: true,
    ),
    LocalProductData(
      type: 'Buah-buahan',
      name: 'Jambu Air',
      variant: ['1/4 Kg'],
      normalPrice: [25000],
      discountPrice: [20000],
      stock: [50],
      imagePath: ['assets/images/example_images/jambu-air.png'],
      newFlag: false,
      popularFlag: false,
      discountFlag: true,
    ),
  ];

  List<CategoryData> categoryList = [];

  List<String> filterList = [
    'Tampilkan Semua',
    'Terbaru',
    'Terlaris',
    'Diskon',
    'Harga Terendah',
    'Harga Tertinggi',
  ];

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  Future<void> initLoad() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        name = nameResult;
      });

      await LocalSharedPrefs().readKey('company_code').then((companyCodeResult) async {
        setState(() {
          companyCode = companyCodeResult;
        });

        await APICategoryServices(context: context).call().then((result) {
          if(result != null && result.categoryData != null) {
            setState(() {
              categoryList = result.categoryData!;
            });
          }
        });
      });
    });
  }

  Widget activeFragment() {
    switch(selectedMenu) {
      case 0:
        List<LocalProductData> newProductList = [];
        List<LocalProductData> popularProductList = [];
        List<LocalProductData> discountProductList = [];

        for(int i = 0; i < productList.length; i++) {
          if(productList[i].newFlag == true) {
            newProductList.add(productList[i]);
          } else if(productList[i].popularFlag == true) {
            popularProductList.add(productList[i]);
          } else if(productList[i].discountFlag == true) {
            discountProductList.add(productList[i]);
          }
        }

        return HomeFragment(
          selectedCard: selectedCard,
          filterList: filterList,
          productList: productList,
          newProductList: newProductList,
          popularProductList: popularProductList,
          discountProductList: discountProductList,
          categoryList: categoryList,
          onChangeSelectedPage: (int page) {
            setState(() {
              selectedCard = page;
            });
          },
          onShowAllMenuBottomDialog: () {
            showAllMenuBottomDialog();
          },
          onShowProductBottomDialog: (LocalProductData product) {
            showProductBottomDialog(product);
          },
          onProductSelected: (LocalProductData product) {
            MoveToPage(context: context, target: ProductPage(productData: product)).go();
          },
        );
      case 1:
        return SearchFragment(
          searchController: searchController,
          productList: productList,
          categoryList: categoryList,
          filterList: filterList,
          filterType: filterType,
          onFilterChange: (String? selectedFilter) {
            if(selectedFilter != null) {
              setState(() {
                filterType = selectedFilter;
              });
            }
          },
        );
      case 2:
        return const TransactionFragment();
      case 3:
        return ProfileFragment(
          name: name,
          companyCode: companyCode,
          refreshPage: () {
            initLoad();
          },
          onLogout: () async {
            await LocalSharedPrefs().removeAllKey().then((removeResult) {
              if(removeResult == true) {
                RedirectToPage(context: context, target: const SplashPage()).go();
              }
            });
          },
        );
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Terjadi kesalahan....',
              style: HeadingTextStyles.headingM(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Silahkan muat ulang aplikasi, apabila kesalahan terus terjadi, mohon untuk segera menghubungi administrator.',
              style: LTextStyles.medium(),
              textAlign: TextAlign.center,
            ),
          ],
        );
    }
  }

  Future<void> showAllMenuBottomDialog() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalBottomContext) {
        return FractionallySizedBox(
          heightFactor: 0.70,
          child: Column(
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
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Layanan Keuangan',
                        style: STextStyles.medium().copyWith(
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
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                MoveToPage(context: context, target: const FeePage()).go();
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
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Iuran',
                                  style: STextStyles.medium(),
                                ),
                                Text(
                                  'Bayar Iuran wajib dan berjangka Perusahaan kamu disini',
                                  style: XSTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {

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
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Pinjaman',
                                  style: STextStyles.medium(),
                                ),
                                Text(
                                  'Dapatkan pinjaman uang untuk pengembangan usaha mu dan kebutuhan lainnya disini',
                                  style: XSTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Jualan Produk',
                        style: STextStyles.medium().copyWith(
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
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {

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
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Titip Jual',
                                  style: STextStyles.medium(),
                                ),
                                Text(
                                  'Dapatkan penghasilan tambahan dengan Titip Jual barang apapun disini',
                                  style: XSTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Coming Soon',
                        style: STextStyles.medium().copyWith(
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
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {

                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_reksadana.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Reksadana',
                                  style: STextStyles.medium(),
                                ),
                                Text(
                                  'Sisihkan gaji untuk Investasi yang kekinian, nggak ribet, dan bisa dimulai dengan modal kecil.',
                                  style: XSTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          Container(
                            width: 54.0,
                            height: 54.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: BorderColorStyles.borderStrokes(),
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () {

                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/icon_ppob.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'PPOB',
                                  style: STextStyles.regular(),
                                ),
                                Text(
                                  'Memudahkanmu dalam membayarkan berbagai jenis tagihan bulanan.',
                                  style: XSTextStyles.regular(),
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
            ],
          ),
        );
      },
    );
  }

  Future<void> showProductBottomDialog(LocalProductData product) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        int index = 0;
        int qty = 1;
        int stock = product.stock[index];

        String price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.normalPrice[index]).replaceAll(',', '.')}';
        String imagePath = product.imagePath[index] ?? '';
        String? variant;

        if(product.variant != null) {
          variant = product.variant![index];
        }

        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Column(
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
                    product.variant != null ? 'Varian Produk' : 'Tambah Troli',
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              imagePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const SizedBox(
                          width: 80.0,
                          height: 80.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              product.name,
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            variant != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: NeutralColorStyles.neutral04(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      variant!,
                                      style: XSTextStyles.medium(),
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            const Material(),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              price,
                              style: LTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Stok:',
                                  style: STextStyles.regular(),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    product.type == 'Sembako' ? 'Selalu ada' : stock.toString(),
                                    style: STextStyles.medium(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                product.variant != null ?
                Column (
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Pilih Varian :',
                        style: STextStyles.medium().copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        height: 30.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: product.variant!.length,
                          separatorBuilder: (BuildContext separatorContext, int index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          itemBuilder: (BuildContext gridContext, int itemIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: index == itemIndex ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  stateSetter(() {
                                    index = itemIndex;
                                    variant = product.variant![itemIndex];

                                    if(product.discountPrice[index] != 0) {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.discountPrice[index]).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.normalPrice[index]).replaceAll(',', '.')}';
                                    }
                                  });
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    product.variant![itemIndex],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ) :
                const Material(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: qty > 1 ? NeutralColorStyles.neutral04() : NeutralColorStyles.neutral03(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(qty > 1) {
                              stateSetter(() {
                                qty = qty - 1;
                              });
                            }
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: qty > 1 ? IconColorStyles.iconColor() : NeutralColorStyles.neutral04(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          '$qty',
                          style: HeadingTextStyles.headingS(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: product.type != 'Sembako' ? qty == stock ? NeutralColorStyles.neutral03() : NeutralColorStyles.neutral04() : NeutralColorStyles.neutral04(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(product.type != 'Sembako') {
                              if(qty < stock) {
                                stateSetter(() {
                                  qty = qty + 1;
                                });
                              }
                            } else {
                              stateSetter(() {
                                qty = qty + 1;
                              });
                            }
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.add,
                            color: product.type != 'Sembako' ? qty == stock ? NeutralColorStyles.neutral04() : IconColorStyles.iconColor() : IconColorStyles.iconColor(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColorStyles.primaryMain(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Tambah ke Troli',
                                  style: LTextStyles.medium().copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedMenu == 0 ? const Color(0xffff7a15) : Colors.white,
      body: SafeArea(
        child: activeFragment(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 0) {
                          setState(() {
                            selectedMenu = 0;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Beranda',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 1) {
                          setState(() {
                            selectedMenu = 1;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Pencarian',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 2) {
                          setState(() {
                            selectedMenu = 2;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper,
                              color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Transaksi',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 3) {
                          setState(() {
                            selectedMenu = 3;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Profile',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: PrimaryColorStyles.primaryMain(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
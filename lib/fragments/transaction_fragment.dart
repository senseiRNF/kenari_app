import 'package:flutter/material.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TransactionFragment extends StatefulWidget {
  const TransactionFragment({super.key});

  @override
  State<TransactionFragment> createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> {
  int selectedTab = 0;
  int selectedStatus = 0;

  List transactionList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: PrimaryColorStyles.primaryMain(),
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                  ),
                  onTap: (index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Iuran',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pendanaan',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pesanan',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: BorderColorStyles.borderDivider(),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedStatus == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if(selectedStatus != 0) {
                            setState(() {
                              selectedStatus = 0;
                            });
                          }
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Aktif',
                            style: selectedStatus == 0 ? STextStyles.medium() : STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedStatus == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if(selectedStatus != 1) {
                            setState(() {
                              selectedStatus = 1;
                            });
                          }
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Selesai',
                            style: selectedStatus == 1 ? STextStyles.medium() : STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: transactionList.isNotEmpty ?
              ListView() :
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/icon_transaction_empty.png',
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Belum Ada Transaksi',
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk mulai transaksi Iuranmu\nmelalui aplikasi Kenari!',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: ListView(),
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
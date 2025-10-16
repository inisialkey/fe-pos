import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Parent(
    child: Row(
      children: [
        // Left Content
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              padding: EdgeInsets.all(Dimens.space16),
              children: [
                Text(
                  'Configuration',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SpacerV(value: Dimens.space16),
                ListTile(
                  contentPadding: EdgeInsets.all(Dimens.space12),
                  leading: SvgPicture.asset(Images.kelolaDiskon),
                  title: const Text('Kelola Diskon'),
                  subtitle: const Text('Kelola Diskon Pelanggan'),
                  textColor: Theme.of(context).primaryColor,
                  tileColor: currentIndex == 0
                      ? Palette.blueLight
                      : Colors.transparent,
                  onTap: () => indexValue(0),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(Dimens.space12),
                  leading: SvgPicture.asset(Images.kelolaPrinter),
                  title: const Text('Kelola Printer'),
                  subtitle: const Text('Tambah atau Hapus Printer'),
                  textColor: Theme.of(context).primaryColor,
                  tileColor: currentIndex == 1
                      ? Palette.blueLight
                      : Colors.transparent,
                  onTap: () => indexValue(1),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(Dimens.space12),
                  leading: SvgPicture.asset(Images.kelolaPajak),
                  title: const Text('Perhitungan Biaya'),
                  subtitle: const Text('Kelola biaya diluar biaya modal'),
                  textColor: Theme.of(context).primaryColor,
                  tileColor: currentIndex == 2
                      ? Palette.blueLight
                      : Colors.transparent,
                  onTap: () => indexValue(2),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(Dimens.space12),
                  leading: SvgPicture.asset(Images.kelolaPajak),
                  title: const Text('Sinkronisasi Data'),
                  subtitle: const Text('Sinkronisasi data dari dan ke server'),
                  textColor: Theme.of(context).primaryColor,
                  tileColor: currentIndex == 3
                      ? Palette.blueLight
                      : Colors.transparent,
                  onTap: () => indexValue(3),
                ),
              ],
            ),
          ),
        ),

        // Right Content
        Expanded(
          flex: 4,
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Padding(
              padding: EdgeInsets.all(Dimens.space16),
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  DiscountPage(),
                  ManagePrinterPage(),
                  TaxPage(),
                  SyncDataPage(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

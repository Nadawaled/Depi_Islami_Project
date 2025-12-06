import 'package:flutter/material.dart';
import 'package:islamy_app/Ui/Screens/hadeth_datails.dart/hadeth_details.dart';
import 'package:islamy_app/Ui/utils/app_assets.dart';

class Hadeth extends StatelessWidget {
  const Hadeth({super.key});

  static const int totalHadithCount = 50;
  static const double dividerThickness = 3.0;
  static const String hadithTitleText = 'الأحاديث';
  static const String hadithFilePrefix = 'h';
  static const String hadithFileExtension = '.txt';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHeaderImage(),
        _buildDivider(),
        _buildTitle(context),
        _buildDivider(),
        _buildHadithList(context),
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Image.asset(AppAssets.hadethLogo);
  }

  Widget _buildDivider() {
    return const Divider(thickness: dividerThickness);
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      hadithTitleText,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildHadithList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: totalHadithCount,
        itemBuilder: (context, index) => _buildHadithItem(context, index),
      ),
    );
  }

  Widget _buildHadithItem(BuildContext context, int index) {
    final int hadithNumber = index + 1;
    return InkWell(
      onTap: () => _navigateToHadithDetails(context, hadithNumber),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          _getHadithDisplayText(hadithNumber),
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _navigateToHadithDetails(BuildContext context, int hadithNumber) {
    final String fileName = _getHadithFileName(hadithNumber);
    Navigator.pushNamed(
      context,
      HadethDetails.routeName,
      arguments: HadithModel(index: fileName),
    );
  }

  String _getHadithFileName(int hadithNumber) {
    return '$hadithFilePrefix$hadithNumber$hadithFileExtension';
  }

  String _getHadithDisplayText(int hadithNumber) {
    return 'الحديث رقم $hadithNumber';
  }
}

class HadithModel {
  final String index;

  HadithModel({required this.index});

  String get fileName => index;

  int get hadithNumber {
    final String numberStr = index.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numberStr) ?? 0;
  }
}

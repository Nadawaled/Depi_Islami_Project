import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamy_app/Ui/Screens/Tabs/hadeth.dart';
import 'package:islamy_app/Ui/Screens/sura_details/sura_datails.dart';
import 'package:islamy_app/Ui/Widgets/build_app_bar.dart';

class HadethDetails extends StatefulWidget {
  const HadethDetails({super.key});
  static const String routeName = "hadeth";

  @override
  State<HadethDetails> createState() => _HadethDetailsState();
}

class _HadethDetailsState extends State<HadethDetails> {
  static const String loadingMessage = "جاري تحميل الحديث...";
  static const String errorMessage = "حدث خطأ أثناء تحميل الحديث.";
  static const String hadithAssetsPath = "assets/quran/ahadeth/";
  static const double containerBorderRadius = 30.0;
  static const double containerVerticalMargin = 50.0;
  static const double containerHorizontalMargin = 25.0;
  static const double contentPadding = 15.0;

  String hadethContent = loadingMessage;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    final HadithModel hadithModel = _extractHadithModel(context);
    _loadHadethContent(hadithModel.index);

    return Container(
      decoration: BoxDecoration(image: backgroudMethod(context)),
      child: Scaffold(
        appBar: buildAppBar(context: context),
        body: _buildContentContainer(context),
      ),
    );
  }

  HadithModel _extractHadithModel(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as HadithModel;
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      decoration: _getContainerDecoration(context),
      margin: const EdgeInsets.symmetric(
        vertical: containerVerticalMargin,
        horizontal: containerHorizontalMargin,
      ),
      child: _buildContentList(context),
    );
  }

  BoxDecoration _getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(containerBorderRadius),
      color: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Widget _buildContentList(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(contentPadding),
          child: _buildContentText(context),
        ),
      ],
    );
  }

  Widget _buildContentText(BuildContext context) {
    return Text(
      _getDisplayContent(),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  String _getDisplayContent() {
    return isError ? errorMessage : hadethContent;
  }

  void _loadHadethContent(String filename) async {
    if (_isContentAlreadyLoaded()) {
      return;
    }

    try {
      final String content = await _readHadithFile(filename);
      _updateContentState(content);
    } catch (error) {
      _updateErrorState();
    }
  }

  bool _isContentAlreadyLoaded() {
    return hadethContent != loadingMessage && !isError;
  }

  Future<String> _readHadithFile(String filename) async {
    final String fullPath = _buildFilePath(filename);
    return await rootBundle.loadString(fullPath);
  }

  String _buildFilePath(String filename) {
    return '$hadithAssetsPath$filename';
  }

  void _updateContentState(String content) {
    setState(() {
      hadethContent = content;
      isError = false;
    });
  }

  void _updateErrorState() {
    setState(() {
      isError = true;
    });
  }
}

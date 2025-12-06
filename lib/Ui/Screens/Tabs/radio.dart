import 'package:flutter/material.dart';
import 'package:islamy_app/Ui/Screens/sura_details/radio_services.dart';
import 'package:islamy_app/Ui/utils/app_assets.dart';
import 'package:islamy_app/Ui/utils/app_colors.dart';
import 'package:islamy_app/Ui/Models/radio_model.dart';
import 'package:islamy_app/core/helper/api_services.dart';
import 'package:just_audio/just_audio.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  static const double topSpacing = 70.0;
  static const double titleFontSize = 30.0;
  static const double iconSize = 80.0;
  static const double errorPadding = 16.0;
  static const String defaultRadioName = "إذاعة القرآن الكريم";
  static const String radioStationName = 'إذاعة مشاري العفاسي';
  static const String connectionErrorMessage = "تحقق من اتصالك بالإنترنت";

  RadioModel? radioModel;
  bool isLoading = true;
  bool hasError = false;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    _initializeAudioPlayer();
    _loadRadioData();
  }

  @override
  void dispose() {
    _disposeAudioPlayer();
    super.dispose();
  }

  void _initializeAudioPlayer() {
    player = AudioPlayer();
  }

  void _disposeAudioPlayer() {
    player.stop();
    player.dispose();
  }

  Future<void> _loadRadioData() async {
    try {
      final RadioModel? data = await _fetchRadioData();
      if (!mounted) return;
      _updateRadioDataState(data);
    } catch (error) {
      if (!mounted) return;
      _updateErrorState();
    }
  }

  Future<RadioModel?> _fetchRadioData() async {
    return await RadioServices().getRadio();
  }

  void _updateRadioDataState(RadioModel? data) {
    setState(() {
      radioModel = data;
      isLoading = false;
      hasError = false;
    });
  }

  void _updateErrorState() {
    setState(() {
      hasError = true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topSpacing),
        _buildRadioTitle(context),
        _buildRadioImage(),
        _buildStationName(context),
        _buildLoadingIndicator(),
        _buildErrorMessage(),
        _buildPlaybackControls(),
        const Spacer(),
      ],
    );
  }

  Widget _buildRadioTitle(BuildContext context) {
    return Text(
      _getRadioDisplayName(),
      style: _getTitleTextStyle(),
    );
  }

  String _getRadioDisplayName() {
    return radioModel?.name ?? defaultRadioName;
  }

  TextStyle _getTitleTextStyle() {
    return const TextStyle(
      color: Colors.amberAccent,
      fontSize: titleFontSize,
    );
  }

  Widget _buildRadioImage() {
    return Image.asset(AppAssets.radioImage);
  }

  Widget _buildStationName(BuildContext context) {
    return Text(
      radioStationName,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildLoadingIndicator() {
    if (!isLoading) return const SizedBox.shrink();
    return const CircularProgressIndicator();
  }

  Widget _buildErrorMessage() {
    if (!hasError) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(errorPadding),
      child: Text(
        connectionErrorMessage,
        style: const TextStyle(color: AppColors.primaryLightMode),
      ),
    );
  }

  Widget _buildPlaybackControls() {
    if (isLoading || hasError || !_hasValidRadioUrl()) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioPlayButton(
          url: radioModel!.url,
          player: player,
          iconSize: iconSize,
        ),
      ],
    );
  }

  bool _hasValidRadioUrl() {
    return radioModel?.url != null && radioModel!.url.isNotEmpty;
  }
}

class RadioPlayButton extends StatefulWidget {
  const RadioPlayButton({
    required this.url,
    required this.player,
    this.iconSize = 80.0,
    super.key,
  });

  final String url;
  final AudioPlayer player;
  final double iconSize;

  @override
  State<RadioPlayButton> createState() => _RadioPlayButtonState();
}

class _RadioPlayButtonState extends State<RadioPlayButton> {
  static const String noConnectionTitle = "لا يوجد اتصال بالإنترنت";
  static const String playbackErrorTitle = "حدث خطأ أثناء تشغيل الصوت";
  static const Color iconColor = Colors.amberAccent;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    widget.player.playerStateStream.listen((playerState) {
      if (mounted) {
        _updatePlayingState(playerState.playing);
      }
    });
  }

  void _updatePlayingState(bool playing) {
    setState(() {
      isPlaying = playing;
    });
  }

  Future<void> _handlePlayPause() async {
    if (!_isValidUrl()) {
      _showNoConnectionDialog();
      return;
    }

    try {
      await _togglePlayback();
    } catch (error) {
      _showPlaybackErrorDialog(error);
    }
  }

  bool _isValidUrl() {
    return widget.url.isNotEmpty;
  }

  Future<void> _togglePlayback() async {
    if (isPlaying) {
      await _stopPlayback();
    } else {
      await _startPlayback();
    }
  }

  Future<void> _stopPlayback() async {
    await widget.player.stop();
  }

  Future<void> _startPlayback() async {
    await widget.player.setUrl(widget.url);
    await widget.player.play();
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => _buildErrorDialog(
        title: noConnectionTitle,
        content: null,
      ),
    );
  }

  void _showPlaybackErrorDialog(Object error) {
    showDialog(
      context: context,
      builder: (dialogContext) => _buildErrorDialog(
        title: playbackErrorTitle,
        content: error.toString(),
      ),
    );
  }

  Widget _buildErrorDialog({required String title, String? content}) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: AppColors.primaryLightMode),
      ),
      content: content != null ? Text(content) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _handlePlayPause,
      icon: Icon(
        _getPlaybackIcon(),
        size: widget.iconSize,
        color: iconColor,
      ),
    );
  }

  IconData _getPlaybackIcon() {
    return isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled;
  }
}

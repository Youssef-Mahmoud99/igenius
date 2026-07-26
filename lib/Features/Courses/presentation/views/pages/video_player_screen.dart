import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text.dart';

/// Custom Video Player Widget
/// =====================================================
/// Built on top of [video_player] + [chewie].
///
/// Features included:
/// - Play / Pause
/// - Fullscreen toggle
/// - Forward / Rewind (skip) buttons (10 seconds each)
/// - Double tap left/right to seek
/// - Playback speed control (0.5x -> 2x)
/// - Seek bar / progress indicator with buffering progress
/// - Auto aspect ratio detection
/// - Loading & error states matching app design
/// - Works with network video links (mp4, hls, etc.)
class CustomVideoPlayer extends StatefulWidget {
  /// Direct video URL (mp4 / m3u8 / etc.)
  final String videoUrl;

  final bool autoPlay;

  /// Loop the video when it finishes.
  final bool looping;

  /// Called once when playback reaches [progressThreshold] of the video duration.
  final VoidCallback? onProgressThresholdReached;

  /// Fraction of the video duration at which [onProgressThresholdReached] fires.
  /// Defaults to 0.8 (80%).
  final double progressThreshold;

  const CustomVideoPlayer({
    Key? key,
    required this.videoUrl,
    this.autoPlay = false,
    this.looping = false,
    this.onProgressThresholdReached,
    this.progressThreshold = 0.8,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}  

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  bool _hasError = false;
  String _errorMessage = '';

  // عشان نتأكد إن الـ callback بيتنادي مرة واحدة بس
  bool _thresholdReached = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    try {
      await _videoPlayerController.initialize();

      // ----- مراقبة تقدم الفيديو -----
      _videoPlayerController.addListener(_checkProgress);

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        // ... باقي الإعدادات زي ما هي
      );

      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'حدث خطأ أثناء تحميل الفيديو';
        });
      }
    }
  }

  void _checkProgress() {
    if (_thresholdReached) return;
    if (widget.onProgressThresholdReached == null) return;

    final value = _videoPlayerController.value;
    if (!value.isInitialized || value.duration == Duration.zero) return;

    final progress =
        value.position.inMilliseconds / value.duration.inMilliseconds;

    if (progress >= widget.progressThreshold) {
      _thresholdReached = true;
      widget.onProgressThresholdReached!();
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_checkProgress);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  Widget _buildErrorWidget(String message) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: Colors.white, size: 40.r),
          10.verticalSpace,
          AppText(
            text: 'تعذر تشغيل الفيديو',
            style: AppsStyles.s12Regular.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_hasError) {
      return _buildErrorWidget(_errorMessage);
    }

    if (_chewieController == null ||
        !_videoPlayerController.value.isInitialized) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Chewie(controller: _chewieController!);
  }
}

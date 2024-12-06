import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor; // 배경색
  final Image image; // 로고 이미지
  final Duration animationDuration; // 애니메이션 지속 시간 (옵션)
  final Duration stayDuration; // 스플래쉬 화면 표시 시간 (옵션)
  final VoidCallback? onComplete; // 완료 후 실행할 콜백

  const SplashScreen({
    super.key,
    required this.backgroundColor,
    required this.image,
    required this.animationDuration,
    required this.stayDuration,
    this.onComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(widget.stayDuration, () {
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: widget.image
        ),
      ),
    );
  }
}

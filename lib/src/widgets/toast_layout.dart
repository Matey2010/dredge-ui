import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/toast_provider.dart';

class ToastLayout extends StatefulWidget {
  final EdgeInsets? padding;

  const ToastLayout({super.key, this.padding});

  @override
  State<ToastLayout> createState() => _ToastLayoutState();
}

class _ToastLayoutState extends State<ToastLayout>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0.0, 1.0), // Start from bottom (off-screen)
          end: const Offset(0.0, 0.0), // End at normal position
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleToastVisibilityChange(bool isVisible) {
    if (isVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Toast overlay
        Consumer<ToastProvider>(
          builder: (context, toastProvider, child) {
            // Handle animation based on visibility
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _handleToastVisibilityChange(toastProvider.isVisible);
            });

            if (toastProvider.currentToast == null) {
              return const SizedBox.shrink();
            }

            return Positioned(
              left: widget.padding?.left ?? 0,
              right: widget.padding?.right ?? 0,
              bottom: widget.padding?.bottom ?? 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    child: toastProvider.currentToast!,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

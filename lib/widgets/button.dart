import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadingAnimatedButton extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Function() onTap;
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool isLoading; // Add isLoading parameter

  const LoadingAnimatedButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.width = 220,
    this.height = 50,
    this.color = Colors.white,
    this.borderColor = Colors.yellow,
    this.borderRadius = 15.0,
    this.borderWidth = 3.0,
    this.duration = const Duration(milliseconds: 1500),
    this.isLoading = false, // Default to false
  }) : super(key: key);

  @override
  State<LoadingAnimatedButton> createState() => _LoadingAnimatedButtonState();
}

class _LoadingAnimatedButtonState extends State<LoadingAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _updateAnimation();
  }

  @override
  void didUpdateWidget(LoadingAnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation() {
    if (widget.isLoading) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading ? null : widget.onTap, // Disable when loading
      borderRadius: BorderRadius.circular(widget.borderRadius),
      splashColor: widget.isLoading ? Colors.transparent : widget.color,
      child: Opacity(
        opacity: widget.isLoading ? 0.7 : 1.0, // Reduce opacity when loading
        child: CustomPaint(
          painter: LoadingPainter(
            animation: _animationController,
            borderColor: widget.borderColor,
            borderRadius: widget.borderRadius,
            borderWidth: widget.borderWidth,
            color: widget.color,
            isLoading: widget.isLoading, // Pass isLoading to painter
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(5.5),
              child: widget.isLoading
                  ? _buildLoadingIndicator() // Show loading indicator
                  : widget.child, // Show normal child
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final Animation animation;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool isLoading; // Add isLoading parameter

  LoadingPainter({
    required this.animation,
    this.color = Colors.orange,
    this.borderColor = Colors.white,
    this.borderRadius = 15.0,
    this.borderWidth = 3.0,
    this.isLoading = false, // Default to false
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Draw border
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.deflate(1.5), Radius.circular(borderRadius)),
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

    // Only draw the animated gradient when loading
    if (isLoading) {
      final paint = Paint()
        ..shader = SweepGradient(
          colors: [color.withOpacity(.25), color],
          startAngle: 0.0,
          endAngle: vector.radians(180),
          stops: const [.75, 1.0],
          transform: GradientRotation(vector.radians(360.0 * animation.value)),
        ).createShader(rect);

      final path = Path.combine(
        PathOperation.xor,
        Path()..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)),
        ),
        Path()..addRRect(
          RRect.fromRectAndRadius(
            rect.deflate(3.5),
            Radius.circular(borderRadius),
          ),
        ),
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LoadingPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.isLoading != isLoading;
  }
}

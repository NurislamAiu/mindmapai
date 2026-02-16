import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RatingStars extends StatefulWidget {
  final int? rating;
  final ValueChanged<int?> onRatingChanged;
  final int starCount;
  final double size;
  final Color color;
  final Color borderColor;

  const RatingStars({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.starCount = 5,
    this.size = 36,
    this.color = const Color(0xFF818CF8),
    this.borderColor = const Color(0xFFD1D5DB),
  });

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  int? _hoveredRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.starCount, (index) {
        final starValue = index + 1;
        final isSelected = starValue <= (_hoveredRating ?? widget.rating ?? 0);

        return GestureDetector(
          onTap: () => widget.onRatingChanged(starValue),
          onHorizontalDragUpdate: (dragDetails) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final pos = box.globalToLocal(dragDetails.globalPosition);
            // Add some padding to the drag area
            final newRating = ((pos.dx + 8) / (widget.size + 8)).round();
            if (newRating > 0 && newRating <= widget.starCount) {
              widget.onRatingChanged(newRating);
            }
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _hoveredRating = starValue),
            onExit: (_) => setState(() => _hoveredRating = null),
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Animate(
                // Use the isSelected status as a key to trigger the animation
                key: ValueKey(isSelected),
                effects: [
                  if (isSelected)
                    ScaleEffect(
                      duration: 300.ms,
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    ),
                  if (isSelected)
                    ShimmerEffect(
                      delay: 300.ms,
                      duration: 500.ms,
                      color: Colors.white60,
                    ),
                ],
                child: Icon(
                  isSelected ? Icons.star_rounded : Icons.star_border_rounded,
                  color: isSelected ? widget.color : widget.borderColor,
                  size: widget.size,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

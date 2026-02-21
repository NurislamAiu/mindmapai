import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';

class HomeIdeaListItem extends StatefulWidget {
  final Idea idea;
  final int index;

  const HomeIdeaListItem({super.key, required this.idea, required this.index});

  @override
  State<HomeIdeaListItem> createState() => _HomeIdeaListItemState();
}

class _HomeIdeaListItemState extends State<HomeIdeaListItem> with TickerProviderStateMixin {
  late final AnimationController _progressController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAnalyzed = widget.idea.status == IdeaStatus.Analyzed;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: _isHovered ? 4 : 2,
              blurRadius: _isHovered ? 16 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isAnalyzed
                          ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
                          : [Colors.grey.shade300, Colors.grey.shade400],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.idea.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Text(
                              widget.idea.date,
                              style: TextStyle(color: Colors.grey[500], fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.idea.summary,
                          style: TextStyle(color: Colors.grey[600], height: 1.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Completion: ${isAnalyzed ? "100" : "45"}%',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value: _progressController.value *
                                    (isAnalyzed ? 1.0 : 0.45),
                                backgroundColor: Colors.grey.shade100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isAnalyzed ? const Color(0xFF6366F1) : Colors.grey.shade300,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _StatusPill(isAnalyzed: isAnalyzed),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool isAnalyzed;

  const _StatusPill({required this.isAnalyzed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isAnalyzed
              ? [const Color(0xFFEEF2FF), const Color(0xFFF5F3FF)]
              : [Colors.grey.shade50, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAnalyzed ? const Color(0xFFC7D2FE) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAnalyzed ? const Color(0xFF6366F1) : Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isAnalyzed ? 'AI Analyzed' : 'Draft',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: isAnalyzed ? const Color(0xFF4338CA) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

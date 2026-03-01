import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultAppBar extends StatelessWidget {
  final String title;
  final String timestamp;

  const ResultAppBar({
    super.key,
    required this.title,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, size: 20, color: Color(0xFF717182)),
                  SizedBox(width: 8),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 15, color: Color(0xFF717182)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF030213),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF717182),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.history, color: Color(0xFF717182)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.balance, color: Color(0xFF717182)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Color(0xFF717182)),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

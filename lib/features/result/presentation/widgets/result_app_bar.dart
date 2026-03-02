import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:iconsax/iconsax.dart';


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            icon: Icon(Iconsax.arrow_left_2, size: 22, color: Colors.black),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                icon: const Icon(CupertinoIcons.time, color: Color(0xFF717182)),
                onPressed: () {
                  context.push('/version-history');
                },
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.arrow_branch, color: Color(0xFF717182)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.share, color: Color(0xFF717182)),
                onPressed: () {
                  // Create a simple slug from the title for the URL
                  final mapId = title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
                  final shareLink = 'https://mindmapai.app/map/$mapId';
                  Share.share('Check out my mindra and collaborate with me: $shareLink');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

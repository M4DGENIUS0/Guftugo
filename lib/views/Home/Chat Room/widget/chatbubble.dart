import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:intl/intl.dart';

class Chatbubble extends StatelessWidget {
  final bool isCurrent;
  final String content;
  final DateTime time;
  const Chatbubble(
      {super.key,
      this.isCurrent = true,
      required this.content,
      required this.time});

  @override
  Widget build(BuildContext context) {
    final alignment = isCurrent ? Alignment.centerLeft : Alignment.centerRight;
    const radius = Radius.circular(15);
    // DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(time);
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: isCurrent ? colors.green : Colors.grey[200],
            borderRadius: isCurrent
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    topLeft: radius,
                    topRight: radius,
                    bottomRight: radius)
                : const BorderRadius.only(
                    bottomLeft: radius,
                    topLeft: radius,
                    topRight: radius,
                    bottomRight: Radius.circular(0))),
        child: Column(
          crossAxisAlignment:
              isCurrent ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              content,
              style: const TextStyle(color: colors.black),
            ),
            Text(
              formattedTime.toString(),
              style: const TextStyle(color: colors.black, fontSize: 9),
            )
          ],
        ),
      ),
    );
  }
}

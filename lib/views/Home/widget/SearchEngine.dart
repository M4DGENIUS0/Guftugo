import 'package:flutter/material.dart';
import 'package:guftago/config/Colors/colors.dart';

class SearchEngine extends StatelessWidget {
  const SearchEngine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search by Name",
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: colors.green,
                    borderRadius: BorderRadius.circular(6)),
                child: const Icon(
                  Icons.search_rounded,
                  color: colors.black,
                ),
              ),
            ),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

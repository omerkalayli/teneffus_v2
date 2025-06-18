import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatContainer extends StatelessWidget {
  const StatContainer({
    super.key,
    required this.color,
    required this.title,
    required this.totalValue,
    this.disablePadding = false,
    this.value,
    this.isEmpty = false,
  });
  final String? value;
  final Color color;
  final bool isEmpty;
  final String title;
  final int totalValue;
  final bool disablePadding;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
            border: Border.all(width: 2, color: Colors.white),
          ),
          child: Center(
            child: Padding(
              padding:
                  disablePadding ? EdgeInsets.zero : const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Gap(4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      isEmpty ? "Veri yok" : value!,
                      style: TextStyle(fontSize: 12, color: color),
                    ),
                  ),
                  const Gap(4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Çalışılan Kelime",
                          style: TextStyle(fontSize: 12, color: color),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            totalValue.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/constants.dart';

/// This widget is used to select a lesson in the game. It shows a list of items

class CustomDropdown extends HookConsumerWidget {
  const CustomDropdown({
    super.key,
    this.width,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    required this.disabled,
    this.baseColor = textColor,
  });

  final Function(int) onSelected;
  final List<String> items;
  final int selectedIndex;
  final bool disabled;
  final double? width;
  final Color baseColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      child: DropdownMenuTheme(
        key: ValueKey(items.hashCode),
        data: DropdownMenuThemeData(
          textStyle: GoogleFonts.montserrat(
              fontSize: 12,
              color: disabled ? baseColor.withValues(alpha: .5) : baseColor,
              fontWeight: FontWeight.bold),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: baseColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          menuStyle: const MenuStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            visualDensity: VisualDensity.compact,
          ),
        ),
        child: DropdownMenu(
          enabled: !disabled,
          initialSelection: selectedIndex + 1,
          trailingIcon: Icon(
            Icons.arrow_drop_down_rounded,
            color: disabled ? baseColor.withValues(alpha: 0.5) : baseColor,
            size: 30,
          ),
          selectedTrailingIcon: Icon(
            Icons.arrow_drop_up_rounded,
            color: disabled ? baseColor.withValues(alpha: 0.5) : baseColor,
            size: 30,
          ),
          inputDecorationTheme: InputDecorationTheme(
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: baseColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: baseColor.withValues(alpha: .5), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: baseColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(maxHeight: 30),
          ),
          width: width ?? MediaQuery.of(context).size.width / 1.8,
          menuStyle: MenuStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          dropdownMenuEntries: [
            ...List.generate(items.length, (index) {
              return DropdownMenuEntry(
                value: index + 1,
                label: items[index],
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    GoogleFonts.montserrat(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ],
          onSelected: (value) {
            onSelected((value as int) - 1);
          },
        ),
      ),
    );
  }
}

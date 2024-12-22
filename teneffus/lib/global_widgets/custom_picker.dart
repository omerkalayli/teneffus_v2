import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teneffus/global_entities/button_type.dart';
import 'package:teneffus/global_widgets/custom_circular_button.dart';

/// [CustomPicker] is a picker that allows users to select an item from a list of items.
///
/// ### Parameters
/// - [labels]: The list of items to be displayed.
/// - [onSelected]: The function to be called when an item is selected.
/// - [defaultIndex]: The index of the item to be selected by default. Default: null.
/// - [buttonPalette]: The type of the button. Default: blue.

class CustomPicker extends HookConsumerWidget {
  CustomPicker({
    required this.labels,
    required this.onSelected,
    ButtonPalette? buttonPalette,
    this.defaultIndex,
    super.key,
  }) : buttonPalette = buttonPalette ?? ButtonPalette.blue();

  final List<String> labels;
  final Function(int) onSelected;
  final int? defaultIndex;
  final ButtonPalette buttonPalette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(defaultIndex);

    /// If defaultIndex is not null, call onSelected with defaultIndex.
    useEffect(() {
      if (defaultIndex != null) {
        onSelected(defaultIndex!);
      }
      return null;
    }, []);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(labels.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 48,
            height: 56,
            child: CustomCircularButton(
                isSticky: true,
                showForegroundInnerShadow: true,
                buttonPalette: buttonPalette,
                value: index == selectedIndex.value,
                child: Text(labels[index]),
                onPressed: () {
                  onSelected(index);
                  selectedIndex.value = index;
                }),
          ),
        );
      }),
    );
  }
}

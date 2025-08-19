import 'dart:io';
import 'package:alumnos_girasoles/widgets/change_IU.dart';
import 'package:flutter/material.dart';

class CustomRadioButtons extends StatefulWidget {
  final List<String> options;
  final int? initialValue;
  final ValueChanged<int> onChanged;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomRadioButtons({
    super.key,
    required this.options,
    required this.onChanged,
    this.initialValue,
    this.selectedColor = Colors.amberAccent,
    this.unselectedColor = Colors.black,
  });

  @override
  State<CustomRadioButtons> createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons> {
  int? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  Widget _buildButton(String text, int index) {
    final bool isSelected = (value == index);
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
        widget.onChanged(index);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(
          color: isSelected ? widget.selectedColor : widget.unselectedColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? widget.selectedColor : widget.unselectedColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    for (int i = 0; i < widget.options.length; i++) {
      buttons.add(_buildButton(widget.options[i], i));
      if (i < widget.options.length - 1) {
        buttons.add(const SizedBox(width: 10));
      }
    }
    return changeIU(buttons);
  }
}

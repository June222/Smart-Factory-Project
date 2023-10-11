import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final Widget? hint;

  const CustomDropDownButton({
    super.key,
    this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: widget.hint,
      value: widget.value,
      alignment: Alignment.center,
      style: const TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      iconEnabledColor: Colors.white,
      underline: Container(
        color: Colors.white,
        height: 1,
        width: 20,
      ),
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          alignment: Alignment.center,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}

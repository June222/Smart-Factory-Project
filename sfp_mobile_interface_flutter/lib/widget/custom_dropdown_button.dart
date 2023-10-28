import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final String? hint;

  const CustomDropDownButton({
    super.key,
    this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: hint != null
          ? Text(
              hint!,
              style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            )
          : null,
      value: value,
      alignment: Alignment.center,
      style: const TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      iconEnabledColor: Colors.white,
      underline: Container(
        color: Colors.white,
        height: 1,
        width: 20,
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final List<String> listGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    required this.selectedGender,
    required this.listGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.venusMars, size: 20, color: Colors.black54),
              const SizedBox(width: 15),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Gender'),
                  dropdownColor: Colors.white.withOpacity(0.8),
                  iconSize: 30,
                  underline: const SizedBox(),
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  value: selectedGender,
                  onChanged: onChanged,
                  items: listGender
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

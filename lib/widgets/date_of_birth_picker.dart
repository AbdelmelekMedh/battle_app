import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DateOfBirthPicker extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onPressed;

  const DateOfBirthPicker({
    super.key,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text('Date of birth', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              minimumSize: const Size.fromHeight(50),
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.calendarDays, color: Colors.black54, size: 20),
                const SizedBox(width: 15),
                Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate!.toLocal()}'.split(' ')[0],
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

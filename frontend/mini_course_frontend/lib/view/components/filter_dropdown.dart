import 'package:flutter/material.dart';

class FilterDropdown extends StatefulWidget {
  final IconData icon;
  final List<String> items;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const FilterDropdown({
    Key? key,
    required this.icon,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: selectedValue,
      onSelected: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChanged(value);
      },
      itemBuilder: (context) => widget.items.map((item) {
        return PopupMenuItem<String>(
          value: item,
          child: Row(
            children: [
              if (item == selectedValue)
                const Icon(Icons.check, size: 18, color: Colors.blue),
              if (item == selectedValue) const SizedBox(width: 8),
              Text(item),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: Colors.black),
            const SizedBox(width: 6),
            Text(selectedValue,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

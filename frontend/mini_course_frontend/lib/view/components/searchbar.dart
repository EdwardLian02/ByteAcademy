import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;
  final void Function()? onTap;
  final String hintText;

  const MySearchBar({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
        child: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
          onChanged: onChanged,
          onTap: onTap,
          onSubmitted: (_) => onSubmitted?.call(),
        ),
      ),
    );
  }
}

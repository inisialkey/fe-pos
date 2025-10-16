import 'package:flutter/material.dart';
import 'package:pos/core/core.dart';

class SearchF extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final String hintText;

  const SearchF({
    required this.controller,
    super.key,
    this.onChanged,
    this.onTap,
    this.hintText = 'Cari di sini',
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(Dimens.space8),
    ),
    child: TextFormField(
      onTap: onTap,
      readOnly: onTap != null,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        contentPadding: EdgeInsets.all(Dimens.space16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.space8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.space8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

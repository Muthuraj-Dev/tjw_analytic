import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../core/res/colors.dart';

class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String? labelText;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool isRequired;
  final bool isSearchable;

  const CommonDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.isSearchable = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      key: key,
      selectedItem: selectedItem,
      items: (filter, infiniteScrollProps) => items,
      popupProps:
          isSearchable
              ? PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: AppColor.divider,
                        width: 1.5,
                      ),
                    ),
                    hintText: 'Search...',
                  ),
                ),
              )
              : PopupProps.menu(),

      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          fillColor: AppColor.background,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
          labelText: isRequired ? '${labelText ?? ''} *' : labelText,
          hintText: hintText,
          hintStyle:  const TextStyle(color: Colors.black87, fontSize: 18),
          labelStyle: const TextStyle(color: Colors.black45, fontSize: 18),
        ),
      ),

      onChanged: onChanged,
      validator: validator,
    );
  }
}

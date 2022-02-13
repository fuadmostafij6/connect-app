import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class TextfieldDropdown extends StatefulWidget {
  final String? name;
  final String? hinttext;
  final List<String>? items;
  final FormFieldValidator? validator;
  final ValueChanged? onChanged;
  final FormFieldSetter? onSaved;
  final String? selectedItem;
  final String? hint;
  const TextfieldDropdown(
      {Key? key,
      this.name,
      this.hinttext,
      this.items,
      this.onChanged,
      this.onSaved,
      this.selectedItem,
      this.validator,
      this.hint})
      : super(key: key);

  @override
  _TextfieldDropdownState createState() => _TextfieldDropdownState();
}

class _TextfieldDropdownState extends State<TextfieldDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin:
            //     const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Text(
              widget.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
            ),
          ),
          Container(
            height: 40,
            // margin: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownSearch<String>(
              dropdownSearchDecoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                hintText: widget.hinttext,
                hintStyle: TextStyle(fontFamily: 'Kalpurush'),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                // isDense: true,
              ),
              mode: Mode.MENU,
              items: widget.items,
              validator: widget.validator,
              hint: widget.hint,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              selectedItem: widget.selectedItem,
            ),
          ),
        ],
      ),
    );
  }
}

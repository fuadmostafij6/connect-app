import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfromPage extends StatefulWidget {
  final String? name;
  final String? hinttext;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  final bool? obscureText;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  const TextfromPage({
    Key? key,
    this.name,
    this.hinttext,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.obscureText,
    this.controller,
    this.onTap,
    this.onChanged,
    this.enabled,
  }) : super(key: key);

  @override
  _TextfromPageState createState() => _TextfromPageState();
}

class _TextfromPageState extends State<TextfromPage> {
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
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              enabled: widget.enabled,
              controller: widget.controller,
              validator: widget.validator,
              obscureText: widget.obscureText ?? false,
              onSaved: widget.onSaved,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              decoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                hintText: widget.hinttext,
                hintStyle: TextStyle(fontFamily: 'Kalpurush'),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/styles/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText = 'Опиши задачу',
    this.readOnly = false,
    required this.onTap,
    this.task,
  });

  final Task? task;
  final TextEditingController controller;
  final String labelText;
  final bool readOnly;
  final VoidCallback onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final textfieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
      borderSide: const BorderSide(
        color: Styles.orange,
        width: 2,
      ),
    );
    return TextField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      onTap: widget.onTap,
      keyboardType: TextInputType.text,
      maxLines: null,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      cursorRadius: const Radius.circular(90),
      cursorWidth: 3,
      cursorColor: Styles.orange,
      textInputAction: TextInputAction.go,
      style: const TextStyle(
        color: Styles.white,
        fontSize: 20,
      ),
      onChanged: (value) {
        widget.task?.text = value;
      },
      decoration: InputDecoration(
        prefixIcon: widget.readOnly
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Icon(
                  CupertinoIcons.calendar,
                  color: Styles.white.withOpacity(0.7),
                  size: 35,
                ),
              )
            : null,
        hintText: widget.readOnly ? widget.controller.text : null,
        hintStyle: const TextStyle(
          color: Styles.grey06,
          fontSize: 20,
        ),
        contentPadding: const EdgeInsets.all(20),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.readOnly ? null : widget.labelText,
        labelStyle: TextStyle(
          color: Styles.white.withOpacity(0.7),
          fontSize: 20,
        ),
        focusedBorder: widget.readOnly
            ? textfieldBorder.copyWith(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              )
            : textfieldBorder,
        filled: true,
        fillColor: Styles.grey,
        border: textfieldBorder,
      ),
    );
  }
}

import 'package:_iwu_pack/setup/app_textstyles.dart';
import 'package:_iwu_pack/setup/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class WidgetInput extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final int minLines;
  final ValueChanged? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hint;
  final double? width;
  final bool obscureText; // Add this line
  final Color? color;

  const WidgetInput(
      {Key? key,
      this.minLines = 1,
      required this.controller,
      this.label,
      this.onChanged,
      this.validator,
      this.hint,
      this.width,
      this.color,
      this.obscureText = false // And this line
      })
      : super(key: key);

  @override
  State<WidgetInput> createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: w400TextStyle(
              fontSize: 16, color: widget.color ?? hexColor('929497')),
        ),
        const Gap(8),
        Container(
          width: widget.width ?? double.infinity,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            onChanged: widget.onChanged,
            controller: widget.controller,
            minLines: widget.minLines,
            maxLines: widget.minLines,
            style: w300TextStyle(fontSize: 16),
            obscureText: widget.obscureText, // Add this line
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: widget.minLines == 1 ? 0 : 20),
                border: _border,
                hintText: widget.hint,
                enabledBorder: _border,
                focusedBorder: _borderFocus),
          ),
        )
      ],
    );
  }

  InputBorder get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(width: 1, color: hexColor('929497')));

  InputBorder get _borderFocus => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(width: 1.2, color: Colors.blue));
}

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.hasFocus,
    required this.node,
    required this.controller,
    required this.label,
    required this.error,
    this.borderRadius,
  });

  final String label;
  final String error;
  final bool hasFocus;
  final FocusNode node;
  final TextEditingController controller;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        border: Border.all(
          color: hasFocus ? Colors.blue : Colors.white,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label),
              const Gap(24),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
          TextFormField(
            controller: controller,
            focusNode: node,
            decoration: const InputDecoration(
              errorText: null,
              border: InputBorder.none,
            ),
          )
        ],
      ),
    );
  }
}

class FormInput {
  String pageName;
  String fullName;
  String email;
  String phone;
  String? cap1;
  String? cap2;
  String ip;

  FormInput(
      {required this.pageName,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.ip,
      this.cap1,
      this.cap2});
}

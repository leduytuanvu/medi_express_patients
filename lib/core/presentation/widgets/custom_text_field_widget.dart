import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';

enum TextFieldType { text, password, phone, gmail, dateTime }

class CustomTextFieldWidget extends StatefulWidget {
  final String labelText;
  final double borderRadius;
  final TextEditingController controller;
  final TextFieldType type;
  final bool showClearText;
  final RxString? errorText;

  const CustomTextFieldWidget({
    super.key,
    required this.labelText,
    this.borderRadius = 8.0,
    required this.controller,
    this.type = TextFieldType.text,
    this.showClearText = false,
    this.errorText,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = false;
  String _value = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.type == TextFieldType.password) {
      _obscureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type != TextFieldType.dateTime) {
          _focusNode.requestFocus(); // Request focus when tapped
        } else {
          _selectDate(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          widget.labelText,
                          style: AppTextStyle.mediumHint(context),
                        ),
                        context.hp(0.6).sbh,
                        SizedBox(
                          height: context.hp(2.8),
                          child: _buildTextField(context),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildSuffixIcon(),
              ],
            ),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: context.hp(0.6)),
              child: Text(
                widget.errorText!.value,
                style: AppTextStyle.mediumError(context),
              ),
            ),
          context.hp(1.4).sbh,
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    switch (widget.type) {
      case TextFieldType.password:
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          obscureText: _obscureText,
          cursorColor: Colors.black,
          style: AppTextStyle.mediumBody(context),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(right: context.wp(3)),
          ),
        );
      case TextFieldType.phone:
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          keyboardType: TextInputType.phone,
          cursorColor: Colors.black,
          style: AppTextStyle.mediumBody(context),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(right: context.wp(3)),
          ),
        );
      case TextFieldType.gmail:
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          style: AppTextStyle.mediumBody(context),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(right: context.wp(3)),
          ),
        );
      case TextFieldType.dateTime:
        return AbsorbPointer(
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onTap: () {
              _selectDate(context);
            },
            cursorColor: Colors.black,
            style: AppTextStyle.mediumBody(context),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(right: context.wp(3)),
            ),
          ),
        );
      default:
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          keyboardType: TextInputType.text,
          cursorColor: Colors.black,
          style: AppTextStyle.mediumBody(context),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(right: context.wp(3)),
          ),
        );
    }
  }

  Widget _buildSuffixIcon() {
    switch (widget.type) {
      case TextFieldType.password:
        return IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF9CA4B0),
            size: context.wp(6),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        );
      case TextFieldType.dateTime:
        return IconButton(
          icon: Icon(
            Icons.calendar_today_rounded,
            color: const Color(0xFF9CA4B0),
            size: context.wp(6),
          ),
          onPressed: () {
            _selectDate(context);
          },
        );
      default:
        return widget.showClearText && _value.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF9CA4B0),
                ),
                onPressed: () {
                  setState(() {
                    _value = '';
                    widget.controller.clear();
                  });
                },
              )
            : const SizedBox.shrink();
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        final String formattedDate =
            DateFormat('dd/MM/yyyy').format(pickedDate);
        widget.controller.text = formattedDate;
        Log.info("pickedDate: $formattedDate");
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? labelText;
  final bool? isTitle;
  final Widget? suffixIcon;
  final bool obscureText;
  final isPasswordVisibilityEnable;
  final int maxLength;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final Function(String? string)? onChanged;
  final String? Function(String? string)? validator;
  final TextStyle? textStyle;
  final bool? isDense;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? filled;
  final Color? fillColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final int? minLines;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final double? height, width;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? errorStyle;
  final String? hintText;
  final bool? alignLabelWithHint;
  final double borderRadius;
  final Color? borderColor;

  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.isTitle = false,
    this.labelText,
    this.suffixIcon,
    this.isPasswordVisibilityEnable = false,
    this.obscureText = false,
    this.maxLength = 10,
    this.height,
    this.width,
    this.onChanged,
    this.textStyle,
    this.onFieldSubmitted,
    this.decoration,
    this.focusNode,
    this.validator,
    this.controller,
    this.isDense,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.filled = false,
    this.fillColor = Colors.transparent,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.minLines,
    this.maxLines = 1,
    this.enabled,
    this.onTap,
    this.readOnly = false,
    this.contentPadding,
    this.autoValidateMode,
    this.hintText,
    this.errorStyle = const TextStyle(color: Colors.red),
    this.textAlignVertical = TextAlignVertical.center,
    this.alignLabelWithHint,
    this.borderRadius = 10.0,
    this.borderColor,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return textFormField();
  }

  Widget textFormField() {
    var textFormField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height != null ? widget.height : 60,
          width: widget.width != null
              ? widget.width!
              : MediaQuery.of(context).size.width,
          child: TextField(
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            style: widget.textStyle ?? const TextStyle(
                color: Colors.black,
                fontSize:16,
                fontWeight: FontWeight.w500),
            focusNode: widget.focusNode,
            controller: widget.controller,
            maxLength: widget.maxLength,
            obscureText: obscureText!,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            decoration: widget.decoration ??
                InputDecoration(
                  counterText: "",
                  border:  const OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white)),
                  labelText: widget.labelText,
                  labelStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize:16),
                  prefixText: '',
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(
                          vertical:8, horizontal: 8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                        width: 1,
                        color: widget.borderColor != null
                            ? widget.borderColor!
                            : Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  suffixIcon: widget.suffixIcon == null &&
                          widget.isPasswordVisibilityEnable
                      ? IconButton(
                          enableFeedback: true,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            obscureText ?? false
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_sharp,
                            color: Colors.grey,
                            size: 24,
                          ),
                          onPressed: () {
                            obscureText = !obscureText!;
                            setState(() {});
                          },
                        )
                      : null,
                ),
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
    );
    return textFormField;
  }
}

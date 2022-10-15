import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final double? width;
  final double? height;
  final TextStyle? style;
  const CustomButton({required this.text,this.width,this.height,this.style, required this.onPressed, Key? key})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width != null ?widget.width : 100,
      height: widget.height != null ?widget.height : 30,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: widget.onPressed,
        child: Text(widget.text,style: widget.style != null ? widget.style : const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black54),),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}

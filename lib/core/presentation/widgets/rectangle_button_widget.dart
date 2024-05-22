import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectangleButtonWidget extends StatefulWidget {
  final double height;
  final double? width;
  final Color fillColor;
  final Color? borderColor;
  final Color? textColor;
  final String? text;
  final TextStyle? textStyle;
  final Function onPress;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final bool roundedCorners, isDisabled;
  final Widget? rightIcon, leftIcon;
  const RectangleButtonWidget(
      {super.key,
      this.height = 40,
      this.width,
      required this.fillColor,
      this.text,
      this.textStyle,
      required this.onPress,
      this.padding,
      this.boxShadow,
      this.borderColor,
      this.textColor,
      this.roundedCorners = true,
      this.rightIcon,
      this.leftIcon,
      this.isDisabled = false});

  @override
  RectangleButtonWidgetState createState() => RectangleButtonWidgetState();
}

class RectangleButtonWidgetState extends State<RectangleButtonWidget> {
  Color color = Colors.white;
  @override
  void initState() {
    color = widget.fillColor;
    super.initState();
  }

  @override
  didUpdateWidget(RectangleButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fillColor != widget.fillColor) {
      setState(() {
        color = widget.fillColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(widget.roundedCorners ? 12 : 0),
        color: Colors.transparent,
        child: GestureDetector(
            onTapDown: (x) {
              if (!widget.isDisabled) {
                setState(() {
                  color = color.withOpacity(0.5);
                });
              }
            },
            onTapUp: (x) {
              if (!widget.isDisabled) {
                Future.delayed((const Duration(milliseconds: 200)), () {
                  setState(() {
                    color = color.withOpacity(1);
                    widget.onPress();
                  });
                });
              }
            },
            onTapCancel: () {
              if (!widget.isDisabled) {
                setState(() {
                  color = color.withOpacity(1);
                });
              }
            },
            key: widget.key,
            child: Container(
                alignment: Alignment.center,
                padding: widget.padding ?? const EdgeInsets.all(0),
                height: widget.padding == null ? widget.height : null,
                width: widget.padding == null ? widget.width : null,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.roundedCorners ? 12 : 0),
                    color: color.withOpacity(widget.isDisabled ? 0.5 : 1),
                    border: widget.borderColor != null ? Border.all(color: widget.borderColor!, width: 1) : null,
                    boxShadow: widget.boxShadow),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.leftIcon != null)
                      Container(
                        margin: widget.text != null ? EdgeInsetsDirectional.only(end: 8.w) : null,
                        child: widget.leftIcon,
                      ),
                    if (widget.text != null)
                      Text(
                        widget.text!,
                        style: widget.textStyle ??
                            TextStyle(
                                color: widget.textColor?.withOpacity(widget.isDisabled ? 0.38 : 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    if (widget.rightIcon != null)
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 8.w),
                        child: widget.rightIcon,
                      )
                  ],
                ))));
  }
}

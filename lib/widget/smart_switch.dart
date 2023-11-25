import 'package:flutter/material.dart';

class SmartSwitch extends StatefulWidget {
  final SwitchSize size;
  final Color? activeColor;
  final Color? inActiveColor;
  final bool disabled;
  final bool defaultActive;
  final Function(bool)? onChanged;

  final String offText;
  final String onText;

  const SmartSwitch({
    Key? key,
    this.size = SwitchSize.small,
    this.inActiveColor,
    this.activeColor,
    this.disabled = false,
    this.defaultActive = true,
    this.onChanged,
    this.offText = "OFF",
    this.onText = "ON",
  }) : super(key: key);

  @override
  State<SmartSwitch> createState() => _SmartSwitchState();
}

class _SmartSwitchState extends State<SmartSwitch> {
  bool _active = true;
  double _y = -0.4;
  double _opacity = 0.0;

  @override
  void initState() {
    _active = widget.defaultActive;
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _y = 0;
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width *
        0.24 *
        (widget.size == SwitchSize.small
            ? 0.9
            : widget.size == SwitchSize.medium
                ? 1
                : 1.1);
    final height = 40.0 *
        (widget.size == SwitchSize.small
            ? 0.9
            : widget.size == SwitchSize.medium
                ? 1
                : 1.1);

    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1000),
      child: AnimatedSlide(
        offset: Offset(0, _y),
        duration: const Duration(milliseconds: 1000),
        child: GestureDetector(
          onTap: () {
            if (widget.disabled) {
              return;
            }
            setState(() {
              _active = !_active;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(_active);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.disabled
                    ? Colors.grey
                    : _active
                        ? widget.activeColor ?? Theme.of(context).primaryColor
                        : widget.inActiveColor ?? Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ]),
            width: width,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.offText,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(),
                      Text(
                        widget.onText,
                        textAlign: TextAlign.end,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment:
                      _active ? Alignment.centerLeft : Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: double.infinity,
                    width: width / 1.7,
                    child: Card(
                        color: Colors.white.withOpacity(0.5),
                        clipBehavior: Clip.none,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum SwitchSize { small, medium, large }

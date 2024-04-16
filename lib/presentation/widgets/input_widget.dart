import 'package:beta/configs/style.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? error;
  const InputWidget(
      {super.key,
      required this.label,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      required this.controller,
      this.inputFormatters,
      this.validator,
      this.error});
  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return OpacityAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: halfMargin,
          ),
          TextFormField(
            validator: widget.validator,
            obscureText: widget.obscureText && !showPassword,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              errorText: widget.error,
              suffixIcon: widget.obscureText
                  ? (showPassword
                      ? GestureDetector(
                          onTap: () => setState(() {
                            showPassword = false;
                          }),
                          child: Icon(Icons.remove_red_eye,
                              color: Theme.of(context).primaryColor),
                        )
                      : GestureDetector(
                          onTap: () => setState(() {
                            showPassword = true;
                          }),
                          child: Icon(Icons.remove_red_eye_outlined,
                              color: Theme.of(context).primaryColor),
                        ))
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: margin),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorLight)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
          ),
          const SizedBox(
            height: doubleMargin,
          ),
        ],
      ),
    );
  }
}

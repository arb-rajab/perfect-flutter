import 'package:beta/configs/colors.dart';
import 'package:beta/configs/style.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function onSubmit;
  final bool loading;
  final Color color;
  static ValueKey loadingKey = const ValueKey('loading');

  static Type buttonType = ElevatedButton;
  static Type loadingType = CircularProgressIndicator;

  const SubmitButton(
      {super.key,
      this.loading = false,
      required this.text,
      this.color = primaryColor,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.only(top: halfMargin, left: halfMargin),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: const Border(
              bottom: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            )),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 60,
          onPressed: () {
            if (!loading) onSubmit.call();
          },
          color: color,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: [
              if (loading)
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              const Spacer(),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

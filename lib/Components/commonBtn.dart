import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CommonButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 35, 218, 87),
            Color.fromARGB(255, 42, 221, 167),
          ]),
          borderRadius: BorderRadius.circular(37),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: size.height * 0.060,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 35, 218, 87),
              Color.fromARGB(255, 42, 221, 167),
            ]),
            borderRadius: BorderRadius.circular(37),
          ),
          child: const Text("Continue",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}

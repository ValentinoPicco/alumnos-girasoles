import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  final String element;
  final VoidCallback onTap;

  const ButtonCard({super.key, required this.element, required this.onTap});

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isHovered ? 0 : 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 255, 234, 49),
              Color.fromARGB(255, 255, 209, 43),
              Colors.amber,
              Color.fromARGB(255, 255, 153, 0),
              Color.fromARGB(255, 255, 145, 0),
            ],
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          onHover: (value) {
            setState(() {
              isHovered = value;
            });
          },
          splashColor: Colors.white.withValues(alpha: 0.3),
          child: SizedBox(
            width: 270,
            height: 150,
            child: Center(
              child: Text(
                widget.element.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

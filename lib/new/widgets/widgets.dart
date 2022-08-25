import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            heading,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  final double fontSize = 20;
  @override
  Widget build(BuildContext context) => Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            content,
            maxLines: 10,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
}

class TitleParagraph extends StatelessWidget {
  const TitleParagraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            content,
            maxLines: 4,
            softWrap: true,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.green)),
        onPressed: onPressed,
        child: child,
      );
}

import 'package:flutter/material.dart';

class BuildFilterChips extends StatefulWidget {
  BuildFilterChips({
    Key? key,
    required this.options,
    required this.selections,
  }) : super(key: key);

  final List<String> options;
  List<bool> selections;
  @override
  State<BuildFilterChips> createState() => _BuildFilterChipsState();
}

class _BuildFilterChipsState extends State<BuildFilterChips> {
  @override
  Widget build(BuildContext context) {
    List<Widget> chips = [];

    for (int i = 0; i < widget.options.length; i++) {
      FilterChip filterChip = FilterChip(
        selected: widget.selections[i],
        label: Text(widget.options[i], style: TextStyle(color: Colors.white)),
        //avatar: const FlutterLogo(),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          setState(() {
            widget.selections[i] = selected;
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), child: filterChip));
    }

    return Wrap(
      children: chips,
    );
  }
}

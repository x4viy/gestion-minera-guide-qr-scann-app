import 'package:flutter/material.dart';

class PersonDetail extends StatelessWidget {
  final String label;
  final IconData icon;
  final String text;
  final double width;

  const PersonDetail(
      {super.key,
      required this.label,
      required this.icon,
      required this.text,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_icon(icon), Expanded(child: _details(label, text))],
      ),
    );
  }
}

_icon(IconData icon) {
  return Icon(
    icon,
    size: 30,
  );
}

_details(String label, String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}

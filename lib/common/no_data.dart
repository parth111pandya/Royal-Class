import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  String? text;

  NoDataFound({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Text(
        text != null ? text.toString() : 'No Data Found',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ServerStatusDot extends StatelessWidget {
  final bool isOnline;

  const ServerStatusDot({Key? key, this.isOnline = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _diameter = 12;
    return Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: this.isOnline ? Colors.green : Colors.red,
      ),
    );
  }
}

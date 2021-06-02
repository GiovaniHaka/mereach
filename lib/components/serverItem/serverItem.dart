import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mereach/components/serverItem/serverStatusDot.dart';
import 'package:mereach/models/server.dart';
import 'package:mereach/utils/testConnectionServer.dart';
import 'package:mereach/utils/translateDateTime.dart';

class ServerItem extends StatefulWidget {
  final Server server;
  final Function() onDelete;

  const ServerItem({
    Key? key,
    required this.server,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ServerItemState createState() => _ServerItemState();
}

class _ServerItemState extends State<ServerItem> {
  bool isOnline = false;
  DateTime updatedAt = DateTime.parse("0000-00-00 00:00:00Z");

  Timer? timer;

  // Simulate
  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 2),
      (timer) async {
        bool status = await testServerConnection(this.widget.server.url);
        if (mounted) {
          setState(() {
            isOnline = status;
            updatedAt = DateTime.now().toLocal();
          });
          print('Update: ${DateTime.now()}, status: $status');
        }
        if(!mounted) dispose();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose server');
    timer!.cancel();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ServerStatusDot(
                isOnline: isOnline,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.widget.server.url),
                  Text(translateDateTime(updatedAt)),
                  Text(isOnline ? 'Online' : 'Offline'),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_rounded),
            onPressed: this.widget.onDelete,
          ),
        ],
      ),
    );
  }
}

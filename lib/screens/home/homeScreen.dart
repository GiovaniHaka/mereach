import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mereach/components/serverItem/serverItem.dart';
import 'package:mereach/controllers/serverController.dart';
import 'package:mereach/screens/home/components/modalBottomSheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ServersController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MeReach',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                openModalBottomSheeet(context);
              },
              child: Row(
                children: [
                  Text('new server'),
                  Icon(Icons.add_rounded),
                ],
              ),
            )
          ],
        ),
        body: GetX<ServersController>(
          builder: (controller) {
            return controller.servers.isEmpty
                ? Center(
                    child: Text(
                    'Sem dados...\nAdicione um servidor!',
                    textAlign: TextAlign.center,
                  ))
                : RefreshIndicator(
                    onRefresh: () async => await controller.fetchServers(),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ServerItem(
                          key: UniqueKey(),
                          server: controller.servers[index],
                          onDelete: () async {
                            controller
                                .deleteServer(controller.servers[index].id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.servers.length,
                    ),
                  );
          },
        ));
  }
}

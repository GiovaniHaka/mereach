import 'package:get/get.dart';
import 'package:mereach/models/server.dart';
import 'package:mereach/services/localDatabase.dart';

class ServersController extends GetxController {
  List<Server> servers = <Server>[].obs;

  fetchServers() async {
    var result = await LocalDatabase().getServers();

    List<Server> serversResult = [];
    result.forEach((element) async {
      serversResult.add(
        Server(
          id: element['id'],
          url: element['url'],
          updatedAt: DateTime.parse(element['updatedAt']),
        ),
      );
    });

    servers.assignAll(serversResult);
    print(servers);
  }

  // Simulate
  @override
  void onInit() {
    fetchServers();
    super.onInit();
    // newPet = null;
  }

  // Similar to dispose
  void onClose() {
    super.onClose();
  }

  insertServer(String url) async {
    await LocalDatabase().insertServer(url);
    fetchServers();
  }

  deleteServer(int id) async {
    await LocalDatabase().deleteServer(id).then((value) => fetchServers());
  }
}

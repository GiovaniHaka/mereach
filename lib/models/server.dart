class Server {
  int id;
  String url;
  DateTime updatedAt;
  
  Server({
    required this.id,
    required this.url,
    required this.updatedAt,
  });



  @override
  String toString() => 'Server(id: $id, url: $url, updatedAt: $updatedAt)';
}

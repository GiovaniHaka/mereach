String translateDateTime(DateTime date){
  String result = '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}:${date.second}';
  return result;
}
String pathFromFireStoreDocumentName(String path) {
  final newPath = '/' + path.split('/').sublist(4).join('/');
  return newPath;
}

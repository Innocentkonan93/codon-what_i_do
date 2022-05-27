import 'package:zoknot/data/Models/Note.dart';
import 'package:zoknot/data/Services/NetworkService.dart';

class Repository {

  final NetworkService networkService;

  Repository({required this.networkService});
  
  Future<void> fetchNotesData() async {
    final noteRaw = await networkService.fetchNotes();
    // print(noteRaw);
    // return noteRaw.map((e) => Note.fromJson(e)).toList();
  }
}

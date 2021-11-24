// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart';

class NetworkService{

  final baseURl = "http://localhost:3000";


  
  Future<List<dynamic>> fetchNotes() async{
    try {
      final response =await get(Uri.parse(baseURl+"/notes"));
      return jsonDecode(response.body);
    }  catch (e) {
      return [];
    }
  }

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walpaper/models/photo_model.dart';

class ApiOperation{
 static Future<List<photo_model>>  get() async{
  final response=  await http.get(Uri.parse('https://api.pexels.com/v1/curated'),
  headers: {'Authorization':'UKeNzt1zo67IhiYS0SRI5htN2hkam7I7J404VIy1qkcJr2pEUgpj6tb9'});

  if(response.statusCode==200){
     final jsonData=jsonDecode(response.body);
     final List<dynamic> photosData = jsonData['photos'];
      List<photo_model> photos_model=photosData.map((e) => photo_model.fromJson(e)).toList();
     return photos_model;
  }else{
    throw Exception('fail to load data: ${response.statusCode}');
  }
  }

  static Future<List<photo_model>>  search_query(String query) async{
  final response=  await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=75'),
  headers: {'Authorization':'UKeNzt1zo67IhiYS0SRI5htN2hkam7I7J404VIy1qkcJr2pEUgpj6tb9'});

  if(response.statusCode==200){
     final jsonData=jsonDecode(response.body);
     final List<dynamic> photosData = jsonData['photos'];
      List<photo_model> photos_model=photosData.map((e) => photo_model.fromJson(e)).toList();
     return photos_model;
  }else{
    throw Exception('fail to load data: ${response.statusCode}');
  }
  }
}
import 'package:flutter_riverpod_implimentation/apis/album.dart';
import 'package:flutter_riverpod_implimentation/apis/api_provider.dart';

class AlbumAPIProvider extends APIProvider {
  @override
  String get apiUrl => '/albums';
  static AlbumAPIProvider? _instance;
  late List<Album> albumList = [];

  AlbumAPIProvider._internal();
  factory AlbumAPIProvider() {
    return _instance ??= AlbumAPIProvider._internal();
  }
  Future<List<Album>> fetchAlbums()async{
    var result=await fetch() as List;
    albumList=result.map((e) => Album.fromMap(e)).toList();
    return albumList;
  }
}

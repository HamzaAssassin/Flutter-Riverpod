import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_implimentation/apis/album_api_provider.dart';
import 'package:flutter_riverpod_implimentation/riverpod/album_states.dart';

class AlbumNotifier extends StateNotifier<AlbumState> {
  AlbumNotifier() : super(AlbumInitialState());
  final AlbumAPIProvider _albumAPIProvider = AlbumAPIProvider();
  fetchAlbums() async {
    state = AlbumLoadingState();
    try {
      final albumList =await _albumAPIProvider.fetchAlbums();
      state=AlbumLoadedState(albumList: albumList);
    } catch (e) {
      state = AlbumErrorState(error: e.toString());
    }
  }
}

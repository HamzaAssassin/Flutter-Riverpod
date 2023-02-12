import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_implimentation/riverpod/album_notifier.dart';
import 'package:flutter_riverpod_implimentation/riverpod/album_states.dart';

final albumProvider = StateNotifierProvider<AlbumNotifier, AlbumState>((ref) {
  return AlbumNotifier();
});

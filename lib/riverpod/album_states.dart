import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_implimentation/apis/album.dart';

@immutable
abstract class AlbumState extends Equatable {
  @override
  List<Object?> get props => [];
}
@immutable
class AlbumInitialState extends AlbumState{
  
}
@immutable
class AlbumLoadingState extends AlbumState {}

@immutable
class AlbumLoadedState extends AlbumState {
  final List<Album> albumList;
  AlbumLoadedState({required this.albumList});
  @override
  List<Object?> get props => [albumList];
}

@immutable
class AlbumErrorState extends AlbumState {
  final String error;
  AlbumErrorState({required this.error});
  @override
  
  List<Object?> get props => [error];
}

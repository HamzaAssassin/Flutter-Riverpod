import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_implimentation/apis/album.dart';
import 'package:flutter_riverpod_implimentation/riverpod/album_states.dart';
import 'package:flutter_riverpod_implimentation/riverpod/provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Riverpod'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumState = ref.watch(albumProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Builder(
        builder: (context) {
          if (albumState is AlbumInitialState) {
            return const AlbumInitialWidget();
          } else if (albumState is AlbumLoadingState) {
            return const AlbumLoadingWidget();
          } else if (albumState is AlbumLoadedState) {
            return AlbumLoadedWidget(list: albumState.albumList);
          } else {
            return AlbumErrorWidget(
                error: (albumState as AlbumErrorState).error);
          }
        },
      ),
    );
  }
}

class AlbumLoadedWidget extends ConsumerWidget {
  const AlbumLoadedWidget({required this.list, super.key});
  final List<Album> list;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                list[index].id.toString(),
              ),
            ),
            title: Text(list[index].title),
          );
        },
      ),
    );
  }
}

class AlbumLoadingWidget extends ConsumerWidget {
  const AlbumLoadingWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }
}

class AlbumInitialWidget extends ConsumerWidget {
  const AlbumInitialWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Click Fetch Button to Load Data"),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(albumProvider.notifier).fetchAlbums();
              },
              child: const Text("Fetch Albums")),
        ],
      ),
    );
  }
}

class AlbumErrorWidget extends ConsumerWidget {
  const AlbumErrorWidget({required this.error, super.key});
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

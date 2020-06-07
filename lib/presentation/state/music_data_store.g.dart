// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MusicDataStore on _MusicDataStore, Store {
  final _$albumsFutureAtom = Atom(name: '_MusicDataStore.albumsFuture');

  @override
  ObservableFuture<List<Album>> get albumsFuture {
    _$albumsFutureAtom.context.enforceReadPolicy(_$albumsFutureAtom);
    _$albumsFutureAtom.reportObserved();
    return super.albumsFuture;
  }

  @override
  set albumsFuture(ObservableFuture<List<Album>> value) {
    _$albumsFutureAtom.context.conditionallyRunInAction(() {
      super.albumsFuture = value;
      _$albumsFutureAtom.reportChanged();
    }, _$albumsFutureAtom, name: '${_$albumsFutureAtom.name}_set');
  }

  final _$songsAtom = Atom(name: '_MusicDataStore.songs');

  @override
  ObservableList<Song> get songs {
    _$songsAtom.context.enforceReadPolicy(_$songsAtom);
    _$songsAtom.reportObserved();
    return super.songs;
  }

  @override
  set songs(ObservableList<Song> value) {
    _$songsAtom.context.conditionallyRunInAction(() {
      super.songs = value;
      _$songsAtom.reportChanged();
    }, _$songsAtom, name: '${_$songsAtom.name}_set');
  }

  final _$isFetchingSongsAtom = Atom(name: '_MusicDataStore.isFetchingSongs');

  @override
  bool get isFetchingSongs {
    _$isFetchingSongsAtom.context.enforceReadPolicy(_$isFetchingSongsAtom);
    _$isFetchingSongsAtom.reportObserved();
    return super.isFetchingSongs;
  }

  @override
  set isFetchingSongs(bool value) {
    _$isFetchingSongsAtom.context.conditionallyRunInAction(() {
      super.isFetchingSongs = value;
      _$isFetchingSongsAtom.reportChanged();
    }, _$isFetchingSongsAtom, name: '${_$isFetchingSongsAtom.name}_set');
  }

  final _$isUpdatingDatabaseAtom =
      Atom(name: '_MusicDataStore.isUpdatingDatabase');

  @override
  bool get isUpdatingDatabase {
    _$isUpdatingDatabaseAtom.context
        .enforceReadPolicy(_$isUpdatingDatabaseAtom);
    _$isUpdatingDatabaseAtom.reportObserved();
    return super.isUpdatingDatabase;
  }

  @override
  set isUpdatingDatabase(bool value) {
    _$isUpdatingDatabaseAtom.context.conditionallyRunInAction(() {
      super.isUpdatingDatabase = value;
      _$isUpdatingDatabaseAtom.reportChanged();
    }, _$isUpdatingDatabaseAtom, name: '${_$isUpdatingDatabaseAtom.name}_set');
  }

  final _$albumSongsAtom = Atom(name: '_MusicDataStore.albumSongs');

  @override
  ObservableList<Song> get albumSongs {
    _$albumSongsAtom.context.enforceReadPolicy(_$albumSongsAtom);
    _$albumSongsAtom.reportObserved();
    return super.albumSongs;
  }

  @override
  set albumSongs(ObservableList<Song> value) {
    _$albumSongsAtom.context.conditionallyRunInAction(() {
      super.albumSongs = value;
      _$albumSongsAtom.reportChanged();
    }, _$albumSongsAtom, name: '${_$albumSongsAtom.name}_set');
  }

  final _$updateDatabaseAsyncAction = AsyncAction('updateDatabase');

  @override
  Future<void> updateDatabase() {
    return _$updateDatabaseAsyncAction.run(() => super.updateDatabase());
  }

  final _$fetchAlbumsAsyncAction = AsyncAction('fetchAlbums');

  @override
  Future<void> fetchAlbums() {
    return _$fetchAlbumsAsyncAction.run(() => super.fetchAlbums());
  }

  final _$fetchSongsAsyncAction = AsyncAction('fetchSongs');

  @override
  Future<void> fetchSongs() {
    return _$fetchSongsAsyncAction.run(() => super.fetchSongs());
  }

  final _$fetchSongsFromAlbumAsyncAction = AsyncAction('fetchSongsFromAlbum');

  @override
  Future<void> fetchSongsFromAlbum(Album album) {
    return _$fetchSongsFromAlbumAsyncAction
        .run(() => super.fetchSongsFromAlbum(album));
  }

  final _$_MusicDataStoreActionController =
      ActionController(name: '_MusicDataStore');

  @override
  void init() {
    final _$actionInfo = _$_MusicDataStoreActionController.startAction();
    try {
      return super.init();
    } finally {
      _$_MusicDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'albumsFuture: ${albumsFuture.toString()},songs: ${songs.toString()},isFetchingSongs: ${isFetchingSongs.toString()},isUpdatingDatabase: ${isUpdatingDatabase.toString()},albumSongs: ${albumSongs.toString()}';
    return '{$string}';
  }
}
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_data_modifier_repository.dart';
import '../../domain/repositories/music_data_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/inrement_like_count.dart';
import '../../domain/usecases/set_song_blocked.dart';
import '../../domain/usecases/update_database.dart';

part 'music_data_store.g.dart';

class MusicDataStore extends _MusicDataStore with _$MusicDataStore {
  MusicDataStore({
    @required MusicDataInfoRepository musicDataInfoRepository,
    @required MusicDataModifierRepository musicDataModifierRepository,
    @required SettingsRepository settingsRepository,
    @required UpdateDatabase updateDatabase,
    @required IncrementLikeCount incrementLikeCount,
    @required SetSongBlocked setSongBlocked,
  }) : super(
          musicDataInfoRepository,
          settingsRepository,
          musicDataModifierRepository,
          updateDatabase,
          incrementLikeCount,
          setSongBlocked,
        );
}

abstract class _MusicDataStore with Store {
  _MusicDataStore(
    this._musicDataInfoRepository,
    this._settingsRepository,
    this._musicDataModifierRepository,
    this._updateDatabase,
    this._incrementLikeCount,
    this._setSongBlocked,
  ) {
    songStream = _musicDataInfoRepository.songStream.asObservable(initialValue: []);
    albumStream = _musicDataInfoRepository.albumStream.asObservable(initialValue: []);
    artistStream = _musicDataInfoRepository.artistStream.asObservable(initialValue: []);
  }

  final IncrementLikeCount _incrementLikeCount;
  final SetSongBlocked _setSongBlocked;
  final UpdateDatabase _updateDatabase;

  final MusicDataInfoRepository _musicDataInfoRepository;
  final MusicDataModifierRepository _musicDataModifierRepository;
  final SettingsRepository _settingsRepository;

  @observable
  ObservableStream<List<Song>> songStream;

  @observable
  ObservableStream<List<Album>> albumStream;

  @observable
  ObservableStream<List<Artist>> artistStream;

  @observable
  bool isUpdatingDatabase = false;

  @action
  Future<void> updateDatabase() async {
    isUpdatingDatabase = true;
    await _updateDatabase();
    isUpdatingDatabase = false;
  }

  Future<void> setSongBlocked(Song song, bool blocked) => _setSongBlocked(song, blocked);

  Future<void> toggleNextSongLink(Song song) async {
    await _musicDataModifierRepository.toggleNextSongLink(song);
  }

  Future<void> incrementLikeCount(Song song) => _incrementLikeCount(song);

  Future<void> resetLikeCount(Song song) => _musicDataModifierRepository.resetLikeCount(song);

  Future<void> addLibraryFolder(String path) async {
    await _settingsRepository.addLibraryFolder(path);
  }
}

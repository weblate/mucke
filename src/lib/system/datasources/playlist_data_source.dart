import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../models/playlist_model.dart';
import '../models/smart_list_model.dart';
import '../models/song_model.dart';

abstract class PlaylistDataSource {
  Stream<List<PlaylistModel>> get playlistsStream;
  Stream<PlaylistModel> getPlaylistStream(int playlistId);
  Future<void> insertPlaylist(
    String name,
    String iconString,
    String gradientString,
    ShuffleMode? shuffleMode,
  );
  Future<void> updatePlaylist(PlaylistModel playlist);
  Future<void> removePlaylist(PlaylistModel playlist);
  Future<void> addSongsToPlaylist(PlaylistModel playlist, List<SongModel> songs);
  Future<void> removeIndex(int playlistId, int index);
  Future<void> moveEntry(int playlistId, int oldIndex, int newIndex);
  Stream<List<SongModel>> getPlaylistSongStream(PlaylistModel playlist);
  Future<List<PlaylistModel>> searchPlaylists(String searchText, {int? limit});
  Future<void> removeBlockedSongs(List<String> paths);

  Stream<List<SmartListModel>> get smartListsStream;
  Stream<SmartListModel> getSmartListStream(int smartListId);
  Future<void> insertSmartList(
    String name,
    Filter filter,
    OrderBy orderBy,
    String iconString,
    String gradientString,
    ShuffleMode? shuffleMode,
  );
  Future<void> updateSmartList(SmartListModel smartListModel);
  Future<void> removeSmartList(SmartListModel smartListModel);
  Stream<List<SongModel>> getSmartListSongStream(SmartListModel smartList);
  Future<List<SmartListModel>> searchSmartLists(String searchText, {int? limit});
}

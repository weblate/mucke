import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/shuffle_mode.dart';
import '../../domain/entities/smart_list.dart';
import '../../domain/entities/song.dart';
import '../l10n_utils.dart';
import '../mucke_icons.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../state/navigation_store.dart';
import '../state/smart_list_page_store.dart';
import '../utils.dart' as utils;
import '../widgets/bottom_sheet/add_to_playlist.dart';
import '../widgets/cover_sliver_appbar.dart';
import '../widgets/custom_modal_bottom_sheet.dart';
import '../widgets/play_shuffle_button.dart';
import '../widgets/playlist_cover.dart';
import '../widgets/song_bottom_sheet.dart';
import '../widgets/song_list_tile.dart';
import 'smart_list_form_page.dart';

class SmartListPage extends StatefulWidget {
  const SmartListPage({Key? key, required this.smartList}) : super(key: key);

  final SmartList smartList;

  @override
  _SmartListPageState createState() => _SmartListPageState();
}

class _SmartListPageState extends State<SmartListPage> {
  late SmartListPageStore store;

  @override
  void initState() {
    super.initState();
    store = GetIt.I<SmartListPageStore>(param1: widget.smartList);
    store.setupReactions();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioStore audioStore = GetIt.I<AudioStore>();
    final NavigationStore navStore = GetIt.I<NavigationStore>();

    return Scaffold(
      body: Observer(
        builder: (context) {
          final songs = store.smartListSongStream.value ?? [];
          final smartList = store.smartListStream.value ?? widget.smartList;

          final totalDuration = songs.fold(
            const Duration(milliseconds: 0),
            (Duration d, s) => d + s.duration,
          );

          IconData playIcon = Icons.play_arrow_rounded;
          switch (smartList.shuffleMode) {
            case ShuffleMode.standard:
              playIcon = Icons.shuffle_rounded;
              break;
            case ShuffleMode.plus:
              playIcon = MuckeIcons.shuffle_heart;
              break;
            case ShuffleMode.none:
              playIcon = MuckeIcons.shuffle_none;
              break;
            default:
          }

          return Scrollbar(
            child: CustomScrollView(
              slivers: [
                CoverSliverAppBar(
                  actions: [
                    Observer(
                      builder: (context) {
                        final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;

                        if (!isMultiSelectEnabled)
                          return IconButton(
                            key: GlobalKey(),
                            icon: const Icon(Icons.edit_rounded),
                            onPressed: () => navStore.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SmartListFormPage(
                                  smartList: smartList,
                                ),
                              ),
                            ),
                          );

                        return Container();
                      },
                    ),
                    Observer(
                      builder: (context) {
                        final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;

                        if (isMultiSelectEnabled)
                          return IconButton(
                            key: GlobalKey(),
                            icon: const Icon(Icons.more_vert_rounded),
                            onPressed: () => _openMultiselectMenu(context),
                          );

                        return Container();
                      },
                    ),
                    Observer(
                      builder: (context) {
                        final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        final isAllSelected = store.selection.isAllSelected;

                        if (isMultiSelectEnabled)
                          return IconButton(
                            key: GlobalKey(),
                            icon: isAllSelected
                                ? const Icon(Icons.deselect_rounded)
                                : const Icon(Icons.select_all_rounded),
                            onPressed: () {
                              if (isAllSelected)
                                store.selection.deselectAll();
                              else
                                store.selection.selectAll();
                            },
                          );

                        return Container();
                      },
                    ),
                    Observer(
                      builder: (context) {
                        final isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                        return IconButton(
                          key: const ValueKey('SMARTLIST_MULTISELECT'),
                          icon: isMultiSelectEnabled
                              ? const Icon(Icons.close_rounded)
                              : const Icon(Icons.checklist_rtl_rounded),
                          onPressed: () => store.selection.toggleMultiSelect(),
                        );
                      },
                    ),
                  ],
                  title: smartList.name,
                  subtitle2:
                      '${L10n.of(context)!.nSongs(songs.length).capitalize()} • ${utils.msToTimeString(totalDuration)}',
                  backgroundColor: utils.bgColor(smartList.gradient.colors.first),
                  cover: PlaylistCover(
                    size: 120,
                    icon: smartList.icon,
                    gradient: smartList.gradient,
                  ),
                  button: PlayShuffleButton(
                    onPressed: () => audioStore.playSmartList(smartList),
                    shuffleMode: smartList.shuffleMode,
                    size: 56,
                  ),
                ),
                Observer(
                  builder: (context) {
                    final bool isMultiSelectEnabled = store.selection.isMultiSelectEnabled;
                    final List<bool> isSelected = store.selection.isSelected.toList();

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final Song song = songs[index];
                          return SongListTile(
                            song: song,
                            isSelectEnabled: isMultiSelectEnabled,
                            isSelected: isMultiSelectEnabled && isSelected[index],
                            onTap: () => audioStore.playSong(index, songs, smartList),
                            onTapMore: () => showModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => SongBottomSheet(
                                song: song,
                              ),
                            ),
                            onSelect: (bool selected) =>
                                store.selection.setSelected(selected, index),
                          );
                        },
                        childCount: songs.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _openMultiselectMenu(BuildContext context) async {
    final audioStore = GetIt.I<AudioStore>();
    final musicDataStore = GetIt.I<MusicDataStore>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Observer(builder: (context) {
        final isSelected = store.selection.isSelected;
        final allSongs = store.smartListSongStream.value ?? [];
        final songs = <Song>[];
        for (int i = 0; i < allSongs.length; i++) {
          if (isSelected[i]) songs.add(allSongs[i]);
        }

        return MyBottomSheet(
          widgets: [
            ListTile(
              title: Text(L10n.of(context)!.nSongsSelected(songs.length).capitalize()),
            ),
            ListTile(
              title: Text(L10n.of(context)!.playNext),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.playNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: Text(L10n.of(context)!.appendToQueued),
              leading: const Icon(Icons.play_arrow_rounded),
              onTap: () {
                audioStore.appendToNext(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              title: Text(L10n.of(context)!.addToQueue),
              leading: const Icon(Icons.queue_rounded),
              onTap: () {
                audioStore.addToQueue(songs);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AddToPlaylistTile(songs: songs, musicDataStore: musicDataStore),
          ],
        );
      }),
    );
  }
}

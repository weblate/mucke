import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/song.dart';
import '../state/audio_store.dart';
import '../state/music_data_store.dart';
import '../theming.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({Key key, this.iconSize = 20.0}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final MusicDataStore musicDataStore = Provider.of<MusicDataStore>(context);
    final AudioStore audioStore = Provider.of<AudioStore>(context);

    return Observer(
      builder: (BuildContext context) {
        final Song song = audioStore.currentSong;

        if (song.likeCount == 0) {
          return IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              size: iconSize,
              color: Colors.white24,
            ),
            onPressed: () => musicDataStore.incrementLikeCount(song),
          );
        } else {
          return IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: iconSize,
                ),
                Text(
                  song.likeCount.toString(),
                  style: const TextStyle(
                    color: DARK1,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              alignment: AlignmentDirectional.center,
            ),
            onPressed: () {
              if (song.likeCount < 5) {
                return musicDataStore.incrementLikeCount(song);
              }
              return musicDataStore.resetLikeCount(song);
            },
          );
        }
      },
    );
  }
}

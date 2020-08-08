import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

import '../../domain/entities/artist.dart';
import '../datasources/moor_music_data_source.dart';

class ArtistModel extends Artist {
  const ArtistModel({
    @required String name,
  }) : super(
          name: name,
        );

  factory ArtistModel.fromMoorArtist(MoorArtist moorArtist) => ArtistModel(
        name: moorArtist.name,
      );

  factory ArtistModel.fromArtistInfo(ArtistInfo artistInfo) {
    return ArtistModel(
      name: artistInfo.name,
    );
  }

  ArtistsCompanion toArtistsCompanion() => ArtistsCompanion(
        name: Value(name),
      );
}
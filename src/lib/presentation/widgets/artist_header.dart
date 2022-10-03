import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/artist.dart';
import '../state/navigation_store.dart';

class ArtistHeader extends StatelessWidget {
  const ArtistHeader({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final navStore = GetIt.I<NavigationStore>();

    const double height = 144.0;
    return SliverAppBar(
      pinned: true,
      expandedHeight: height,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_rounded),
        onPressed: () => navStore.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.symmetric(horizontal: 48.0),
        title: Container(
          alignment: Alignment.center,
          height: height * 0.66,
          child: Text(
            artist.name,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
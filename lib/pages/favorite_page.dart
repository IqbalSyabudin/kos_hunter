import 'package:flutter/material.dart';
import 'package:kos_hunter/models/space.dart';
import 'package:kos_hunter/widgets/space_card.dart';

class FavoritePage extends StatelessWidget {
  final List<Space> favoriteSpaces;
  final Set<int> favoriteIds;
  final Function(int) onFavoriteToggle;

  const FavoritePage({
    required this.favoriteSpaces,
    required this.favoriteIds,
    required this.onFavoriteToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kos Favorit'),
      ),
      body: favoriteSpaces.isEmpty
          ? Center(child: Text('Belum ada kos favorit.'))
          : ListView.builder(
              itemCount: favoriteSpaces.length,
              itemBuilder: (context, index) {
                final space = favoriteSpaces[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SpaceCard(
                    space: space,
                    isFavorited: favoriteIds.contains(space.id),
                    onFavoriteToggle: () => onFavoriteToggle(space.id),
                  ),
                );
              },
            ),
    );
  }
}

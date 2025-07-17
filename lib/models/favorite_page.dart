import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kos_hunter/models/space.dart';
import 'package:kos_hunter/widgets/space_card.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final supabase = Supabase.instance.client;

  List<Space> favoriteSpaces = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final response = await supabase
          .from('favorites')
          .select('kosts(*)') // join ke kosts
          .eq('user_id', supabase.auth.currentUser!.id);

      print(response); // debug: lihat isi data

      setState(() {
        favoriteSpaces = (response as List)
            .map((item) => Space.fromMap(item['kosts']))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading favorites: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kos Favorit')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteSpaces.isEmpty
              ? Center(child: Text('Belum ada kos favorit'))
              : ListView.builder(
                  itemCount: favoriteSpaces.length,
                  itemBuilder: (context, index) {
                    final space = favoriteSpaces[index];
                    return SpaceCard(
                      space: space,
                      isFavorited: true,
                      onFavoriteToggle: () {
                        // Tambahkan toggle hapus jika mau
                      },
                    );
                  },
                ),
    );
  }
}

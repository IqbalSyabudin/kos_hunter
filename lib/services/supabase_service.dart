import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/city.dart';
import '../models/space.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // Ambil semua data kota
  Future<List<City>> fetchCities() async {
    final response = await supabase.from('cities').select();
    return (response as List).map((data) => City.fromMap(data)).toList();
  }

  // Ambil semua data kos
  Future<List<Space>> fetchSpaces() async {
    final response = await supabase.from('kosts').select();
    return (response as List).map((data) => Space.fromMap(data)).toList();
  }

  // Ambil 1 data kos berdasarkan ID
  Future<Space?> fetchSpaceById(int id) async {
    final response = await supabase.from('kosts').select().eq('id', id).single();
    if (response == null) return null;
    return Space.fromMap(response);
  }

  // Tambah data kos baru
  Future<void> addSpace(Space space) async {
    await supabase.from('kosts').insert(space.toMap());
  }

  // Perbarui data kos berdasarkan ID
  Future<void> updateSpace(Space space) async {
    await supabase.from('kosts').update(space.toMap()).eq('id', space.id);
  }

  // Hapus data kos berdasarkan ID
  Future<void> deleteSpace(int id) async {
    await supabase.from('kosts').delete().eq('id', id);
  }

  // Ambil data kos berdasarkan ID kota
  Future<List<Space>> fetchSpacesByCity(int cityId) async {
    final response = await supabase.from('kosts').select().eq('city_id', cityId);
    return (response as List).map((data) => Space.fromMap(data)).toList();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anggota.dart';

class ApiService {
  // ================== BASE URL ==================
  // Untuk Flutter WEB
  static const String anggotaUrl = 'http://127.0.0.1:8000/api/anggota';
  static const String pendaftaranUrl = 'http://127.0.0.1:8000/api/pendaftaran';

  /*
  CATATAN:
  - Emulator Android : http://10.0.2.2:8000/api/anggota
  - Device fisik     : ganti 127.0.0.1 dengan IP laptop
  */

  // =================================================
  // ==================== ANGGOTA ====================
  // =================================================

  // GET - Ambil semua data anggota
  static Future<List<Anggota>> ambilSemuaAnggota() async {
    try {
      final response = await http.get(Uri.parse(anggotaUrl));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => Anggota.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data anggota');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // POST - Tambah anggota
  static Future<bool> tambahAnggota(
    String nama,
    String telp,
    String alamat,
    String pupuk,
    String jumlah,
    String tanggal,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(anggotaUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama': nama,
          'telp': telp,
          'alamat': alamat,
          'pupuk': pupuk,
          'jumlah': jumlah,
          'tanggal': tanggal,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error tambah anggota: $e');
      return false;
    }
  }

  // PUT - Update anggota
  static Future<bool> updateAnggota(
    String id,
    String nama,
    String telp,
    String alamat,
    String pupuk,
    String jumlah,
    String tanggal,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$anggotaUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nama': nama,
          'telp': telp,
          'alamat': alamat,
          'pupuk': pupuk,
          'jumlah': jumlah,
          'tanggal': tanggal,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error update anggota: $e');
      return false;
    }
  }

  // DELETE - Hapus anggota
  static Future<bool> hapusAnggota(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$anggotaUrl/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error hapus anggota: $e');
      return false;
    }
  }

  // =================================================
  // ================== PENDAFTARAN ==================
  // =================================================

  // GET - Ambil data pendaftaran
  static Future<List<dynamic>> ambilPendaftaran() async {
    try {
      final response =
          await http.get(Uri.parse(pendaftaranUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print('Error ambil pendaftaran: $e');
      return [];
    }
  }

  // POST - Tambah pendaftaran
  static Future<bool> tambahPendaftaran(
    String idAnggota,
    String tanggalDaftar,
    String status,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$pendaftaranUrl/tambah'),
        body: {
          'id_anggota': idAnggota,
          'tanggal_daftar': tanggalDaftar,
          'status': status,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error tambah pendaftaran: $e');
      return false;
    }
  }

  // POST - Hapus pendaftaran (opsional, uji coding)
  static Future<bool> hapusPendaftaran(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$pendaftaranUrl/hapus'),
        body: {
          'id': id,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error hapus pendaftaran: $e');
      return false;
    }
  }
}

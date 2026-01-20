import 'package:flutter/material.dart';
import '../models/anggota.dart';
import '../services/api_service.dart';
import 'tambah_anggota.dart';
import 'tambah_pendaftaran.dart';

class ListAnggota extends StatefulWidget {
  @override
  _ListAnggotaState createState() => _ListAnggotaState();
}

class _ListAnggotaState extends State<ListAnggota> {
  List<Anggota> _anggotaList = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await ApiService.ambilSemuaAnggota();
      setState(() {
        _anggotaList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _deleteAnggota(String id, String nama) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Hapus data "$nama"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await ApiService.hapusAnggota(id);
      if (success) {
        _loadData();
      }
    }
  }

  void _navigateToForm({Anggota? anggota}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahAnggota(anggota: anggota),
      ),
    );

    if (result == true) {
      _loadData();
    }
  }

  // ================= NAVIGASI KE PENDAFTARAN =================
  void _kePendaftaran() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahPendaftaran(),
      ),
    );
  }
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ================= APP BAR =================
      appBar: AppBar(
        title: Text('Data Anggota'),
        actions: [
          IconButton(
            icon: Icon(Icons.assignment),
            tooltip: 'Pendaftaran',
            onPressed: _kePendaftaran,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      // ===========================================

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _anggotaList.isEmpty
                  ? Center(child: Text('Belum ada data'))
                  : ListView.builder(
                      itemCount: _anggotaList.length,
                      itemBuilder: (context, index) {
                        final anggota = _anggotaList[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(anggota.nama),
                            subtitle: Text(anggota.telp),
                            onTap: () => _navigateToForm(anggota: anggota),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteAnggota(
                                anggota.id.toString(),
                                anggota.nama,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}

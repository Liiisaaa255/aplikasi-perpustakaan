import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TambahPendaftaran extends StatefulWidget {
  @override
  State<TambahPendaftaran> createState() => _TambahPendaftaranState();
}

class _TambahPendaftaranState extends State<TambahPendaftaran> {
  final idController = TextEditingController();
  final tanggalController = TextEditingController();
  String status = "aktif";

  void simpan() async {
    bool sukses = await ApiService.tambahPendaftaran(
      idController.text,
      tanggalController.text,
      status,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          sukses ? "Pendaftaran berhasil" : "Pendaftaran gagal",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Pendaftaran")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: "ID Anggota"),
            ),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(labelText: "Tanggal Daftar"),
            ),

            // RADIO BUTTON (BUKTI UJI CODING)
            Row(
              children: [
                Radio(
                  value: "aktif",
                  groupValue: status,
                  onChanged: (v) => setState(() => status = v.toString()),
                ),
                Text("Aktif"),
                Radio(
                  value: "nonaktif",
                  groupValue: status,
                  onChanged: (v) => setState(() => status = v.toString()),
                ),
                Text("Nonaktif"),
              ],
            ),

            ElevatedButton(
              onPressed: simpan,
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}

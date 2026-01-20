class Anggota {
  final int id;
  final String nama;
  final String telp;
  final String alamat;
  final String? createdAt;
  final String? updatedAt;
  final String? pupuk;
  final double? jumlah;      // UBAH dari int? jadi double?
  final String? tanggal;

  Anggota({
    required this.id,
    required this.nama,
    required this.telp,
    required this.alamat,
    this.createdAt,
    this.updatedAt,
    this.pupuk,
    this.jumlah,
    this.tanggal,
  });

  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nama: json['nama'] ?? '',
      telp: json['telp'] ?? '',
      alamat: json['alamat'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pupuk: json['pupuk'],
      jumlah: json['jumlah'] != null 
          ? (json['jumlah'] is int 
              ? (json['jumlah'] as int).toDouble() 
              : json['jumlah'] as double)
          : null,
      tanggal: json['tanggal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'telp': telp,
      'alamat': alamat,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pupuk': pupuk,
      'jumlah': jumlah,
      'tanggal': tanggal,
    };
  }
}
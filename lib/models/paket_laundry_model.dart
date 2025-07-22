class PaketLaundryModel {
  final int? id;
  final String? nama_paket;
  final String? deskripsi;
  final String? layanan;
  final int? harga;
  final int? kategori; // id kategori

  PaketLaundryModel({
    required this.id,
    required this.nama_paket,
    required this.deskripsi,
    required this.layanan,
    required this.harga,
    required this.kategori,
  });

  factory PaketLaundryModel.fromJson(Map<String, dynamic> json) {
    return PaketLaundryModel(
      id: json['id'],
      nama_paket: json['nama_paket'],
      deskripsi: json['deskripsi'],
      layanan: json['layanan'],
      harga: json['harga'],
      kategori: json['kategori'], // ini ID kategori
    );
  }
}

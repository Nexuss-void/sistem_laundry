class PaketLaundryModel {
  final int? id;
  final String? kode_paket;
  final String? nama_paket;
  final String? layanan;
  final int? harga;
  final int? kategori;

  PaketLaundryModel({
    required this.id,
    required this.kode_paket,
    required this.nama_paket,
    required this.layanan,
    required this.harga,
    required this.kategori,
  });

  factory PaketLaundryModel.fromJson(Map<String, dynamic> json) {
    return PaketLaundryModel(
      id: json['id'],
      kode_paket: json['kode_paket'],
      nama_paket: json['nama_paket'],
      layanan: json['layanan'],
      harga: json['harga'],
      kategori: json['kategori'],
    );
  }
}

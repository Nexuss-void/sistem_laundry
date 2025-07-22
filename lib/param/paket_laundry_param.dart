class PaketLaundryParam {
  final int? id;
  final String? nama_paket;
  final String? deskripsi;
  final String? layanan;
  final int? harga;
  final int? kategori;

  PaketLaundryParam({
    this.id,
    this.nama_paket,
    this.deskripsi,
    this.layanan,
    this.harga,
    this.kategori,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_paket': nama_paket,
      'deskripsi': deskripsi,
      'layanan': layanan,
      'harga': harga,
      'kategori': kategori, // kirim ID kategori
    };
  }
}

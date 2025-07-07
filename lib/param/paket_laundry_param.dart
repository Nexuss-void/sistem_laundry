class PaketLaundryParam {
  final int? id;
  final String? kode_paket;
  final String? nama_paket;
  final String? layanan;
  final int? harga;
  final int? kategori;

  PaketLaundryParam({
    this.id,
    this.kode_paket,
    this.nama_paket,
    this.layanan,
    this.harga,
    this.kategori,
  });

  Map<String, dynamic> toJson() {
    return {
      'kode_paket': kode_paket,
      'nama_paket': nama_paket,
      'layanan': layanan,
      'harga': harga,
      'kategori': kategori,
    };
  }
}

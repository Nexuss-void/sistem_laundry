import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sistem_laundryabc/core/api_client.dart';
import 'package:sistem_laundryabc/models/paket_laundry_model.dart';
import 'package:sistem_laundryabc/param/paket_laundry_param.dart';
import 'package:sistem_laundryabc/response/paket_laundry_create_respon.dart';

class PaketLaundryRepo extends ApiClient {
  Future<List<PaketLaundryModel>> getPaket() async {
    try {
      var response = await dio.get('paket');
      print('Response body: ${response.data}');
      debugPrint('Paket Laundry GET All: ${response.data}');
      List list = response.data;
      List<PaketLaundryModel> listPaketLaundry = list
          .map((element) => PaketLaundryModel.fromJson(element))
          .toList();
      return listPaketLaundry;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<PaketLaundryCreateRespon> addPaket(
    PaketLaundryParam paketLaundryParam,
  ) async {
    try {
      var response = await dio.post('paket', data: paketLaundryParam.toJson());
      debugPrint('Paket Laundry POST: ${response.data}');
      if (response.statusCode == 201) {
        return PaketLaundryCreateRespon(message: 'Data berhasil disimpan');
      } else {
        throw Exception('Gagal menyimpan data');
      }
    } on DioException catch (e) {
      throw Exception('Terjadi kesalahan: ${e.message}');
    }
  }

  Future<PaketLaundryCreateRespon> updatePaket(
    PaketLaundryParam paketLaundryParam,
  ) async {
    try {
      var response = await dio.put(
        'paket/${paketLaundryParam.id}',
        data: paketLaundryParam.toJson(),
      );
      debugPrint('Paket Laundry UPDATE : ${response.data}');
      if (response.statusCode == 200) {
        return PaketLaundryCreateRespon(message: 'Data berhasil diupdate');
      } else {
        throw Exception('Gagal update data');
      }
    } on DioException catch (e) {
      throw Exception('Terjadi kesalahan: ${e.message}');
    }
  }
}

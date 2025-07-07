import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sistem_laundryabc/param/paket_laundry_param.dart';
import 'package:sistem_laundryabc/repo/paket_laundry_repo.dart';
import 'package:sistem_laundryabc/response/paket_laundry_create_respon.dart';

part 'add_paket_laundry_event.dart';

part 'add_paket_laundry_state.dart';

class AddPaketLaundryBloc
    extends Bloc<AddPaketLaundryEvent, AddPaketLaundryState> {
  final paketLaundryRepo = PaketLaundryRepo();

  AddPaketLaundryBloc() : super(AddPaketLaundryInitial()) {
    on<AddPaketLaundryPressed>(_onAddPaketLaundryPressed);
    on<UpdatePaketLaundryPressed>(_onUpdatePaketLaundryPressed);
  }

  Future<void> _onAddPaketLaundryPressed(
    AddPaketLaundryPressed event,
    Emitter<AddPaketLaundryState> emit,
  ) async {
    final params = PaketLaundryParam(
      id: event.paketLaundryParam.id,
      kode_paket: event.paketLaundryParam.kode_paket,
      nama_paket: event.paketLaundryParam.nama_paket,
      layanan: event.paketLaundryParam.layanan,
      harga: event.paketLaundryParam.harga,
      kategori: event.paketLaundryParam.kategori,
    );
    try {
      emit(AddPaketLaundryLoading());
      PaketLaundryCreateRespon response = await paketLaundryRepo.addPaket(
        params,
      );
      emit(AddPaketLaundrySuccess(paketLaundryCreateRespon: response));
    } catch (e) {
      emit(AddPaketLaundryError(message: e.toString()));
    }
  }

  Future<void> _onUpdatePaketLaundryPressed(
    UpdatePaketLaundryPressed event,
    Emitter<AddPaketLaundryState> emit,
  ) async {
    final params = PaketLaundryParam(
      id: event.paketLaundryParam.id,
      kode_paket: event.paketLaundryParam.kode_paket,
      nama_paket: event.paketLaundryParam.nama_paket,
      layanan: event.paketLaundryParam.layanan,
      harga: event.paketLaundryParam.harga,
      kategori: event.paketLaundryParam.kategori,
    );
    try {
      emit(AddPaketLaundryLoading());
      PaketLaundryCreateRespon response = await paketLaundryRepo.updatePaket(
        params,
      );
      emit(AddPaketLaundrySuccess(paketLaundryCreateRespon: response));
    } catch (e) {
      emit(AddPaketLaundryError(message: e.toString()));
    }
  }
}

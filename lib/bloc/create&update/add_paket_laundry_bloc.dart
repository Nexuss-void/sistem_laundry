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

  FutureOr<void> _onAddPaketLaundryPressed(
    AddPaketLaundryPressed event,
    Emitter<AddPaketLaundryState> emit,
  ) async {
    final params = PaketLaundryParam(
      id: event.paketLaundryParam.id,
      nama_paket: event.paketLaundryParam.nama_paket,
      deskripsi: event.paketLaundryParam.deskripsi,
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

  FutureOr<void> _onUpdatePaketLaundryPressed(
    UpdatePaketLaundryPressed event,
    Emitter<AddPaketLaundryState> emit,
  ) async {
    final params = PaketLaundryParam(
      id: event.paketLaundryParam.id,
      nama_paket: event.paketLaundryParam.nama_paket,
      deskripsi: event.paketLaundryParam.deskripsi,
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

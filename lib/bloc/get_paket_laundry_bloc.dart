import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sistem_laundryabc/models/paket_laundry_model.dart';
import 'package:sistem_laundryabc/repo/paket_laundry_repo.dart';

part 'get_paket_laundry_event.dart';

part 'get_paket_laundry_state.dart';

class GetPaketLaundryBloc
    extends Bloc<GetPaketLaundryEvent, GetPaketLaundryState> {
  final paketLaundryRepo = PaketLaundryRepo();

  GetPaketLaundryBloc() : super(GetPaketLaundryInitial()) {
    on<PaketLaundryFetched>(_onLaundryFetched);
  }

  Future<void> _onLaundryFetched(
    PaketLaundryFetched event,
    Emitter<GetPaketLaundryState> exit,
  ) async {
    emit(GetPaketLaundryLoading());
    try {
      List<PaketLaundryModel> list = await paketLaundryRepo.getPaket();
      emit(GetPaketLaundryLoaded(listPaketLaundry: list));
    } catch (e) {
      emit(GetPaketLaundryError(message: e.toString()));
    }
  }
}

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
    on<PaketLaundrySearch>(_onLaundrySearch);
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

  FutureOr<void> _onLaundrySearch(
    PaketLaundrySearch event,
    Emitter<GetPaketLaundryState> emit,
  ) async {
    emit(GetPaketLaundryLoading());
    try {
      final result = await paketLaundryRepo.searchPaketLaundry(event.keyword);
      emit(GetPaketLaundryLoaded(listPaketLaundry: result));
    } catch (e) {
      emit(GetPaketLaundryError(message: e.toString()));
    }
  }
}

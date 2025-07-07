part of 'get_paket_laundry_bloc.dart';

@immutable
sealed class GetPaketLaundryState {}

final class GetPaketLaundryInitial extends GetPaketLaundryState {}

final class GetPaketLaundryLoading extends GetPaketLaundryState {}

final class GetPaketLaundryLoaded extends GetPaketLaundryState {
  final List<PaketLaundryModel> listPaketLaundry;

  GetPaketLaundryLoaded({required this.listPaketLaundry});
}

final class GetPaketLaundryError extends GetPaketLaundryState {
  final String message;

  GetPaketLaundryError({required this.message});
}

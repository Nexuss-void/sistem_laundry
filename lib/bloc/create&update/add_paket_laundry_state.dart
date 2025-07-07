part of 'add_paket_laundry_bloc.dart';

@immutable
sealed class AddPaketLaundryState {}

final class AddPaketLaundryInitial extends AddPaketLaundryState {}

final class AddPaketLaundryLoading extends AddPaketLaundryState {}

final class AddPaketLaundrySuccess extends AddPaketLaundryState {
  final PaketLaundryCreateRespon paketLaundryCreateRespon;

  AddPaketLaundrySuccess({required this.paketLaundryCreateRespon});
}

final class UpdatePaketLaundrySuccess extends AddPaketLaundryState {
  final PaketLaundryCreateRespon paketLaundryCreateRespon;

  UpdatePaketLaundrySuccess({required this.paketLaundryCreateRespon});
}

final class AddPaketLaundryError extends AddPaketLaundryState {
  final String message;

  AddPaketLaundryError({required this.message});
}

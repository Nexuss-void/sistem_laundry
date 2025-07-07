part of 'add_paket_laundry_bloc.dart';

@immutable
sealed class AddPaketLaundryEvent {}

final class AddPaketLaundryPressed extends AddPaketLaundryEvent {
  final PaketLaundryParam paketLaundryParam;

  AddPaketLaundryPressed({required this.paketLaundryParam});
}

final class UpdatePaketLaundryPressed extends AddPaketLaundryEvent {
  final PaketLaundryParam paketLaundryParam;

  UpdatePaketLaundryPressed({required this.paketLaundryParam, required int id});
}

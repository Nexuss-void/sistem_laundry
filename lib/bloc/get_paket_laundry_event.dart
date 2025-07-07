part of 'get_paket_laundry_bloc.dart';

@immutable
sealed class GetPaketLaundryEvent {}

final class PaketLaundryFetched extends GetPaketLaundryEvent {}

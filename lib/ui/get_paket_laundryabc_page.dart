import 'package:flutter/material.dart';
import 'package:sistem_laundryabc/bloc/create&update/add_paket_laundry_bloc.dart';
import 'package:sistem_laundryabc/bloc/get_paket_laundry_bloc.dart';
import 'package:sistem_laundryabc/models/paket_laundry_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_laundryabc/ui/paket_laundry_formpage.dart';

class GetPaketLaundryabcPage extends StatelessWidget {
  const GetPaketLaundryabcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paket Laundry')),
      body: BlocBuilder<GetPaketLaundryBloc, GetPaketLaundryState>(
        builder: (context, state) {
          return switch (state) {
            GetPaketLaundryInitial() || GetPaketLaundryLoading() => Center(
              child: CircularProgressIndicator(),
            ),
            // TODO: Handle this case.
            GetPaketLaundryLoaded(listPaketLaundry: var data)
                when data.isNotEmpty =>
              ListView.builder(
                itemCount: state.listPaketLaundry.length,
                itemBuilder: (_, index) {
                  PaketLaundryModel paketLaundryModel =
                      state.listPaketLaundry[index];
                  return ListTile(
                    onTap: () {
                      debugPrint('Item:${paketLaundryModel.nama_paket}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaketLaundryFormpage(
                            paketLaundryModel: paketLaundryModel,
                          ),
                        ),
                      ).then(
                        (value) => context.read<GetPaketLaundryBloc>().add(
                          PaketLaundryFetched(),
                        ),
                      );
                    },
                    title: Text(paketLaundryModel.nama_paket.toString()),
                    subtitle: Text(
                      'Kode: ${paketLaundryModel.kode_paket.toString()} ',
                    ),
                  );
                },
              ),
            // TODO: Handle this case.
            GetPaketLaundryError() => Center(child: Text(state.message)),
            // TODO: Handle this case.
            GetPaketLaundryLoaded() => Center(child: Text('data tidak ada')),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => AddPaketLaundryBloc(),
                child: PaketLaundryFormpage(),
              ),
            ),
          ).then(
            (value) =>
                context.read<GetPaketLaundryBloc>().add(PaketLaundryFetched()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

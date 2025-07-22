import 'package:flutter/material.dart';
import 'package:sistem_laundryabc/bloc/create&update/add_paket_laundry_bloc.dart';
import 'package:sistem_laundryabc/bloc/get_paket_laundry_bloc.dart';
import 'package:sistem_laundryabc/models/paket_laundry_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_laundryabc/ui/paket_laundry_formpage.dart';

class GetPaketLaundryabcPage extends StatefulWidget {
  const GetPaketLaundryabcPage({super.key});

  @override
  State<GetPaketLaundryabcPage> createState() => _GetPaketLaundryabcPageState();
}

class _GetPaketLaundryabcPageState extends State<GetPaketLaundryabcPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetPaketLaundryBloc>().add(PaketLaundryFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paket Laundry')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<GetPaketLaundryBloc>().add(
                  PaketLaundrySearch(keyword: value),
                );
              },
              decoration: const InputDecoration(
                labelText: 'Cari Paket Laundry',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetPaketLaundryBloc, GetPaketLaundryState>(
              builder: (context, state) {
                return switch (state) {
                  GetPaketLaundryInitial() || GetPaketLaundryLoading() =>
                    const Center(child: CircularProgressIndicator()),

                  GetPaketLaundryLoaded(listPaketLaundry: var data)
                      when data.isNotEmpty =>
                    ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final paket = data[index];
                        return ListTile(
                          title: Text(paket.nama_paket!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Layanan: ${paket.layanan}'),
                              Text('Harga: ${paket.harga}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaketLaundryFormpage(
                                  paketLaundryModel: paket,
                                ),
                              ),
                            ).then(
                              (value) => context
                                  .read<GetPaketLaundryBloc>()
                                  .add(PaketLaundryFetched()),
                            );
                          },
                        );
                      },
                    ),

                  GetPaketLaundryLoaded() => const Center(
                    child: Text('Data tidak ditemukan'),
                  ),

                  GetPaketLaundryError(message: var msg) => Center(
                    child: Text(msg),
                  ),
                };
              },
            ),
          ),
        ],
      ),

      // ✅ FloatingActionButton ditambahkan di sini
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

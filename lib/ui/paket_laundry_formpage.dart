import 'package:flutter/material.dart';
import 'package:sistem_laundryabc/bloc/create&update/add_paket_laundry_bloc.dart';
import 'package:sistem_laundryabc/models/paket_laundry_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_laundryabc/param/paket_laundry_param.dart';

class PaketLaundryFormpage extends StatefulWidget {
  PaketLaundryModel? paketLaundryModel;

  PaketLaundryFormpage({super.key, this.paketLaundryModel});

  @override
  State<PaketLaundryFormpage> createState() => _PaketLaundryFormpageState();
}

class _PaketLaundryFormpageState extends State<PaketLaundryFormpage> {
  final TextEditingController tecCodePaket = TextEditingController();
  final TextEditingController tecNamePaket = TextEditingController();
  final TextEditingController tecService = TextEditingController();
  final TextEditingController tecPrice = TextEditingController();
  final TextEditingController tecCategory = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.paketLaundryModel != null) {
      tecCodePaket.text = widget.paketLaundryModel!.kode_paket!;
      tecNamePaket.text = widget.paketLaundryModel!.nama_paket!;
      tecService.text = widget.paketLaundryModel!.layanan!;
      tecPrice.text = widget.paketLaundryModel!.harga!.toString();
      tecCategory.text = widget.paketLaundryModel!.kategori!.toString();
    } else {
      emptyForm();
    }
    super.initState();
  }

  @override
  void emptyForm() {
    tecCodePaket.text = '';
    tecNamePaket.text = '';
    tecService.text = '';
    tecPrice.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPaketLaundryBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.paketLaundryModel == null
                ? 'Add Paket Laundry'
                : 'Update Paket Laundry',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                //input kode paket
                TextFormField(
                  controller: tecCodePaket,
                  decoration: InputDecoration(
                    labelText: 'Kode Paket Laundry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kode paket laundry wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                //input nama paket
                TextFormField(
                  controller: tecNamePaket,
                  decoration: InputDecoration(
                    labelText: 'Nama Paket Laundry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama paket laundry wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                //input layanan
                TextFormField(
                  controller: tecService,
                  decoration: InputDecoration(
                    labelText: 'layanan Paket Laundry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'layanan paket laundry wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                //input harga
                TextFormField(
                  controller: tecPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga Paket Laundry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga paket laundry wajib diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus angka';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                //input kategori
                TextFormField(
                  controller: tecCategory,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kategori Paket Laundry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'kategori paket laundry wajib diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus angka';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                BlocListener<AddPaketLaundryBloc, AddPaketLaundryState>(
                  listener: (context, state) {
                    if (state is AddPaketLaundrySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.paketLaundryCreateRespon.message),
                        ),
                      );
                    } else if (state is AddPaketLaundryError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is UpdatePaketLaundrySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.paketLaundryCreateRespon.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<AddPaketLaundryBloc, AddPaketLaundryState>(
                    builder: (context, state) {
                      if (state is AddPaketLaundryLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              // Buat params untuk POST atau UPDATE
                              var params = PaketLaundryParam(
                                id: widget.paketLaundryModel?.id,
                                // null jika post
                                kode_paket: tecCodePaket.text,
                                nama_paket: tecNamePaket.text,
                                layanan: tecService.text,
                                harga: int.parse(tecPrice.text),
                                kategori: int.parse(tecCategory.text),
                              );

                              if (widget.paketLaundryModel == null) {
                                // POST
                                context.read<AddPaketLaundryBloc>().add(
                                  AddPaketLaundryPressed(
                                    paketLaundryParam: params,
                                  ),
                                );
                              } else {
                                // UPDATE
                                context.read<AddPaketLaundryBloc>().add(
                                  UpdatePaketLaundryPressed(
                                    id: widget.paketLaundryModel!.id!,
                                    paketLaundryParam: params,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            widget.paketLaundryModel == null
                                ? 'Simpan'
                                : 'Ubah',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/anasayfa_cubit.dart';
import 'package:todo_app/entity/yapilacaklar.dart';
import 'package:todo_app/views/yapiacak_is_kayit.dart';
import 'package:todo_app/views/yapilacak_is_detay.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yapilacaklariYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<AnasayfaCubit>().ara(aramaSonucu);
          },)
            :
          const Text("Yapılacaklar"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
            aramaYapiliyorMu = false;});
            context.read<AnasayfaCubit>().yapilacaklariYukle();
            }, icon: const Icon(Icons.clear))
              :
          IconButton(onPressed: (){
            setState(() {
            aramaYapiliyorMu = true;});
            }, icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yapilacaklar>>(
        builder: (context, yapilacaklarListesi){
          if(yapilacaklarListesi.isNotEmpty){
            return ListView.builder(
              itemCount: yapilacaklarListesi.length,
              itemBuilder: (context, indeks){
                var yapilacak = yapilacaklarListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => YapilacakIsDetay(yapilacak: yapilacak)))
                    .then((value) => {context.read<AnasayfaCubit>().yapilacaklariYukle()});
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${yapilacak.yapilacak_is}"),
                          const Spacer(),
                          IconButton(
                              onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${yapilacak.yapilacak_is} silinsin mi?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: (){
                                        context.read<AnasayfaCubit>().sil(yapilacak.yapilacak_id);
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_outline, color: Colors.black45,)
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const YapilacakIsKayit()))
          .then((value) => {context.read<AnasayfaCubit>().yapilacaklariYukle()});
        },
      ),
    );
  }
}

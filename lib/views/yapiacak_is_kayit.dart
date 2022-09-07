import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/yapilacak_kayit_cubit.dart';

class YapilacakIsKayit extends StatefulWidget {
  const YapilacakIsKayit({Key? key}) : super(key: key);

  @override
  State<YapilacakIsKayit> createState() => _YapilacakIsKayitState();
}

class _YapilacakIsKayitState extends State<YapilacakIsKayit> {

  var tfYapilacakIs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yapılacak İş Kayıt"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfYapilacakIs, decoration: const InputDecoration(hintText: "Yapılacak İş"),),
              ElevatedButton(
                  onPressed: (){
                    context.read<YapilacakKayitCubit>().kayit(tfYapilacakIs.text);
                  },
                  child: const Text("KAYDET"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/anasayfa_cubit.dart';
import 'package:todo_app/cubit/yapilacak_detay_cubit.dart';
import 'package:todo_app/cubit/yapilacak_kayit_cubit.dart';
import 'package:todo_app/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => YapilacakKayitCubit()),
        BlocProvider(create: (context) => YapilacakDetayCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

import 'package:disneyplus_facelift/pages/everything.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

GetIt getIt = GetIt.instance;

void main() async {
  getIt.registerSingleton<TmdbService>(
    TmdbService('2e17fe2274a355e8ea9dae86ac383759'),
  );
  await GetIt.I<TmdbService>().initConfiguration();
  // getIt.registerFactoryParam<String, String, String>(
  //     (size, filePath) {
  //       String imageUrl = 'https://image.tmdb.org/t/p/$size/$filePath';
  //        return imageUrl;
  //     });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disney Plus Facelift',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
              color: Colors.black,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0),
          scaffoldBackgroundColor: Colors.black,
          typography: Typography.material2021()),
      home: const EverythingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

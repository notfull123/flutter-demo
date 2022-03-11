import 'package:coffee_rosie/bloc/detail_coffee_cubit.dart';
import 'package:coffee_rosie/repositories/coffee_repository.dart';
import 'package:coffee_rosie/ui/detail_coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network/api_client.dart';
import 'network/api_util.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.instance.apiClient;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(create: (context) {
          return CoffeeRepositoryImpl(_apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DetailCoffeeCubit>(create: (context) {
            final repository = RepositoryProvider.of<CoffeeRepository>(context);
            return DetailCoffeeCubit(repository);
          }),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            body: Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.white;
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.blue;
                  }),
                ),
                onPressed: () {
                  final repository = RepositoryProvider.of<CoffeeRepository>(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider<DetailCoffeeCubit>(
                          create: (_) => DetailCoffeeCubit(repository),
                          child: DetailCoffeeScreen(),
                        );
                      },
                    ),
                  );
                },
                child: const Text('Start'),
              ),
            ),
          );
        }),
      ),
    );
  }
}

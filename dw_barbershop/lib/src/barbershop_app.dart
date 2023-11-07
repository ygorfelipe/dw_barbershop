import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/babershop_loader.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      //* adicionando o asyncState para poder controlar ele em qlqr lugar do app
      //* é o brigatorio adicionar o navigatorObservers: [asyncNavigatorObserver],
      //* sera utilizado 2 tipos de loader 1º asyncloader 2º loader de abertura de tela.
      //! o riverpod ele faz as coisas antes de buildar a tela..
      //! não é possível abrir um asyncState na abertura da tela.
      //* adicionando loader customizado
      customLoader: const BabershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barbershop',
          navigatorObservers: [asyncNavigatorObserver],
          debugShowCheckedModeBanner: false,
          theme: BarbershopTheme.themeData,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/home/adm': (_) => const Text('ADM'),
            '/home/employee': (_) => const Text('Employee'),
          },
        );
      },
    );
  }
}

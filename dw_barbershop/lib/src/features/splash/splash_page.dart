import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //! a splash page é utilizado na grande maioria para fazer verificações de dados do usuário entre outras verificações

  //! criando var de animação
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationHeight => 120 * _scale;
  double get _logoAnimationWidth => 100 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            //* após finalizar a animação é redirecionado para a tela de login
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  settings: const RouteSettings(name: '/auth/login'),
                  //! aqui é apenas para deixar a aminação um pouco mais interessante...
                  //* para deixar mais simples, masta colocar apenas o Navigator.of(context).pushAndRemoveUntil e a rota desejada..
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const LoginPage();
                  },
                ),
                (route) => false,
              );
            },
            child: AnimatedContainer(
              height: _logoAnimationHeight,
              width: _logoAnimationWidth,
              duration: const Duration(seconds: 1),
              curve: Curves.linearToEaseOut,
              child: Image.asset(
                ImageConstants.imageLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

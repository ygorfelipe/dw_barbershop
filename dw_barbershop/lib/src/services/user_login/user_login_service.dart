import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';

import '../../core/fp/nil.dart';

abstract interface class UserLoginService {
  //! aqui iremos adicionar um nill pois ele não ira retornar nada
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}

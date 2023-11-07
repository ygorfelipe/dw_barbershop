import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

import '../../core/exceptions/auth_exception.dart';

abstract interface class UserRepository {
  //* metodo de login
  //! aqi o metodo é future de Either...
  //! onde que tem 2 retorno Err ou Success.. Sendo assim a Exception é o erro e a String seria o accessToken do login
  //! aqui não é uma Exception simples, onde nós iremos tratar os erros dessa exception
  //! e assim fazemos os tratamentos devido dos erros
  //! e temos uma classe especifica para isso, e é possivel criar varias exceptions
  //! aqui é apenas AuthException.. onde temos erro generico ou unautorized
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
}

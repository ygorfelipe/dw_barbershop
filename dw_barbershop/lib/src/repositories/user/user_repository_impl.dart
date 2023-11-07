import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });
      //* aqui eu estou trabalhando com destructors, onde que se retornou Success no login
      //* eu estou pegando o Response(:data) e pegando o ['access_token'] do response
      return Success(data['access_token']);
    } on DioException catch (e, s) {
      //! verificando o tipo do erro
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha Invalidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar Login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.post('/me');
      //! precisamos saber qual é a requisição...
      //! ou ele é ADM ou EMPLOYEEE, vendo pelo nosso payload no profile ele vem ADM ou employee
      //NOTA
      //* poderiamos utilizar ele fazendo aqui dentro do repository, porém iremos fazer tudo isso lá no userModel
      //* toda essa verificação de se ele é ADM ou employee
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      //! tratando os dois erros pois pode vir um ArgumentError lá do userModel
      log('Erro invalid json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';

import 'package:dw_barbershop/src/model/barbershop_model.dart';

import 'package:dw_barbershop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({required this.restClient});
  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBabershop(
      UserModel userModel) async {
    //! identificando qual é o tipo do usuário que esta vindo
    switch (userModel) {
      case UserModelADM():
        //! buscando a barbearia pelo usuário logado primeiro
        //! mandando o user_id para podermos pegar os dados do usuário
        //! essa forma que estamo fazendo utilizando o userAutRef é por conta do json_rest_server
        //! pois se houvesse um backend que recebesse o id do usuário logado seria mais simples
        //! geralmente quando o usuário esta logado nós podemos mandar o id do mesmo para o back
        //! nesse caso ele irá pegar apenas do administrador quando é do employee eu preciso passar o parametro de userId não necessaaro utilizar um queryParameters
        //! aqui como estamos pegando uma lista, estamos utilizando o destruction do dart
        //! onde que iremos pegar o primeiro objeto que encontrar... poderiamos pegar no data.first, porém utilizando o conceito do dart3
        //! é mais viavel fazer isso no proprio response
        //! estamos convertendo ele em uma List inclusive
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Success(BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }
}

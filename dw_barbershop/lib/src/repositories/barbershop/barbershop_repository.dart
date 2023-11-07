import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

abstract interface class BarbershopRepository {
  //! aqui estamos chamando o barbershopModel e passando o UserModel, pois nós iremos buscar as informações do usuário logado
  //! e verificar qual é os dados dele na barbearia
  Future<Either<RepositoryException, BarbershopModel>> getMyBabershop(
      UserModel userModel);
}

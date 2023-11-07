import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/constants/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  //! o ciclo de vida de um interceptor é o ciclo de vida de uma requisção
  //! antes da requisição, volta do backend, success or error,

  //! devemos adicionar um token de acesso para todas as requisção autenticada

  //! onRequest é antes de fazer a requisição
  //! devemos pegar os headers e o extra
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;

    //* pegar a chave para colocar no headers
    const authHeaderKey = 'Authorization';
    //! removendo do headers ele, removendo ele antes para não ter que verificar se já tem o auth ou não
    //! com isso partimos da premissia que ele já não esta autenticado
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      //! adicionando o headers
      headers.addAll({
        authHeaderKey: 'Bearer ${sp.getString(LocalStorageKeys.accessToken)}'
      });
    }

    handler.next(options);
  }
}

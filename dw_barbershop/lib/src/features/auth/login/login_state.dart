//! essa classe é obrigatória criar, pois ai quando utilizarmos ela na vm, o riverpod irá
//! definir qual é o melhor metodo para se utilizar

import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.errorMessage,
  });

  //! aqui estamos adicionando o copyWith para podermos trabalhar com os erros
  //! foi adicionado o ValueGetter para poder fazer um tratamento mais adquado para o valor null do errorMessage
  //! no momento ele pode vir null, porém se um dia eu decidir retornar um valor != null o ValueGetter será o responsavel
  //! por realizar essa conversão
  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

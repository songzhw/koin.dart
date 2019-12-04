import 'package:flutter/foundation.dart';
import 'package:koin/koin.dart';

class ScopeBuilder implements KoinComponent {
  final Qualifier scopeName;
  String id;

  ScopeBuilder({@required this.scopeName});

  Scope get scope => getScope;

  ///
  /// Get instance instance from Koin
  /// @param qualifier
  /// @param parameters
  ///
  T get<T>(Qualifier qualifier, DefinitionParameters parameters) =>
      scope.get(qualifier, parameters);

  ///
  /// Lazy inject instance from Koin
  /// @param qualifier
  /// @param parameters
  ///
  Lazy<T> inject<T>({Qualifier qualifier, List<Object> parameters}) =>
      scope.inject(
        parametersOf(parameters),
        qualifier,
      );

  ///
  /// Get instance instance from Koin by Primary Type P, as secondary type S
  /// @param parameters
  ///
  S bind<S, P>(Qualifier qualifier, DefinitionParameters parameters) =>
      getKoin().bind<S, P>(parameters);

  Scope get getScope {
    return getKoin().getScope(id);
  }

  @override
  Koin getKoin() {
    return GlobalContext.instance.get().koin;
  }

  void init() {
    id = "${"IdTest"}@${scopeName.toString()}";
    getKoin().createScope(id, scopeName);
  }

  void close() {
    getKoin().deleteScope(id);
  }
}

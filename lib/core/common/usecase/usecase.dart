abstract class FutureUseCaseWithoutParams<T> {
  const FutureUseCaseWithoutParams();

  Future<T> call();
}

abstract class FutureUseCaseWitHParams<T, Params> {
  const FutureUseCaseWitHParams();

  Future<T> call(Params params);
}
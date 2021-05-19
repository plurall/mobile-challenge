import 'package:mockito/mockito.dart';

abstract class Callable<T> {
  void call([T arg]) {}
}

class MockCallable<T> extends Mock implements Callable<T> {}

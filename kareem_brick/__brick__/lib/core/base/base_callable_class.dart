/// BaseCallableClass is an abstract class that defines a contract
/// for callable classes. It requires implementing classes to provide
/// a [call] method that takes an input of type [In] and returns an
/// output of type [Out].
abstract class BaseCallableClass<Out, In> {
  const BaseCallableClass();
  Out call(In input);
}

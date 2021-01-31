import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/core/failures.dart';
import 'package:flutter_app/domain/core/value_objects.dart';
import 'package:flutter_app/domain/core/value_validators.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

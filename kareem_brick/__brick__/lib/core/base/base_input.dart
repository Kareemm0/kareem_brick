import 'package:equatable/equatable.dart';

abstract class BaseInput extends Equatable {
  const BaseInput();
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

class RouteState extends Equatable {
  final String routeName;
  final dynamic arguments;

  RouteState({required this.routeName, this.arguments});

  @override
  List<Object?> get props => [routeName, arguments];
}

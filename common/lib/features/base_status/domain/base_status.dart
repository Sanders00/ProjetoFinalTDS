import 'package:equatable/equatable.dart';

class BaseStatusEntity extends Equatable {
  final int id;
  final double totalCoin;
  final double totalCoinPerSecond;
  final double clickUpgrade;

  const BaseStatusEntity({
    required this.id,
    required this.totalCoin,
    required this.totalCoinPerSecond,
    required this.clickUpgrade,
  });

  @override
  List<Object?> get props => [id];
}

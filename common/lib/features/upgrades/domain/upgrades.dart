import 'package:equatable/equatable.dart';

class UpgradesEntity extends Equatable {
  final int id;
  final int numberOfUpgrades;

  const UpgradesEntity({
    required this.id,
    required this.numberOfUpgrades,
  });

  @override
  List<Object?> get props => [id];
}

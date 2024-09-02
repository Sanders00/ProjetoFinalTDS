import 'package:common/features/upgrades/domain/upgrades.dart';

class UpgradesModel extends UpgradesEntity {
  UpgradesModel({
    required super.id,
    required super.numberOfUpgrades,
  });

  factory UpgradesModel.fromJson(Map<String, dynamic> json) {
    return UpgradesModel(
      id: json["id"] as int,
      numberOfUpgrades: json["numberOfUpgrades"] as int,
    );
  }

  factory UpgradesModel.fromJsonWithId(Map<String, dynamic> json) {
    return UpgradesModel(
      id: json["tb_basic_status"]["id"] as int,
      numberOfUpgrades: json["tb_upgrades"]["numberOfUpgrades"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberOfUpgrades': numberOfUpgrades,
    };
  }
}

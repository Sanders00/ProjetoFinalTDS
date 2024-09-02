import 'package:common/features/base_status/domain/base_status.dart';

class BaseStatusModel extends BaseStatusEntity {
  BaseStatusModel({
    required super.id,
    required super.totalCoin,
    required super.totalCoinPerSecond,
    required super.clickUpgrade,
  });

  factory BaseStatusModel.fromJson(Map<String, dynamic> json) {
    return BaseStatusModel(
      id: json["id"] as int,
      totalCoin: json["coins"] as double,
      totalCoinPerSecond: json["coinspersecond"] as double,
      clickUpgrade: json["clickerupgrade"] as double,
    );
  }

  factory BaseStatusModel.fromJsonWithId(Map<String, dynamic> json) {
    return BaseStatusModel(
      id: json["tb_basic_status"]["id"] as int,
      totalCoin: json["tb_basic_status"]["coins"] as double,
      totalCoinPerSecond: json["tb_basic_status"]["coinspersecond"] as double,
      clickUpgrade: json["tb_basic_status"]["clickerupgrade"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clickerupgrade': clickUpgrade,
      'coinspersecond': totalCoinPerSecond,
      'coins': totalCoin,
    };
  }
}

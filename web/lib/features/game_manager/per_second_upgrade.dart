import 'package:app_tds/features/game_manager/game_manager.dart';

class CoinPerSecondUpgrade {
  final String name;
  double _upgradeCost;
  final double _coinsPerSecondBonus;
  int _upgradeLevel;

  CoinPerSecondUpgrade({
    required this.name,
    required double initialCost,
    required double coinsPerSecondBonus,
    int upgradeLevel = 0,
  })  : _upgradeCost = initialCost + upgradeLevel * 10,
        _coinsPerSecondBonus = coinsPerSecondBonus,
        _upgradeLevel = upgradeLevel;

  double get upgradeCost => _upgradeCost;
  double get coinsPerSecondBonus => _coinsPerSecondBonus;
  int get upgradeLevel => _upgradeLevel;

  void buyUpgrade() {
    if (GameManager().coins >= _upgradeCost) {
      GameManager().coins -= _upgradeCost;
      GameManager().coinsPerSecond += _coinsPerSecondBonus;
      _upgradeLevel++;
      _upgradeCost += _upgradeLevel * 10;
      GameManager().updateCoinUI();
      GameManager().updateCoinsPerSecondUI();
    }
  }
}

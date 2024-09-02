import 'package:app_tds/features/game_manager/game_manager.dart';

class ClickUpgrade {
  double _upgradeCost;
  double _coinsPerClickBonus;

  ClickUpgrade({
    double initialCost = 10.0,
    double initialBonus = 1.0,
  })  : _upgradeCost = initialCost,
        _coinsPerClickBonus = initialBonus;

  double get upgradeCost => _upgradeCost;
  double get coinsPerClickBonus => _coinsPerClickBonus;

  void buyUpgrade() {
    if (GameManager().coins >= _upgradeCost) {
      GameManager().coins -= _upgradeCost;
      GameManager().coinsPerClickUpgrade += _coinsPerClickBonus;
      _upgradeCost *= 1.2;
      _coinsPerClickBonus += 1;
      GameManager().updateCoinUI();
    }
  }
}

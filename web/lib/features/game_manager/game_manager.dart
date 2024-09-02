import 'dart:async';

import 'package:app_tds/features/game_manager/click_upgrade.dart';
import 'package:app_tds/features/game_manager/coin_display.dart';
import 'package:app_tds/features/game_manager/per_second_upgrade.dart';
import 'package:common/features/base_status/data/api/list.dart';
import 'package:common/features/base_status/data/model/base_status.dart';
import 'package:common/features/upgrades/data/api/list.dart';
import 'package:common/features/upgrades/data/model/upgrades.dart';
import 'package:flutter/material.dart';

class GameManager {
  static final GameManager _singleton = GameManager._internal();

  GameManager._internal() {
    statsFuture = getStats();
  }
  factory GameManager() {
    return _singleton;
  }

  late Future<void> statsFuture;

  late double coins = 0.0;
  late double coinsPerSecond = 0.0;
  late double coinsPerClickUpgrade = 0.0;
  late List<int> numberOfUpgrades = [];

  final ClickUpgrade clickUpgrade = ClickUpgrade();
  List<CoinPerSecondUpgrade> coinPerSecondUpgrades = [];

  Future<void> getStats() async {
    List<BaseStatusModel> baseStatus =
        await BaseStatusRemoteAPIDataSource().getBaseStatus();
    List<UpgradesModel> upgrades =
        await UpgradesRemoteAPIDataSource().getUpgrades();
    try {
      coins = baseStatus[0].totalCoin;
      coinsPerSecond = baseStatus[0].totalCoinPerSecond;
      coinsPerClickUpgrade = baseStatus[0].clickUpgrade;

      numberOfUpgrades = upgrades.map((e) => e.numberOfUpgrades).toList();

      coinPerSecondUpgrades = [
        CoinPerSecondUpgrade(
          name: "Melhoria 1",
          initialCost: 50.0,
          coinsPerSecondBonus: 1.0,
          upgradeLevel: numberOfUpgrades[0],
        ),
        CoinPerSecondUpgrade(
            name: "Melhoria 2",
            initialCost: 200.0,
            coinsPerSecondBonus: 5.0,
            upgradeLevel: numberOfUpgrades[1]),
        CoinPerSecondUpgrade(
            name: "Melhoria 3",
            initialCost: 500.0,
            coinsPerSecondBonus: 10.0,
            upgradeLevel: numberOfUpgrades[2]),
        CoinPerSecondUpgrade(
            name: "Melhoria 4",
            initialCost: 2000.0,
            coinsPerSecondBonus: 100.0,
            upgradeLevel: numberOfUpgrades[3]),
        CoinPerSecondUpgrade(
            name: "Melhoria 5",
            initialCost: 5000.0,
            coinsPerSecondBonus: 150.0,
            upgradeLevel: numberOfUpgrades[4]),
        CoinPerSecondUpgrade(
            name: "Melhoria 6",
            initialCost: 10000.0,
            coinsPerSecondBonus: 1000.0,
            upgradeLevel: numberOfUpgrades[5]),
      ];

      updateCoinUI();
      updateCoinsPerSecondUI();
    } catch (e) {
      coins = 0.0;
      coinsPerSecond = 0.0;
      coinsPerClickUpgrade = 0.0;
    }
  }

  ValueNotifier<String> coinsNotifier = ValueNotifier<String>("0");
  ValueNotifier<String> coinsPerSecondNotifier = ValueNotifier<String>("0");

  void updateCoinUI() {
    CoinDisplay.updateCoinDisplay(coins, (String newValue) {
      coinsNotifier.value = newValue;
    });
  }

  void updateCoinsPerSecondUI() {
    CoinDisplay.updateCoinDisplay(coinsPerSecond, (String newValue) {
      coinsPerSecondNotifier.value = newValue;
    });
  }

  void onClickCoin() {
    coins += 1 + coinsPerClickUpgrade;
    updateCoinUI();
  }

  void coinTick() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        coins += coinsPerSecond;
        updateCoinUI();
      },
    );
  }

  void saveTick(Function onSaved) {
    Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        onSaved();
        saveBaseStatus();
        saveUpgrades();
      },
    );
  }

  void saveBaseStatus() {
    BaseStatusRemoteAPIDataSource().updateBaseStatus(
        coins: coins,
        coinspersecond: coinsPerSecond,
        clickerupgrade: coinsPerClickUpgrade);
  }

  void saveUpgrades() {
    for (int i = 0; i < coinPerSecondUpgrades.length; i++) {
      UpgradesRemoteAPIDataSource().updateUpgrades(
        id: i,
        numberOfUpgrades: coinPerSecondUpgrades[i].upgradeLevel,
      );
    }
  }

  void buyUpgrade() {
    clickUpgrade.buyUpgrade();
  }

  void buyCoinPerSecondUpgrade(int index) {
    if (index < coinPerSecondUpgrades.length) {
      coinPerSecondUpgrades[index].buyUpgrade();
    }
  }
}

import 'package:animated_background/animated_background.dart';
import 'package:app_tds/features/game_manager/game_manager.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final GameManager gameManager = GameManager();

  @override
  void initState() {
    gameManager.coinTick();
    gameManager.saveTick(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jogo salvo com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey.shade900,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: AnimatedBackground(
                behaviour: RandomParticleBehaviour(
                  options: ParticleOptions(
                    spawnMinRadius: 5,
                    spawnMaxRadius: 30,
                    image: Image.asset("assets/images/coin.png"),
                  ),
                ),
                vsync: this,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<String>(
                      valueListenable: gameManager.coinsNotifier,
                      builder: (context, coinsString, _) {
                        return Text(
                          "Moedas: $coinsString",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder<String>(
                        valueListenable: gameManager.coinsPerSecondNotifier,
                        builder: (context, coinsPerSecondString, _) {
                          return Text("$coinsPerSecondString MPS",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold));
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ScaleButton(
                      duration: const Duration(milliseconds: 10),
                      onTap: () {
                        gameManager.onClickCoin();
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment.center,
                        child: Image.asset("assets/images/coin.png",
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.brown,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Melhorar Clique:"),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onPressed: gameManager.coins >=
                                gameManager.clickUpgrade.upgradeCost
                            ? () {
                                setState(() {
                                  gameManager.buyUpgrade();
                                });
                              }
                            : null,
                        child: Text(
                            "Comprar Melhoria de Clique (${gameManager.clickUpgrade.upgradeCost.toStringAsFixed(0)} moedas)"),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text("Melhorar Moedas por segundo:"),
                      Expanded(
                          child: FutureBuilder<void>(
                        future: gameManager.statsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.amber,
                            ));
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Erro ao carregar upgrades'));
                          } else {
                            return ListView.builder(
                              itemCount:
                                  gameManager.coinPerSecondUpgrades.length,
                              itemBuilder: (context, index) {
                                final upgrade =
                                    gameManager.coinPerSecondUpgrades[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: gameManager.coinsNotifier,
                                    builder: (context, coinsString, _) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey.shade800,
                                          foregroundColor: Colors.white,
                                          shape: const StadiumBorder(),
                                          minimumSize:
                                              const Size.fromHeight(50),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                        ),
                                        onPressed: gameManager.coins >=
                                                upgrade.upgradeCost
                                            ? () {
                                                setState(() {});
                                                gameManager
                                                    .buyCoinPerSecondUpgrade(
                                                        index);
                                              }
                                            : null,
                                        child: Text(
                                          "${upgrade.name} - Custo: ${upgrade.upgradeCost.toStringAsFixed(0)} moedas - Bônus: +${upgrade.coinsPerSecondBonus.toStringAsFixed(0)} MPS - Nível: ${upgrade.upgradeLevel}",
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

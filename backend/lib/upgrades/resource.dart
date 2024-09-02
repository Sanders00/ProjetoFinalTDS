import 'package:dart_server/upgrades/api/get_upgrades.dart';
import 'package:dart_server/upgrades/api/update_upgrades.dart';
import 'package:shelf_modular/shelf_modular.dart';

class UpgradesResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get("/upgrades", getUpgrades),
        Route.put("/upgrades", updateUpgrades),
      ];
}

import 'package:dart_server/base_status/resource.dart';
import 'package:dart_server/upgrades/resource.dart';
import 'package:hasura_connect/hasura_connect.dart' hide Response;
import 'package:shelf_modular/shelf_modular.dart';
import 'package:shelf/shelf.dart';

class AppModule extends Module {
  final String hasuraServerURL;
  final String hasuraGraphQLAdminSecret;

  AppModule(
      {required this.hasuraServerURL, required this.hasuraGraphQLAdminSecret});

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HasuraConnect(hasuraServerURL,
            headers: {'x-hasura-admin-secret': hasuraGraphQLAdminSecret})),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', () => Response.ok('funcionando')),
        Route.resource(BaseStatusResource()),
        Route.resource(UpgradesResource()),
      ];
}

import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getUpgrades(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query getUpgrades {
        tb_upgrades(order_by: {id: asc}) {
          id
          numberOfUpgrades
        }
      }
      ''');
  return Response.ok(jsonEncode(hasuraResponse['data']));
}

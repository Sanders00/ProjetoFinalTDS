import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateUpgrades(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
  mutation updateUpgrades($numberOfUpgrades: Int!, $_eq: Int!) {
      update_tb_upgrades(where: {id: {_eq: $_eq}}, _set: {numberOfUpgrades: $numberOfUpgrades}) {
    affected_rows
  }
}
      ''', variables: {
    '_eq': arguments.data['id'],
    'numberOfUpgrades': arguments.data['numberOfUpgrades'],
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']),
      );
    },
  );
}

import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> updateBaseStatus(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  return hasuraConnect.mutation(r'''
  mutation updateBaseStats($clickerupgrade: Float!, $coins: Float!, $coinspersecond: Float!) {
    update_tb_basic_status(where: {id: {_eq: 0}}, _set: {coinspersecond: $coinspersecond, coins: $coins, clickerupgrade: $clickerupgrade}) {
      affected_rows
    }
  }
      ''', variables: {
    'coins': arguments.data['coins'],
    'clickerupgrade': arguments.data['clickerupgrade'],
    'coinspersecond': arguments.data['coinspersecond'],
  }).then(
    (value) {
      return Response.ok(
        jsonEncode(value['data']),
      );
    },
  );
}

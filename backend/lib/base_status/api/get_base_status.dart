import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart' hide Request, Response;
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

Future<Response> getBaseStatus(
  Request request,
  Injector injector,
  ModularArguments arguments,
) async {
  final hasuraConnect = injector.get<HasuraConnect>();

  var hasuraResponse = await hasuraConnect.query('''
      query GetBaseStatus {
        tb_basic_status {
          id
          coins
          clickerupgrade
          coinspersecond
        }
      }

      ''');
  return Response.ok(jsonEncode(hasuraResponse['data']));
}

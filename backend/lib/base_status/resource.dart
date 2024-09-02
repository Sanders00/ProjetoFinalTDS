import 'package:dart_server/base_status/api/get_base_status.dart';
import 'package:dart_server/base_status/api/update_base_status.dart';
import 'package:shelf_modular/shelf_modular.dart';

class BaseStatusResource extends Resource {
  @override
  List<Route> get routes => [
      Route.get('/base_status', getBaseStatus),
      Route.put('/base_status', updateBaseStatus),
      ];
}

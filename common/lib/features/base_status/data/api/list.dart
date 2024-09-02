import 'dart:convert';

import 'package:common/features/base_status/data/model/base_status.dart';
import 'package:http/http.dart' as http;

class BaseStatusRemoteAPIDataSource {
  Future<List<BaseStatusModel>> getBaseStatus() async {
    var client = http.Client();
    final result = <BaseStatusModel>[];
    try {
      final response = await client.get(
        Uri.parse(
          'http://192.168.56.1:4000/base_status',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        var bodyResult = json.decode(response.body);
        bodyResult['tb_basic_status'].forEach((element) {
          result.add(BaseStatusModel.fromJson(element));
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<BaseStatusModel?> updateBaseStatus({
    required double coins,
    required double clickerupgrade,
    required double coinspersecond,
  }) async {
    final response = await http.put(
      Uri.parse(
        'http://192.168.56.1:4000/base_status',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'coins': coins,
        'clickerupgrade': clickerupgrade,
        'coinspersecond': coinspersecond,
      }),
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return BaseStatusModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

//   Future<List<WorkerModel>> getWorkersMinusActivity() async {
//     var client = http.Client();
//     final result = <WorkerModel>[];
//     try {
//       final response = await client.get(
//         Uri.parse(
//           'http://192.168.56.1:4000/workers_minus_activity',
//         ),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         var bodyResult = json.decode(response.body);
//         bodyResult['workers'].forEach((element) {
//           result.add(WorkerModel.fromJson(element));
//         });
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//     return result;
//   }

//   Future<List<WorkerModel>> getWorkersMinusWorkGroup() async {
//     var client = http.Client();
//     final result = <WorkerModel>[];
//     try {
//       final response = await client.get(
//         Uri.parse(
//           'http://192.168.56.1:4000/workers_minus_work_group',
//         ),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       if (response.statusCode == 200 && response.body.isNotEmpty) {
//         var bodyResult = json.decode(response.body);
//         bodyResult['workers'].forEach((element) {
//           result.add(WorkerModel.fromJson(element));
//         });
//       }
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//     return result;
//   }

//   Future<WorkerModel?> postWorkers({
//     required String name,
//     required String email,
//     required String phone,
//     required String whatsapp,
//   }) async {
//     final response = await http.post(
//       Uri.parse(
//         'http://192.168.56.1:4000/workers',
//       ),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<dynamic, dynamic>{
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'whatsapp': whatsapp,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return WorkerModel.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load workers');
//     }
//   }

//   Future deleteWorkers({
//     required int id,
//   }) async {
//     final response = await http.delete(
//       Uri.parse(
//         'http://192.168.56.1:4000/workers',
//       ),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<dynamic, dynamic>{
//         'id': id,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return;
//     } else {
//       throw Exception('Failed to delete workers');
//     }
//   }

//   Future<WorkerModel?> updateWorkers({
//     required int id,
//     required String name,
//     required String email,
//     required String phone,
//     required String whatsapp,
//   }) async {
//     final response = await http.put(
//       Uri.parse(
//         'http://192.168.56.1:4000/workers',
//       ),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<dynamic, dynamic>{
//         'id': id,
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'whatsapp': whatsapp,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return WorkerModel.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to update workers');
//     }
//   }
}

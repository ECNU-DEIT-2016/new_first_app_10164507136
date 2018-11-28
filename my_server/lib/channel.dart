import 'my_server.dart';
import 'dart:math';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class MyServerChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/

  
    router
      .route("/users/[:id]").link(()=>MyController());   

    return router;
  }
}
class MyController extends ResourceController {
  final List<String> things = ['陈瑶', '朱子恒','周嘉翔','唐莉雯','张静雅','龙晶毅','朱鹏伟','戚晓颖','郑可欣','李典康','吴松二','蔡心蕊','赵世宇'];
  

  @Operation.get()
  Future<Response> getThings() async {
    return Response.ok(things[getRandomNum()]);
  }

  @Operation.get('id')
  Future<Response> getThing(@Bind.path('id') int id) async {
    if (id < 0 || id >= things.length) {
      return Response.notFound();
    }
    return Response.ok(things[id]);
  }

  int getRandomNum(){
    var random=Random();
    int number=random.nextInt(13);
    return number;
  }
}
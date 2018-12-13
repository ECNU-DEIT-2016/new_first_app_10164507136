import 'my_server.dart';
import 'dart:math';
import 'package:sqljocky5/sqljocky.dart';
import 'dart:async';

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

    router  
      .route("/random/[:id]").link(()=>RandomController());

    return router;
  }
}

class RandomController extends ResourceController{

    final List<String> things = ['陈瑶', '朱子恒','周嘉翔','唐莉雯','张静雅','龙晶毅','朱鹏伟','戚晓颖','郑可欣','李典康','吴松二','蔡心蕊','赵世宇'];
  List<String> Items=[];

  @Operation.get()
  Future<Response> getThings() async {
    var s = ConnectionSettings(
    user: "deit2016",
    password: "deit2016@ecnu",
    host: "www.muedu.org",
    port: 3306,
    db: "deit2016db_10164507136",
  );
    print("Opening connection ...");
  var conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  // Items.add(things[getRandomNum()]);
    await connected(conn,Items);
    Random random=new Random();
    int num=random.nextInt(Items.length);
    return Response.ok(Items[num]);
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

class MyController extends ResourceController {
  final List<String> things = ['陈瑶', '朱子恒','周嘉翔','唐莉雯','张静雅','龙晶毅','朱鹏伟','戚晓颖','郑可欣','李典康','吴松二','蔡心蕊','赵世宇'];
  List<String> Items=[];

  @Operation.get()
  Future<Response> getThings() async {
    var s = ConnectionSettings(
    user: "deit2016",
    password: "deit2016@ecnu",
    host: "www.muedu.org",
    port: 3306,
    db: "deit2016db_10164507136",
  );
    print("Opening connection ...");
  var conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  // Items.add(things[getRandomNum()]);
    await connected(conn,Items);
    String output="";
    for(int i=0;i<Items.length;i++){
      output=output+Items[i]+"              ";
    }
    //print(output);
    return Response.ok(output);
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

  Future<void> connected(MySqlConnection conn, List Items) async{
    
   Results results = await conn.execute('select name, email from users');
   results.forEach((Row row) {
     Items.add('Name:${row[0]} email:${row[1]}');
     //Items.add('email: ${row[1]}');
     
  //print('Name: ${row[0]}, email: ${row[1]}');
  //print('Name: ${row.name}, email: ${row.email}');
});
  await conn.close();
  }
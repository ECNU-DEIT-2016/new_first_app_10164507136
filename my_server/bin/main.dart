import 'package:my_server/my_server.dart';

String _host = InternetAddress.loopbackIPv4.host;
String path = 'file.txt';

Map jsonData = {
  'name': 'Han Solo',
  'job': 'reluctant hero',
  'BFF': 'Chewbacca',
  'ship': 'Millennium Falcon',
  'weakness': 'smuggling debts'
};

Future main() async {
  final app = Application<MyServerChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8006;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
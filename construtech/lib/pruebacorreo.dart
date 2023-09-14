import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  Mailer() async {
  
  String username = 'yeisonpl2017@gmail.com'; //Aqui iria su correo personal
  String password = 'bbiuqpqtolubbmym'; //Contraseña de aplicaciones

  final smtpServer = gmail(username, password);


  final message = Message()
    ..from = Address(username, 'Automatico')
    ..recipients.add('ortizronald623@gmail.com') //Correo al cual se enviara el mensaje
    ..ccRecipients.addAll(['ortizronald623@gmail.com','yeisonpl2017@gmail.com']) //CC (creo que son como los correos a los que sera enviado el mensaje la verdad no tengo ni puta idea de que sea)
    ..bccRecipients.add(const Address('ortizronald623@gmail.com')) //Aqui va el correo principal o correos a los que quieran ser enviados
    ..subject = 'MMGVOOOOOOOO, nos enseñaron a enviar mensajes automaticos XD :: 😀 :: ${DateTime.now()}' //Asunto del correo
    ..text = 'Este es un mensaje de prueba.' //Este no se que sea porque no nos explico muy bien al verdad XD
    ..html = "Hola aqui se esta validando un mensaje de prueba"; //Cuerpo del correo

  try {
    final sendReport = await send(message, smtpServer);
    // ignore: avoid_print
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
 
  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // send the equivalent message
  

  // close the connection
  await connection.close();
}
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: null,
            child: const Text('Disabled'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {Mailer();},
            child: const Text('Enviar Mensaje'),
          ),
        ],
      ),
    );
  }
}
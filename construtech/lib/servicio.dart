import 'package:flutter/material.dart';
import 'package:construtech/cardService.dart';
import 'package:construtech/databasehelper.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ServicioPage extends StatefulWidget {
  const ServicioPage({super.key, required this.title});

  final String title;

  @override
  State<ServicioPage> createState() => _ServicioPageState();
}

class _ServicioPageState extends State<ServicioPage> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final nombreController = TextEditingController();
  final apellidosController = TextEditingController();
  final fechaController = TextEditingController();
  final tipoServController = TextEditingController();
  final telefonoController = TextEditingController();
  final municipioController = TextEditingController();
  final direccionController = TextEditingController();
  final emailController = TextEditingController();
  List<String> listaServicios = [
    "Estuco",
    "Pintura",
    "Herreria",
    "Carpinteria",
    "Fontaneria"
  ];
  List<String> listaMunicipios = [
    "Medellín",
    "Bello",
    "Itagüi",
    "Envigado",
    "Copacabana",
    "Girardota",
    "Barbosa"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: const Text(
          "Solicitar cita",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('', style: TextStyle(color: Colors.indigo)),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Color.fromARGB(255, 198, 198, 198),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (value!.isEmpty) {
                              return "El correo es requerido";
                            } else if (!regExp.hasMatch(value)) {
                              return "Correo invalido";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: TextFormField(
                            controller: nombreController,
                            decoration: const InputDecoration(
                                hintText: 'Nombre',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "El nombre es requerido";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: apellidosController,
                            decoration: const InputDecoration(
                                hintText: 'Apellidos',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Los apellidos son requeridos";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 1),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'selecione una fecha para la visita',
                              hintStyle: TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Color.fromARGB(255, 198, 198, 198),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          controller: fechaController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2300),
                            );

                            if (pickedDate != null) {
                              fechaController.text = pickedDate.toString();
                            }
                            if (pickedDate != null) {
                              fechaController.text =
                                  DateFormat('dd MMMM yyyy').format(pickedDate);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: DropdownButtonFormField(
                          items: listaServicios.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) {
                            tipoServController.text = value!;
                          },
                          isDense: true,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_circle_down_sharp),
                          iconSize: 25,
                          decoration: const InputDecoration(
                              hintText: 'Seleccione un servicio',
                              hintStyle: TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Color.fromARGB(255, 198, 198, 198),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: telefonoController,
                            decoration: const InputDecoration(
                                hintText: 'Telefono',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "El telefono es requerido";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Antioquia',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            enabled: false,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: DropdownButtonFormField(
                          items: listaMunicipios.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) {
                            municipioController.text = value!;
                          },
                          isDense: true,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_circle_down_sharp),
                          iconSize: 25,
                          decoration: const InputDecoration(
                              hintText: 'Seleccione un municipio',
                              hintStyle: TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Color.fromARGB(255, 198, 198, 198),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: direccionController,
                            decoration: const InputDecoration(
                                hintText: 'Dirección',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "La dirección es requerida";
                              } else {
                                return null;
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.purple,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Servicio solicitado con exito!",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ],
                                      ),
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      width: 300,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 12, 195, 106),
                                    ));
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const cardService()),
                                    );
                                  }
                                  await DatabaseHelper.instance.add(
                                    Servicios(
                                      nombre: nombreController.text,
                                      apellido: apellidosController.text,
                                      direccion: direccionController.text,
                                      fecha: fechaController.text,
                                      municipio: municipioController.text,
                                      telefono: telefonoController.text,
                                      tipoServ: tipoServController.text,
                                    ),
                                  );
                                  Mailer(
                                      email: emailController.text,
                                      nombre: nombreController.text,
                                      tipoServ: tipoServController.text,
                                      fecha: fechaController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black, // background (button) color
                                  foregroundColor:
                                      Colors.white, // foreground (text) color
                                ),
                                child: const Text('Solicitar')),
                          )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Mailer(
    {required email,
    required nombre,
    required tipoServ,
    required fecha}) async {
  String username = 'yeisonpl2017@gmail.com'; //Aqui iria su correo personal
  String password = 'bbiuqpqtolubbmym'; //Contraseña de aplicaciones

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Constru-tech')
    ..recipients.add(email) //Correo al cual se enviara el mensaje
    ..subject = 'Hola $nombre' //Asunto del correo
    ..html =
        "Confirmamos tu cita de $tipoServ, el dia $fecha"; //Cuerpo del correo

  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // send the equivalent message

  // close the connection
  await connection.close();
}

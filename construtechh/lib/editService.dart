import 'package:construtechh/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:construtechh/cardService.dart';
import 'package:intl/intl.dart';


class EditService extends StatefulWidget {
  const EditService({
    super.key,
    required this.id,
    // required this.email,
    required this.nombre,
    required this.apellido,
    required this.fecha,
    required this.tipoServ,
    required this.telefono,
    required this.municipio,
    required this.direccion,
  });
  final String nombre;
  final String apellido;
  final int? id;
  final String fecha;
  final String tipoServ;
  final String telefono;
  final String municipio;
  final String direccion;

  @override
  State<EditService> createState() => _EditService();
}

class _EditService extends State<EditService> {
  final _formKey = GlobalKey<FormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var nombreController = TextEditingController();
  var apellidosController = TextEditingController();
  var fechaController = TextEditingController();
  late String tipoServController ;
  var telefonoController = TextEditingController();
  var municipioController = TextEditingController();
  var direccionController = TextEditingController();
  var emailController = TextEditingController();
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
          "Editar cita",
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
                            controller: nombreController =
                                TextEditingController(text: widget.nombre),
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
                            controller: apellidosController =
                                TextEditingController(text: widget.apellido),
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
                          controller: fechaController =
                              TextEditingController(text: widget.fecha),
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
                          value: widget.tipoServ,
                          items: listaServicios.map((String tipoServ) {
                            return DropdownMenuItem(
                                value: tipoServ, child: Text(tipoServ));
                          }).toList(),
                          onChanged: (value) {
                            tipoServController = value!;
                          },
                          onSaved: (newValue) {
                            tipoServController = widget.tipoServ;
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
                            controller: telefonoController =
                                TextEditingController(text: widget.telefono),
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
                        value: widget.municipio,
                          items: listaMunicipios.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onSaved: (municipio) {
                            municipioController =
                                TextEditingController(text: widget.municipio);
                          },
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
                            controller: direccionController =
                                TextEditingController(text: widget.direccion),
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
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Cita actualizada con exito!",
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
                                  
                                  await DatabaseHelper.instance.update(
                                    nombre: nombreController.text,
                                    apellido: apellidosController.text,
                                    direccion: direccionController.text,
                                    fecha: fechaController.text,
                                    municipio: municipioController.text,
                                    telefono: telefonoController.text,
                                    tipoServ: tipoServController,
                                    id: widget.id,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black, // background (button) color
                                  foregroundColor:
                                      Colors.white, // foreground (text) color
                                ),
                                child: const Text('Guardar')),
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

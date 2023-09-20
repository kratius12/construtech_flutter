// ignore: file_names
import 'package:flutter/material.dart';
import 'package:construtechh/databasehelper.dart';
import 'package:construtechh/miperfil.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key, required this.title});

  final String title;

  @override
  State<EditUser> createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final emailController = TextEditingController();
  final newCorreoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        title: const Column(
          children: [
            Center(
              child: Text(
                'Actualizar información del usuario',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: newCorreoController,
                            decoration: const InputDecoration(
                                hintText: 'Nuevo correo',
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
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: nombreController,
                            decoration: const InputDecoration(
                                hintText: 'Nombre',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                fillColor: Color.fromARGB(255, 198, 198, 198),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.solid),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {});
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: apellidoController,
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
                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor digite su apellido';
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
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MiPerfil(
                                                  title: "mi perfil",
                                                )));
                                  } await DatabaseHelper.updateUser(
                                        email: emailController.text,
                                        newEmail: newCorreoController.text,
                                        nombre: nombreController.text,
                                        apellidos: apellidoController.text);
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

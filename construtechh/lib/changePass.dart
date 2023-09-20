import 'package:flutter/material.dart';
import 'package:construtechh/databasehelper.dart';
import 'package:construtechh/miperfil.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key, required this.title});

  final String title;

  @override
  State<ChangePass> createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  var contraController = TextEditingController();
  final confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: const Text("Mi perfil"),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
            } else {
              scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      ' Cambiar contraseña',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Confirme su correo',
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
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese su contraseña actual',
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
                                return 'Por favor ingrese su contraseña';
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
                            controller: contraController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Ingrese la nueva contraseña',
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
                                return 'Por favor digite la nueva contraseña';
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: confirmController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Confirme su nueva contraseña',
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
                                  r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                              RegExp regExp = RegExp(pattern);
                              if (value!.isEmpty) {
                                return "La contraseña es requerida";
                              }
                              if (!regExp.hasMatch(value)) {
                                return "La contraseña debe tener al menos 8 caracteres, 1 letra mayúscula, 1 minúscula y 1 número y debe contener caracteres especiales.";
                              }
                              if (value.length <= 10) {
                                return 'La contraseña debe tener al menos 10 caracteres';
                              }
                              if (value.length >= 20) {
                                return 'La contraseña no debe de tener más de 20 caracteres.';
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MiPerfil(
                                                    title: "Mi perfil ")));
                                    await DatabaseHelper.updatePassword(
                                        email: emailController.text,
                                        newPassword: contraController.text);
                                  }
                                },style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black, // background (button) color
                                  foregroundColor:
                                      Colors.white, 
                                  ),
                                child: const Text('Guardar Cambios')),
                          ))
                    ]),
                  )
                ])),
      ),
    );
  }
}

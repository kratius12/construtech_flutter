import 'package:flutter/material.dart';
import 'package:construtechh/cardService.dart';
import 'package:construtechh/databasehelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
          '                      INICIAR SESIÓN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrange),
                ),
              ),
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
                              } else if (value.isEmpty) {
                                return null;
                              } else {
                                return null;
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                hintText: 'Contraseña',
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
                                return "La contraseña es requerida";
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
                                    await DatabaseHelper.instance.login(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        ?
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const cardService()))
                                        :
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Usuario o constraseña incorrecto",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ],
                                            ),
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            width: 300,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 10),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 0, 0),
                                          ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black, // background (button) color
                                  foregroundColor:
                                      Colors.white, // foreground (text) color
                                ),
                                child: const Text('Enviar')),
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

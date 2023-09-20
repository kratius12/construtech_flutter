// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:construtechh/cardService.dart';
import 'package:construtechh/main.dart';
import 'package:construtechh/miperfil.dart';

// ignore: camel_case_types
class cardObra extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  cardObra({super.key});
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  height: 110,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://i.imgur.com/SWKzz9n.png", ),
                      fit: BoxFit.contain,
                    )
                  ),
                ),
                
              ),
              ListTile(
                  leading: const Icon(Icons.person_2_outlined),
                  title: const Text('Mi perfil'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MiPerfil(
                                  title: "Mi perfil",
                                )));
                  }),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('Citas'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const cardService()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Obras y tiempos'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => cardObra()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  (Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageApp(
                                title: "Pagina de inicio",
                              ))));
                },
              )
            ],
          ),
        ),
        body: const Center(
            child: Card(
                child:
                    ListTile(
                      leading: Icon(
                        Icons.album,
                        color: Colors.green,
                      ),
                      title: Text("Estuco y pintura"),
                      subtitle: Text("Kevin Castrillon\n 2 dias\n en proceso"),
                    ))));
  }
}

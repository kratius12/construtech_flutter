// ignore_for_file: file_names
import 'package:construtechh/detailsService.dart';
import 'package:flutter/material.dart';
import 'package:construtechh/carObra.dart';
import 'package:construtechh/databasehelper.dart';
import 'package:construtechh/editService.dart';
import 'package:construtechh/main.dart';
import 'package:construtechh/miperfil.dart';
import 'package:construtechh/servicio.dart';
import 'package:construtechh/usuarios.dart';

// ignore: camel_case_types
class cardService extends StatefulWidget {
  const cardService({super.key});

  @override
  State<cardService> createState() => _cardServiceState();
}

// ignore: camel_case_types
class _cardServiceState extends State<cardService> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late int selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: const Text("Citas agendadas"),
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
                  image: NetworkImage(
                    "https://i.imgur.com/SWKzz9n.png",
                  ),
                  fit: BoxFit.contain,
                )),
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
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CardUser()));
              },
            ),
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
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: DatabaseHelper.getServices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }
            List<Servicios>? servicio = snapshot.data;
            Widget list;
            if (servicio == null || servicio.isEmpty) {
              list = const Text(
                "No hay ninguna cita agendada",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              );
            } else {
              list = ListView.builder(
                itemCount: servicio.length,
                itemBuilder: (context, index) {
                  var s = servicio[index];
                  int? selectedId = s.id;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(children: [
                        const Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.album,
                            color: Colors.green,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${s.nombre} ${s.apellido}"),
                            Text(s.fecha),
                            Text(s.tipoServ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => EditService(
                                                id: selectedId,
                                                nombre: s.nombre,
                                                apellido: s.apellido,
                                                direccion: s.direccion,
                                                fecha: s.fecha,
                                                municipio: s.municipio,
                                                telefono: s.telefono,
                                                tipoServ: s.tipoServ,
                                              ))));
                                },
                                icon: const Icon(Icons.calendar_month)),
                            IconButton(
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              super.widget)));
                                  await DatabaseHelper.remove(id: s.id);
                                },
                                icon: const Icon(Icons.cancel)),
                            IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => DetailService(
                                                id: selectedId,
                                              ))));
                                },
                                icon: const Icon(Icons.remove_red_eye))
                          ],
                        )
                      ]),
                    ),
                  );
                },
              );
            }
            return Center(child: SizedBox(width: 350, child: list));
          },
        ),
      ),
      floatingActionButton: const Bottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class Bottom extends StatelessWidget {
  const Bottom({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 16),
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ServicioPage(title: "Servicio Page")));
          },
          label: const Text('Agendar'),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

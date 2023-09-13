import 'package:flutter/material.dart';
import 'package:construtech/carObra.dart';
import 'package:construtech/cardService.dart';
import 'package:construtech/changePass.dart';

import 'package:construtech/editUser.dart';
import 'package:construtech/main.dart';

class MiPerfil extends StatefulWidget {
  const MiPerfil({super.key, required this.title});

  final String title;

  @override
  State<MiPerfil> createState() => _MiPerfil();
}

class _MiPerfil extends State<MiPerfil> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        title: const Text("Cambiar información de perfil"),
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
      
     body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => 
                    const ChangePass(title: "Cambiar contraseña")
                    ));
                },
                label: const Text('cambiar contraseña'),
              ),
              const SizedBox(height: 50), // Espacio vertical entre los botones
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>
                  const EditUser(title: "editar usuario")
                  )
                  );


                },
                label: const Text('Actualizar información de usuario'),
              ),
            ],
          ),
        ),     
    );
}
}

class Bottom1 extends StatelessWidget {
  const Bottom1({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                           const ChangePass(title: 'Cambiar constraseña',)
                          ));
            },
            label: const Text('Cambiar contraseña'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}


class Bottom2 extends StatelessWidget {
  const Bottom2({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const EditUser(title: 'editar usuario',)
                          ));
            },
            label: const Text('Cambiar información de usuario'),
            icon: const Icon(Icons.abc_outlined),
          ),
        ],
      ),
    );
  }
}

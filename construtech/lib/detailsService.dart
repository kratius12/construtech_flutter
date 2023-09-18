
import 'package:construtech/databasehelper.dart';
import 'package:flutter/material.dart';


class DetailService extends StatefulWidget {
  const DetailService({super.key, required this.id});
  final int? id;

  @override
  State<DetailService> createState() => _DetailServiceState();
}

class _DetailServiceState extends State<DetailService> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: Text(
          "Detalle de la cita ${widget.id}",
          style: const TextStyle(color: Colors.white),
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
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${s.nombre} ${s.apellido}",),
                            const Text(''),
                            const Text(''),
                            Text(s.fecha),
                            const Text(''),
                            const Text(''),
                            Text(s.tipoServ),
                            const Text(''),
                            const Text(''),
                            Text(s.telefono),
                            const Text(''),
                            const Text(''),
                            const Text('Antioquia'),
                            const Text(''),
                            const Text(''),
                            Text(s.municipio),
                            const Text(''),
                            const Text(''),
                            Text(s.direccion)
                          ],
                        ),
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
    );
  }
}

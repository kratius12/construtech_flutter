import 'package:flutter/material.dart';

import 'localDb.dart';

class UpdateData extends StatefulWidget {
  final id;

  const UpdateData({super.key, required this.id});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: titulo,
              decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Ingresa titulo del libro',
                labelText: 'Titulo ',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
            TextFormField(
              controller: descripcion,
              decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Ingresa descripcion del libro',
                labelText: 'Descripcion ',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
            TextFormField(
              controller: fecha,
              decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Ingresa fecha publicacion del libro',
                labelText: 'Fecha del libro ',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
            TextFormField(
              controller: precio,
              decoration: const InputDecoration(
                icon: Icon(Icons.book),
                hintText: 'Ingresa precio del libro',
                labelText: 'Precio ',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
            Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    await LocalDatabase().updatebook(
                        id: widget.id,
                        titulo: titulo.text,
                        descripcion: descripcion.text,
                        fecha: fecha.text,
                        precio: precio.text);
                    await LocalDatabase().readallbooks();
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12, top: 12),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Actualizar libro',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Poopins'),
                    ),
                  ),
                )),
          ]),
        ),
      ),
    ));
  }
}

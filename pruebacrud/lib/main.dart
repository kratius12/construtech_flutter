import 'package:pruebacrud/update.dart';
import 'package:flutter/material.dart';

import 'localDb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter libros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreatePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        controller: ScrollController(),
        itemCount: TodosLosLibros.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            width: double.infinity,
            child: Row(children: [
              Text(TodosLosLibros[index]['Titulo']),
              Text(TodosLosLibros[index]['Descripcion']),
              Text(TodosLosLibros[index]['FechaP']),
              Text(TodosLosLibros[index]['Precio']),
            ]),
          );
        },
      ),
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController precio = TextEditingController();
  //final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await LocalDatabase().readallbooks();
              setState(() {});
            },
            child: Icon(Icons.refresh)),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  controller: titulo,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: 'titulo del libro',
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
                    hintText: 'descripcion del libro',
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
                    hintText: 'fecha publicacion del libro',
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
                    hintText: 'precio del libro',
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
                        await LocalDatabase().addDataLocal(
                            titulo: titulo.text,
                            descripcion: descripcion.text,
                            fecha: fecha.text,
                            precio: precio.text);
                        await LocalDatabase().readallbooks();
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12, top: 12),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Guardar libro',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Poopins'),
                        ),
                      ),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: TodosLosLibros.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 90,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(TodosLosLibros[index]['Titulo']),
                            Text(TodosLosLibros[index]['Descripcion']),
                            Text(TodosLosLibros[index]['FechaP']),
                            Text(TodosLosLibros[index]['Precio']),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UpdateData(
                                          id: TodosLosLibros[index]['id'])));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.greenAccent,
                                )),
                            IconButton(
                                onPressed: () async {
                                  await LocalDatabase().deletebook(
                                      id: TodosLosLibros[index]['id']);
                                  await LocalDatabase().readallbooks();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                )),
                          ]),
                    );
                  },
                ),
              ]),
            ),
          ),
        ));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

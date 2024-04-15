import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestortareas/GestorTareas.dart';
import 'package:gestortareas/Tarea.dart';

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
      title: 'Gestor de tareas',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gestor de tareas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Controladores de los formularios
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  // Gestión de las tareas
  GestorTareas _gestorTareas = GestorTareas();

  void anadeTarea(String name, String desc)
  {
      Tarea tarea = Tarea(name, desc, false);
      _gestorTareas.anade(tarea);
  }

  void completaTarea(int index)
  {
    this._gestorTareas.completar(index);
  }

  void desCompletaTarea(int index)
  {
    this._gestorTareas.desCompletar(index);
  }

  Tarea getAt(int index)
  {
    return this._gestorTareas.getAt(index);
  }

  int totalTareas()
  {
    return this._gestorTareas.tamano();
  }

  void borra(int index)
  {
    this._gestorTareas.elimina(this.getAt(index));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: this.totalTareas(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.greenAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              this.getAt(index).getNombre(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.purple,
                            ),
                          ),
                          Text(this.getAt(index).getDesc()),
                        ],
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: this.getAt(index).getDone(),
                            onChanged: (bool? value) {
                              setState(() {
                                if (!this.getAt(index).getDone())
                                {
                                  this.completaTarea(index);
                                } else {
                                  this.desCompletaTarea(index);
                                }
                              });
                            },
                          ),
                          ElevatedButton(
                            child: Icon(CupertinoIcons.trash),
                            onPressed: () {
                                setState((){
                                  this.borra(index);
                                });
                              },
                          ),
                        ],
                      )
                    ],
                  )
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            )
          ),
        Text(this.totalTareas().toString())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Añadir tarea'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: nombreController,
                              decoration: const InputDecoration(
                                labelText: 'Nombre de la tarea',
                                icon: Icon(CupertinoIcons.pencil),
                              ),
                            ),
                            TextFormField(
                              controller: descripcionController,
                              decoration: const InputDecoration(
                                labelText: 'Descripción',
                                icon: Icon(CupertinoIcons.doc_plaintext),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          child: Text("Añadir"),
                          onPressed: () {
                            setState(() {
                              if (nombreController.text != '')
                                {
                                  this.anadeTarea(nombreController.text, descripcionController.text);
                                  nombreController.text = '';
                                  descripcionController.text = '';
                                }
                              else
                                {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          scrollable: true,
                                          title: Text('Introduce un nombre para la tarea'),
                                        );
                                      });
                                }
                            });
                          })
                    ],
                  );
                });
          //});

        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
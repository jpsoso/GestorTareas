import 'package:flutter_test/flutter_test.dart';
import 'package:gestortareas/Tarea.dart';
import 'package:gestortareas/GestorTareas.dart';

void main()
{
  group('Tareas y gestor de tareas', (){
    late Tarea tarea;
    late GestorTareas gestor;

    setUp(() {
      tarea = new Tarea("testing", "", false);
      gestor = new GestorTareas();
      gestor.anade(tarea);
    });

    test('Añadiendo tarea', () {
      gestor.anade(tarea);
      expect(gestor.tareas.length, 2);
    });

    test('Marcando tarea como hecha', () {
      gestor.completar(0);
      expect(gestor.getAt(0).hecha, true);
    });

    test('Borrando tarea', () {
      gestor.elimina(tarea);
      expect(gestor.tareas.length, 0);
    });
  });
}
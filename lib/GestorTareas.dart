import 'package:gestortareas/Tarea.dart';

class GestorTareas {
  var tareas = [];

  void anade(Tarea tarea)
  {
    if (tarea.getNombre() != '')
    {
      tareas.add(tarea);
    }
  }

  void elimina(Tarea tarea)
  {
    tareas.remove(tarea);
  }

  void completar(int index)
  {
    if (index < tareas.length && index > -1)
    {
      var tarea = tareas[index];
      tareas.remove(tarea);
      tarea.setDone();
      tareas.add(tarea);
    }
  }

  void desCompletar(int index)
  {
    if (index < tareas.length && index > -1)
    {
      var tarea = tareas[index];
      tareas.remove(tarea);
      tarea.setUnDone();
      tareas.insert(0, tarea);
    }
  }

  Tarea getAt(int index)
  {
    Tarea toReturn = Tarea('', '', false);
    if (index < tareas.length && index > -1)
    {
      toReturn = tareas[index];
    }
    return toReturn;
  }

  int tamano()
  {
    return tareas.length;
  }
}
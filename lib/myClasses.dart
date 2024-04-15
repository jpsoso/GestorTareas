import 'dart:ffi';

class Tarea {
  bool hecha = false;
  String descripcion = '';
  String nombre = '';

  Tarea(String nombre, String descripcion, bool hecha)
  {
    this.hecha = hecha;
    this.descripcion = descripcion;
    this.nombre = nombre;
  }

  String getNombre()
  {
    return this.nombre;
  }

  String getDesc()
  {
    return this.descripcion;
  }

  bool getDone()
  {
    return this.hecha;
  }

  void setDone()
  {
    this.hecha = true;
  }

}

class GestorTareas {
  var tareas = [];

  void anade(Tarea tarea)
  {
    if (tarea.getNombre() != '' && tarea.getDesc() != '')
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
    if (index < tareas.length && index > 0)
    {
        var tarea = tareas[index];
        tareas.remove(tarea);
        tarea.setDone();
        tareas.add(tarea);
    }
  }

  Tarea getAt(int index)
  {
    Tarea toReturn = Tarea('', '', false);
    if (index < tareas.length && index > 0)
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
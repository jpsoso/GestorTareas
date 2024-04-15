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

  void setUnDone()
  {
    this.hecha = false;
  }

}
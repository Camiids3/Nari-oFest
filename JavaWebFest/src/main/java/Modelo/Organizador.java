package Modelo;

import java.util.*;

public class Organizador extends Usuario {

    private String telefonoOrganizador;
    private String descripcionOrganizador;

    public Organizador(String Nombre, int Edad, String Correo, String Contraseña) {
        super(Nombre, Edad, Correo, Contraseña, "Organizador");
    }

    public String getTelefonoOrganizador() {
        return telefonoOrganizador;
    }

    public void setTelefonoOrganizador(String telefonoOrganizador) {
        this.telefonoOrganizador = telefonoOrganizador;
    }

    public String getDescripcionOrganizador() {
        return descripcionOrganizador;
    }

    public void setDescripcionOrganizador(String descripcionOrganizador) {
        this.descripcionOrganizador = descripcionOrganizador;
    }

    public boolean crearEvento(String NombreEvento, String Fecha, String Hora, String Ubicacion, String Categoria, String Descripcion, boolean Estado, int capacidadMax) {
        Evento nuevo = new Evento(NombreEvento, Fecha, Hora, Ubicacion, Categoria, Descripcion, Estado, capacidadMax, this);
        BaseDatos.listaEventos.add(nuevo);
        return true;
    }

    public boolean borrarEvento(int IdEvento) {
        for (int i = 0; i < BaseDatos.listaEventos.size(); i++) {
            Evento e = BaseDatos.listaEventos.get(i);
            if (e.getIdEvento() == IdEvento && e.getOrganizador().equals(this)) {
                BaseDatos.listaEventos.remove(i);
                return true;

            }
        }
        return false;
    }

    public boolean actualizarEvento(int IdEvento, String nuevoNombre, String nuevaFecha, String nuevaHora, String nuevaUbicacion, String nuevaCategoria, String nuevaDescripcion, boolean nuevoEstado, int nuevaCapacidad) {
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getIdEvento() == IdEvento && e.getOrganizador().equals(this)) {
                e.setNombreEvento(nuevoNombre);
                e.setFecha(nuevaFecha);
                e.setHora(nuevaHora);
                e.setUbicacion(nuevaUbicacion);
                e.setCategoria(nuevaCategoria);
                e.setDescripcion(nuevaDescripcion);
                e.setEstado(nuevoEstado);
                e.setCapacidadMax(nuevaCapacidad);

                return true;
            }
        }
        return false;

    }

    public ArrayList<Evento> verEventosPublicados() {
        ArrayList<Evento> misEventos = new ArrayList<>();
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getOrganizador().equals(this)) {
                misEventos.add(e);
            }
        }
        return misEventos;
    }
}

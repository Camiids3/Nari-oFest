package Modelo;

import java.util.*;

public class Administrador extends Usuario {

    private ArrayList<String> accionesRealizadas;

    public Administrador(String Nombre, int Edad, String Correo, String Contraseña) {
        super(Nombre, Edad, Correo, Contraseña, "Administrador");
        this.accionesRealizadas = new ArrayList<>();

    }

    public boolean elimienarUsers(int IdUsuario) {
        for (int i = 0; i < BaseDatos.listaUsuarios.size(); i++) {
            Usuario u = BaseDatos.listaUsuarios.get(i);
            if (u.getIdUsuario() == IdUsuario) {
                BaseDatos.listaUsuarios.remove(i);
                accionesRealizadas.add("Elimino al usuario con ID " + IdUsuario);
                return true;
            }
        }
        return false;
    }

    public boolean eliminarEvento(int IdEvento) {
        for (int i = 0; i < BaseDatos.listaEventos.size(); i++) {
            Evento e = BaseDatos.listaEventos.get(i);
            if (e.getIdEvento() == IdEvento) {
                BaseDatos.listaEventos.remove(i);
                accionesRealizadas.add("Elimino evento con ID" + IdEvento);
                return true;
            }
        }
        return false;

    }

    public boolean cambiarEstado(int IdEvento, String nuevoEstadoAprobacion) {
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getIdEvento() == IdEvento) {
                e.setEstadoAprobacion(nuevoEstadoAprobacion);
                accionesRealizadas.add("Cambio estado de aprobacion a Evento con ID" + IdEvento + "a" + nuevoEstadoAprobacion);
                return true;
            }
        }
        return false;
    }
    public String verReporte(){
        return "Total Usuarios" + BaseDatos.listaUsuarios.size()+
                "\nTotal Eventos" + BaseDatos.listaEventos.size()+
                "\nAcciones Realizadas"+ accionesRealizadas.toString();
    }
}

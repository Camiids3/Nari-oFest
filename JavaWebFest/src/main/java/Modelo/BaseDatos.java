package Modelo;

import java.util.*;

public class BaseDatos {

    public static Usuario usuarioActivo = null;
    public static ArrayList<Evento> listaEventos = new ArrayList<>();

    public static ArrayList<Usuario> listaUsuarios = new ArrayList<>();

    public static void cerrarSesion() {
        usuarioActivo = null;
    }

    public static boolean eliminarEvento(int id) {
        for (int i = 0; i < listaEventos.size(); i++) {
            if (listaEventos.get(i).getIdEvento() == id) {
                listaEventos.remove(i);
                return true;
            }
        }
        return false;
    }

    public static boolean eliminarUsers(int idUser) {
        for (int i = 0; i < listaUsuarios.size(); i++) {
            if (listaUsuarios.get(i).getIdUsuario() == idUser) {
                listaUsuarios.remove(i);
                return true;

            }
        }
        return false;
    }

    public static void agregarUsuario(Usuario u) {
        listaUsuarios.add(u);
    }

    public static Usuario buscarUsuarioPorId(int id) {
        for (Usuario u : listaUsuarios) {
            if (u.getIdUsuario() == id) {
                return u;
            }
        }
        return null;
    }
}

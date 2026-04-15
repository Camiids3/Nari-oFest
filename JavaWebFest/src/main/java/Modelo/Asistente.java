package Modelo;

import java.util.*;

public class Asistente extends Usuario {

    private String UbicacionFav;
    private String CategoriaFav;
    private ArrayList<Evento> eventosGuardados;
    private int EventosAsistidos;

    public Asistente(String Nombre, int Edad, String Correo, String Contraseña) {
        super(Nombre, Edad, Correo, Contraseña, "Asistente");

        this.eventosGuardados = new ArrayList<>();
        this.EventosAsistidos = 0;
    }

    public String getUbicacionFav() {
        return UbicacionFav;
    }

    public void setUbicacionFav(String UbicacionFav) {
        this.UbicacionFav = UbicacionFav;
    }

    public String getCategoriaFav() {
        return CategoriaFav;
    }

    public void setCategoriaFav(String CategoriaFav) {
        this.CategoriaFav = CategoriaFav;
    }

    public int getEventosAsistidos() {
        return EventosAsistidos;
    }

    public boolean guardarEvento(int IdEvento) {
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getIdEvento() == IdEvento) {
                if (e.getEstadoAprobacion().equals("Aprobado") && e.isEstado()) {
                    if (!eventosGuardados.contains(e)) {
                        eventosGuardados.add(e);
                        return true;

                    }

                }
            }
        }
        return false;
    }

    public boolean asistirEvento(int IdEvento) {
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getIdEvento() == IdEvento) {
                if (e.getEstadoAprobacion().equals("Aprobado") && e.isEstado()) {
                    if (e.getListaAsistentes().size() < e.getCapacidadMax()) {
                        if (!e.getListaAsistentes().contains(this)) {
                            e.getListaAsistentes().add(this);
                            EventosAsistidos++;
                            return true;
                        }

                    }

                }
            }
        }
        return false;

    }

    public boolean quitarEvento(int IdEvento) {
        for (int i = 0; i < eventosGuardados.size(); i++) {
            if (eventosGuardados.get(i).getIdEvento() == IdEvento) {
                eventosGuardados.remove(i);
                return true;

            }

        }
        return false;
    }

    public boolean dejarDeAsistir(int IdEvento) {
        for (Evento e : BaseDatos.listaEventos) {
            if (e.getIdEvento() == IdEvento) {
                if (e.getListaAsistentes().contains(this)) {
                    e.getListaAsistentes().remove(this);
                    eventosGuardados.remove(e);

                    if (EventosAsistidos > 0) {
                        EventosAsistidos--;

                    }
                    return true;

                }

            }

        }
        return false;
    }
}

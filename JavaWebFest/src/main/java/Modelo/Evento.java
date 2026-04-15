package Modelo;

import java.util.*;

public class Evento {

    private String estadoAprobacion;
    private Usuario Organizador;
    private static int contadorEventos = 1;
    private int IdEvento;
    private String NombreEvento;
    private String Fecha;
    private String Hora;
    private String Categoria;
    private String Ubicacion;
    private String Descripcion;
    private boolean Estado;
    private int capacidadMax;
    private ArrayList<Usuario> listaAsistentes;

//Constructor
    public Evento(String NombreEvento, String Fecha, String Hora, String Categoria, String Ubicacion, String Descripcion, boolean Estado, int capacidadMax, Usuario Organizador) {
        this.IdEvento = contadorEventos;
        contadorEventos++;
        this.NombreEvento = NombreEvento;
        this.Fecha = Fecha;
        this.Hora = Hora;
        this.Categoria = Categoria;
        this.Ubicacion = Ubicacion;
        this.Descripcion = Descripcion;
        this.Estado = Estado;
        this.capacidadMax = capacidadMax;
        this.Organizador = Organizador;
        this.listaAsistentes = new ArrayList<>();
        this.estadoAprobacion = "Pendiente";

    }
//get and set

    public Usuario getOrganizador() {
        return Organizador;
    }

    public void setOrganizador(Usuario Organizador) {
        this.Organizador = Organizador;
    }

    public int getIdEvento() {
        return IdEvento;
    }

    public String getNombreEvento() {
        return NombreEvento;
    }

    public void setNombreEvento(String NombreEvento) {
        this.NombreEvento = NombreEvento;
    }

    public String getFecha() {
        return Fecha;
    }

    public void setFecha(String Fecha) {
        this.Fecha = Fecha;
    }

    public String getHora() {
        return Hora;
    }

    public void setHora(String Hora) {
        this.Hora = Hora;
    }

    public String getCategoria() {
        return Categoria;
    }

    public void setCategoria(String Categoria) {
        this.Categoria = Categoria;
    }

    public String getUbicacion() {
        return Ubicacion;
    }

    public void setUbicacion(String Ubicacion) {
        this.Ubicacion = Ubicacion;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public boolean isEstado() {
        return Estado;
    }

    public void setEstado(boolean Estado) {
        this.Estado = Estado;
    }

    public int getCapacidadMax() {
        return capacidadMax;
    }

    public void setCapacidadMax(int capacidadMax) {
        this.capacidadMax = capacidadMax;
    }

    public String getEstadoAprobacion() {
        return estadoAprobacion;
    }

    public void setEstadoAprobacion(String estadoAprobacion) {
        this.estadoAprobacion = estadoAprobacion;
    }
    public ArrayList<Usuario> getListaAsistentes() {
    return listaAsistentes;
}
    

}
